import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:time_maze/GraphManager.dart';
import 'GraphManager.dart';
class GraphWidget extends StatelessWidget {
  final GraphManager graphManager;

  const GraphWidget({required this.graphManager});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: graphManager.getGraphData(),
            isCurved: false, // Straight lines
            barWidth: 3,
            color: Colors.orange,
            dotData: FlDotData(show: true),
          ),
        ],
      ),
    );
  }
}
