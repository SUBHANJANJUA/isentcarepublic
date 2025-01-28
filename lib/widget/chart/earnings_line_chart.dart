import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:isentcare/resources/constants/app_sizer.dart';
import 'package:isentcare/resources/constants/color.dart';

class EarningsLineChart extends StatelessWidget {
  final List<double> earnings; // List of monthly earnings
  final List<String>
      months; // List of month labels (e.g., ['Jan', 'Feb', 'Mar'])

  const EarningsLineChart(
      {super.key, required this.earnings, required this.months});

  @override
  Widget build(BuildContext context) {
    // Handle empty data gracefully
    if (earnings.isEmpty || months.isEmpty) {
      return const Center(
        child: Text(
          'No data available',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    // log("Earnigs: ${earnings.toString()}");

    // // Find the maximum value in earnings to set the vertical axis range
    // final double maxEarnings =
    //     (earnings.reduce((a, b) => a > b ? a : b)).ceilToDouble();
    // log("message: $maxEarnings");

    // // Ensure verticalStep is non-zero
    // final double verticalStep =
    //     maxEarnings > 0 ? (maxEarnings / 5).ceilToDouble() : 1;

    // log("verticalStep: $verticalStep");

    return SizedBox(
      height: context.screenHeight * 0.3,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(
              show: true,
              drawHorizontalLine: true,
              drawVerticalLine: false,
              horizontalInterval: 10),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              left: BorderSide(color: Colors.black), // Show left border
              bottom: BorderSide(color: Colors.black), // Show bottom border
              top: BorderSide.none, // Hide top border
              right: BorderSide.none, // Hide right border
            ),
          ),
          titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  interval: 10,
                  getTitlesWidget: (value, meta) {
                    return Text('\$${value.toInt()}k',
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textPrimary));
                  },
                ),
              ),
              topTitles: const AxisTitles(
                  drawBelowEverything: false,
                  sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(
                  drawBelowEverything: false,
                  sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    int index = value.toInt();
                    if (index >= 0 && index < months.length) {
                      return Text(months[index],
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textPrimary));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              )),
          lineBarsData: [
            LineChartBarData(
              spots: earnings.asMap().entries.map((entry) {
                return FlSpot(entry.key.toDouble(), entry.value);
              }).toList(),
              isCurved: true,
              curveSmoothness: 0.5,
              barWidth: 2,
              color: Colors.black,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue.shade200, // Dark blue
                    Colors.blue.shade50, // Light blue
                  ],
                ),
                cutOffY: 0, // Adjust this to define the gradient's lower limit
                applyCutOffY: false,
              ),
            ),
          ],
          minX: 0,
          maxX: (months.length - 1).toDouble(),
          minY: 0,
          maxY: 100,
        ),
      ),
    );
  }
}
