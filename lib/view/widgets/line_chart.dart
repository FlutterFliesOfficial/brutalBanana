import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class LineChartWidget extends StatefulWidget {
  final Function(String)? onTimePeriodChanged;
  String selectedTime = '1W';

  LineChartWidget({
    Key? key,
    this.onTimePeriodChanged,
    required this.selectedTime,
  }) : super(key: key);

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  List<Color> gradientColors = [
    royalFuchsia,
    primaryColor,
    royalFuchsia,
    primaryColor,
  ];

  bool showAvg = false;

  Future<List<FlSpot>> fetchDataAndConvertToFlSpot() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('dataLog').get();

    List<FlSpot> flSpots = [];

    snapshot.docs.forEach((doc) {
      double xValue = doc['time'];
      double yValue = doc['Health'];

      FlSpot flSpot = FlSpot(xValue, yValue);

      flSpots.add(flSpot);
    });

    return flSpots;
  }

  Map<String, List<FlSpot>> generateChartData(List<FlSpot> flspot_list) {
    Map<String, List<FlSpot>> chartData = {
      '1D': [],
      '1W': [],
      '1M': [],
      '1Y': [],
    };

    chartData['1D'] = flspot_list.take(24).toList();
    chartData['1W'] = flspot_list.take(3).toList();
    chartData['1M'] = flspot_list.take(30).toList();
    chartData['1Y'] = flspot_list.take(12).toList();

    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FlSpot>>(
      future: fetchDataAndConvertToFlSpot(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          List<FlSpot> flSpots = snapshot.data!;
          Map<String, List<FlSpot>> _chartData = generateChartData(flSpots);
          var selectedTime = '1M';
          List<FlSpot> currentData = _chartData[selectedTime]!;

          double maxX =
              currentData.map((spot) => spot.x).reduce((a, b) => a > b ? a : b);
          double maxY =
              currentData.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildTimeFilterButtons(_chartData),
              ),
              Stack(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 18,
                        left: 12,
                        top: 24,
                        bottom: 12,
                      ),
                      child: LineChart(
                        showAvg
                            ? avgData(maxX, maxY)
                            : mainData(currentData, maxX, maxY),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    height: 34,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          showAvg = !showAvg;
                        });
                      },
                      child: Text(
                        'avg',
                        style: TextStyle(
                          fontSize: 12,
                          color: showAvg
                              ? Colors.white.withOpacity(0.5)
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }

  List<Widget> _buildTimeFilterButtons(Map<String, List<FlSpot>> chartData) {
    return chartData.keys.map((String key) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              widget.selectedTime = key;
            });
            if (widget.onTimePeriodChanged != null) {
              widget.onTimePeriodChanged!(widget.selectedTime);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                widget.selectedTime == key ? primaryColor : lightBlack,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: Text(key),
        ),
      );
    }).toList();
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (widget.selectedTime) {
      case '1D':
        text = Text('${value.toInt()}h', style: style);
        break;
      case '1W':
        const daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        text = Text(daysOfWeek[value.toInt()], style: style);
        break;
      case '1M':
        text = Text('${value.toInt() + 1}', style: style);
        break;
      case '1Y':
        const months = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec'
        ];
        text = Text(months[value.toInt()], style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData(List<FlSpot> spots, double maxX, double maxY) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: darkGrey.withOpacity(0.1),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: darkGrey.withOpacity(0.1),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: maxX,
      minY: 0,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.15))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData(double maxX, double maxY) {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: maxX,
      minY: 0,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
