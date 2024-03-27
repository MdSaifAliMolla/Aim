import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestQuestionModel {
  final String question;
  final List<String> options;
  final int answer;
  final String subject;
  int? userAnswer;
  QuestionStatus status = QuestionStatus.unattempted;

  TestQuestionModel({
    required this.question,
    required this.options,
    required this.answer,
    required this.subject,
    this.userAnswer
  });

  factory TestQuestionModel.fromJson(Map<String, dynamic> json) => TestQuestionModel(
        question: json['q'] as String,
        options: (json['op'] as List).cast<String>(),
        answer: json['ans'] as int,
        subject:json['subject'] as String,
      );
}

enum QuestionStatus {unattempted,attempted,MarkedforReview}






class TestDataService {
  static Future<List<TestQuestionModel>>fetchMQuestion(String dataname)async{
    try {
      final response = await rootBundle.loadString('assets/mock_test/$dataname');
      final List<dynamic> data = jsonDecode(response)as List;
      return data.map((item) =>TestQuestionModel.fromJson(item)).toList();
    } catch(e){
      throw Exception('Error: $e');
    }
  }
}






class TimerController {
  final Duration initialTime;
  Duration _currentTime;

  Stream<Duration> get remainingTime => Stream.periodic(const Duration(seconds: 1), (_) {
    if (_currentTime <= Duration.zero) {
      return Duration.zero;
      
    } else {
      _currentTime = _currentTime - const Duration(seconds: 1);
      return _currentTime;
    }
  });

  TimerController({this.initialTime = const Duration(seconds: 20)})
      : _currentTime = initialTime;

  Duration getCurrentTime() => _currentTime;
}








class ScoreManager {
  int correct;
  int incorrect;
  String testkey;

  ScoreManager({this.correct = 0, this.incorrect = 0,required this.testkey});

   void reset() {
    correct = 0;
    incorrect = 0;
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('${testkey}_correct', correct);
    await prefs.setInt('${testkey}_incorrect', incorrect);

  }

  static Future<ScoreManager> load(String tk) async {
    final prefs = await SharedPreferences.getInstance();
      return ScoreManager(
        testkey:tk,
        correct:prefs.getInt('${tk}_correct')?? 0,
        incorrect:prefs.getInt('${tk}_incorrect')?? 0,

      );
  }     
}