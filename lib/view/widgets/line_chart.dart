import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../utils/colors.dart';

class LineChartWidget extends StatefulWidget {
  final Function(String)? onTimePeriodChanged;

  const LineChartWidget(
      {Key? key, this.onTimePeriodChanged, required String selectedTime})
      : super(key: key);

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

  // Data for different time periods
  final Map<String, List<FlSpot>> _chartData = {
    '1D': List.generate(
        24, (index) => FlSpot(index.toDouble(), (index % 2) + 1.5)),
    '1W': List.generate(
        7, (index) => FlSpot(index.toDouble(), (index % 3) + 1.5)),
    '1M': List.generate(
        30,
        (index) =>
            FlSpot(index.toDouble(), (index % 4) + 2.0)), // 30 days in a month
    '1Y': List.generate(
        12, (index) => FlSpot(index.toDouble(), (index % 5) + 1.5)),
  };

  // Selected time period
  String _selectedTime = '1M';

  @override
  Widget build(BuildContext context) {
    List<FlSpot> currentData = _chartData[_selectedTime]!;

    double maxX =
        currentData.map((spot) => spot.x).reduce((a, b) => a > b ? a : b);
    double maxY =
        currentData.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildTimeFilterButtons(),
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
                    color:
                        showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildTimeFilterButtons() {
    return _chartData.keys.map((String key) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _selectedTime = key;
            });
            if (widget.onTimePeriodChanged != null) {
              widget.onTimePeriodChanged!(_selectedTime);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _selectedTime == key ? primaryColor : lightBlack,
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
    switch (_selectedTime) {
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
