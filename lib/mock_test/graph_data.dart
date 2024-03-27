// import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';

// class MockTestScore {
//   final String testName;
//   final DateTime dateTime;
//   final int totalQuestions;
//   final int score;

//   MockTestScore({
//     required this.testName,
//     required this.dateTime,
//     required this.totalQuestions,
//     required this.score,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'testName': testName,
//       'dateTime': dateTime.millisecondsSinceEpoch,
//       'totalQuestions': totalQuestions,
//       'score': score,
//     };
//   }

//   factory MockTestScore.fromMap(Map<String, dynamic> map) {
//     return MockTestScore(
//       testName: map['testName'],
//       dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
//       totalQuestions: map['totalQuestions'],
//       score: map['score'],
//     );
//   }
// }

// class MockTestScoreRepository {
  
//   static const String _prefsKey = 'mockTestScores';

//   static Future<void> saveScore(MockTestScore score) async {
//     final prefs = await SharedPreferences.getInstance();
//     List<String> scores = prefs.getStringList(_prefsKey) ?? [];
//     scores.add(score.toMap().toString());
//     await prefs.setStringList(_prefsKey, scores);
//   }

//   static Future<List<MockTestScore>> getAllScores() async {
//     final prefs = await SharedPreferences.getInstance();
//     List<String> scores = prefs.getStringList(_prefsKey) ?? [];
//     return scores.map((scoreString) {
//       Map<String, dynamic> scoreMap = Map.from(json.decode(scoreString));
//       return MockTestScore.fromMap(scoreMap);
//     }).toList();
//   }
// }
