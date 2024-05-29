import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1,
          child: LineChart(mainData()),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final style = GoogleFonts.plusJakartaSans(
      fontWeight: FontWeight.w600,
      fontSize: 10,
    );
    Widget text;

    switch (value.toInt()) {
      case 0:
        text = Text('0', style: style);
        break;
      case 1:
        text = Text('1', style: style);
        break;
      case 2:
        text = Text('2', style: style);
        break;
      case 3:
        text = Text('3', style: style);
        break;
      case 4:
        text = Text('4', style: style);
        break;
      case 5:
        text = Text('5', style: style);
        break;
      case 6:
        text = Text('6', style: style);
        break;
      case 7:
        text = Text('7', style: style);
        break;
      case 8:
        text = Text('8', style: style);
        break;
      case 9:
        text = Text('9', style: style);
        break;
      case 10:
        text = Text('10', style: style);
        break;
      case 11:
        text = Text('11', style: style);
        break;
      case 12:
        text = Text('12', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final style = GoogleFonts.plusJakartaSans(
      fontWeight: FontWeight.w600,
      fontSize: 8,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '100.000';
        break;
      case 2:
        text = '200.000';
        break;
      case 3:
        text = '300.000';
        break;
      case 4:
        text = '400.000';
        break;
      case 5:
        text = '500.000';
        break;
      case 6:
        text = '600.000';
        break;
      case 7:
        text = '700.000';
        break;
      case 8:
        text = '800.000';
        break;
      case 9:
        text = '900.000';
        break;
      case 10:
        text = '1.000.000';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) =>
            const FlLine(color: Colors.grey, strokeWidth: 0),
        getDrawingVerticalLine: (value) =>
            const FlLine(color: Colors.grey, strokeWidth: 0),
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          axisNameWidget: const Text('Bulan'),
          sideTitles: SideTitles(
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
            reservedSize: 50,
            showTitles: true,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            getTitlesWidget: leftTitleWidgets,
            interval: 1,
            reservedSize: 50,
            showTitles: true,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(1, 1.3),
            FlSpot(5, 5.5),
            // FlSpot(6.8, 3.1),
            // FlSpot(8, 4),
            // FlSpot(9.5, 3),
            // FlSpot(11, 4),
          ],
          isCurved: true,
          
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
