import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../utils/colors.dart';

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({super.key});

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
    '1D': [FlSpot(0, 1), FlSpot(1, 2), FlSpot(2, 1.5)],
    '1W': [FlSpot(0, 2), FlSpot(1, 1.5), FlSpot(2, 2.5)],
    '1M': [
      FlSpot(0, 3),
      FlSpot(2.6, 2),
      FlSpot(4.9, 5),
      FlSpot(6.8, 3.1),
      FlSpot(8, 4),
      FlSpot(9.5, 3),
      FlSpot(11, 4)
    ],
    '1Y': [
      FlSpot(0, 2),
      FlSpot(3, 1.8),
      FlSpot(6, 2.2),
      FlSpot(9, 2.5),
      FlSpot(12, 2)
    ],
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
        DropdownButton<String>(
          value: _selectedTime,
          items: _chartData.keys.map((String key) {
            return DropdownMenuItem<String>(
              value: key,
              child: Text(key),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedTime = newValue!;
            });
          },
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

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
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
