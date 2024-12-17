import 'package:fl_chart/fl_chart.dart';

class GraphManager {
  List<FlSpot> graphData = [];

  final Map<String, List<FlSpot>> quadrantPoints = {
    'Q1': [FlSpot(1, 10), FlSpot(2, 20), FlSpot(3, 30)],
    'Q2': [FlSpot(4, 30), FlSpot(5, 25), FlSpot(6, 20)],
    'Q3': [FlSpot(7, 20), FlSpot(8, 15), FlSpot(9, 10)],
    'Q4': [FlSpot(10, 10), FlSpot(11, 20), FlSpot(12, 30)],
  };

  void updateGraphData(String quadrant) {
    if (quadrantPoints.containsKey(quadrant)) {
      graphData.addAll(quadrantPoints[quadrant]!);
      graphData.sort((a, b) => a.x.compareTo(b.x)); // Sort points for a smooth graph
    }
  }

  List<FlSpot> getGraphData() => graphData;
}
