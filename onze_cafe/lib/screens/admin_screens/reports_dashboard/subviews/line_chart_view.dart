import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';

import '../../../../model/enums/selling_times.dart';

class LineChartView extends StatelessWidget {
  const LineChartView({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: LineChart(LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 1), // 8 AM
                FlSpot(1, 1.5), // 9 AM
                FlSpot(2, 1.4), // 10 AM
                FlSpot(3, 3.4), // 11 AM
                FlSpot(4, 2), // 12 PM
                FlSpot(5, 2.2), // 1 PM
                FlSpot(6, 1.8), // 2 PM
                FlSpot(7, 3.0), // 3 PM
                FlSpot(8, 2.5), // 4 PM
                FlSpot(9, 3.5), // 5 PM
                FlSpot(10, 1.7), // 6 PM
                FlSpot(11, 2.8), // 7 PM
                FlSpot(12, 2.3), // 8 PM
              ],
              isCurved: true,
              color: C.secondary(brightness),
              barWidth: 3,
              belowBarData: BarAreaData(show: false),
            ),
          ],
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  // Ensure mapping of X-axis values to hours
                  int index = value.toInt();
                  if (index >= 0 && index < SellingTimes.values.length) {
                    SellingTimes time = SellingTimes.values[index];
                    return Text(time.hour()).styled();
                  }
                  return const Text('');
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              left: BorderSide(color: Colors.black, width: 1),
              bottom: BorderSide(color: Colors.black, width: 1),
            ),
          ),
          minX: 0,
          maxX:
              12, // Ensure this matches the number of points (12 for 8 AM to 8 PM)
          minY: 0,
          maxY: 4,
        )),
      ),
    );
  }
}
