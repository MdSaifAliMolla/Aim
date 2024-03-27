// import 'dart:math';

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:iota/mock_test/graph_data.dart';

// class MockTestScoreGraph extends StatelessWidget {
//   final List<MockTestScore> scores;

//   const MockTestScoreGraph({Key? key, required this.scores}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//       LineChartData(
//         lineTouchData: LineTouchData(enabled: false),
//         lineBarsData: [
//           LineChartBarData(
//             spots: scores
//                 .map((score) => FlSpot(
//                       score.dateTime.millisecondsSinceEpoch.toDouble(),
//                       score.score.toDouble(),
//                     ))
//                 .toList(),
//             isCurved: true,
//             color: Colors.blue,
//             barWidth: 2,
//             dotData: FlDotData(show: false),
//           ),
//         ],
//         minX: scores.first.dateTime.millisecondsSinceEpoch.toDouble(),
//         maxX: scores.last.dateTime.millisecondsSinceEpoch.toDouble(),
//         minY: 0,
//         maxY: scores.map((score) => score.totalQuestions.toDouble()).reduce(max) + 1,
//         titlesData: FlTitlesData(
//           leftTitles: AxisTitles(
//             axisNameWidget: const Text('Score'),
//             sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: (value, meta) => Text(value.toInt().toString()),
//             ),
//           ),
//           bottomTitles: AxisTitles(
//             axisNameWidget: const Text('Date'),
//             sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: (value, meta) {
//                 final dateTime = DateTime.fromMillisecondsSinceEpoch(value.toInt());
//                 return Text(dateTime.toString().split(' ').first);
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }