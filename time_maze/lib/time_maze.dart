// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// void main() => runApp(QuadrantDragApp());

// class QuadrantDragApp extends StatefulWidget {
//   @override
//   _QuadrantDragAppState createState() => _QuadrantDragAppState();
// }

// class _QuadrantDragAppState extends State<QuadrantDragApp> {
//   List<FlSpot> continuousData = [];
//   String smileState = 'neutral'; // Default smile state
//   String quote = 'Start dragging to see progress!';

//   // Points for each quadrant
//   final Map<String, List<FlSpot>> quadrantPoints = {
//     'Q1': [FlSpot(1, 10), FlSpot(2, 20), FlSpot(3, 30)],
//     'Q2': [FlSpot(4, 30), FlSpot(5, 25), FlSpot(6, 20)],
//     'Q3': [FlSpot(7, 20), FlSpot(8, 15), FlSpot(9, 10)],
//     'Q4': [FlSpot(10, 10), FlSpot(11, 20), FlSpot(12, 30)],
//   };

//   // Quotes for each quadrant
//   final Map<String, String> quadrantQuotes = {
//     'Q1': 'You’re doing great! Keep it up! 🌟',
//     'Q2': 'Stay focused and aim high! 🚀',
//     'Q3': 'Don’t lose hope, you can bounce back! 💪',
//     'Q4': 'Hard times don’t last, keep going! 🌈',
//   };

//   final Map<String, String> smileEmojis = {
//     'happy': '😊',
//     'sad': '😔',
//     'neutral': '🙂',
//   };

//   void updateContinuousGraph(String quadrant) {
//     setState(() {
//       if (quadrantPoints.containsKey(quadrant)) {
//         continuousData.addAll(quadrantPoints[quadrant]!);
//         continuousData.sort((a, b) => a.x.compareTo(b.x)); // Sort for smooth graph
//       }

//       // Update smile state based on quadrant
//       if (quadrant == 'Q1' || quadrant == 'Q2') {
//         smileState = 'happy';
//       } else if (quadrant == 'Q3' || quadrant == 'Q4') {
//         smileState = 'sad';
//       }

//       // Update the quote
//       quote = quadrantQuotes[quadrant] ?? 'Keep going! 🌟';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Quadrant Dragging with Graph'),
//           centerTitle: true,
//         ),
//         body: Column(
//           children: [
//             SizedBox(height: 20),
//             // Smile Display
//             Text(
//               smileEmojis[smileState]!,
//               style: TextStyle(fontSize: 60),
//             ),
//             SizedBox(height: 10),
//             // Motivational Quote Display
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Text(
//                 quote,
//                 style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             SizedBox(height: 20),
//             // Quadrants
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Draggable<String>(
//                   data: 'Q1',
//                   feedback: QuadrantWidget(label: 'Q1', color: Colors.green),
//                   child: QuadrantWidget(label: 'Q1', color: Colors.green),
//                   childWhenDragging: QuadrantWidget(label: '', color: Colors.grey),
//                 ),
//                 Draggable<String>(
//                   data: 'Q2',
//                   feedback: QuadrantWidget(label: 'Q2', color: Colors.blue),
//                   child: QuadrantWidget(label: 'Q2', color: Colors.blue),
//                   childWhenDragging: QuadrantWidget(label: '', color: Colors.grey),
//                 ),
//                 Draggable<String>(
//                   data: 'Q3',
//                   feedback: QuadrantWidget(label: 'Q3', color: Colors.orange),
//                   child: QuadrantWidget(label: 'Q3', color: Colors.orange),
//                   childWhenDragging: QuadrantWidget(label: '', color: Colors.grey),
//                 ),
//                 Draggable<String>(
//                   data: 'Q4',
//                   feedback: QuadrantWidget(label: 'Q4', color: Colors.red),
//                   child: QuadrantWidget(label: 'Q4', color: Colors.red),
//                   childWhenDragging: QuadrantWidget(label: '', color: Colors.grey),
//                 ),
//               ],
//             ),
//             SizedBox(height: 30),
//             // Drag Target (Directly updates graph)
//             DragTarget<String>(
//               onAccept: (data) {
//                 updateContinuousGraph(data);
//               },
//               builder: (context, candidateData, rejectedData) {
//                 return Container(
//                   height: 100,
//                   width: double.infinity,
//                   margin: EdgeInsets.symmetric(horizontal: 20),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black54, width: 2),
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.grey.shade200,
//                   ),
//                   child: Center(
//                     child: Text(
//                       'Drag Quadrants Here',
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 );
//               },
//             ),
//             SizedBox(height: 30),
//             // Graph Display
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: LineChart(
//                   LineChartData(
//                     titlesData: FlTitlesData(
//                       leftTitles: AxisTitles(
//                         sideTitles: SideTitles(showTitles: true, reservedSize: 30),
//                       ),
//                       bottomTitles: AxisTitles(
//                         sideTitles: SideTitles(showTitles: true, reservedSize: 20),
//                       ),
//                     ),
//                     gridData: FlGridData(show: true),
//                     lineBarsData: [
//                       LineChartBarData(
//                         spots: continuousData,
//                         isCurved: false, // Straight lines instead of curves
//                         color: Colors.orange,
//                         barWidth: 3,
//                         belowBarData: BarAreaData(show: false),
//                         dotData: FlDotData(show: true),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class QuadrantWidget extends StatelessWidget {
//   final String label;
//   final Color color;

//   const QuadrantWidget({required this.label, required this.color});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       width: 50,
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.black45),
//       ),
//       child: Center(
//         child: Text(
//           label,
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }
