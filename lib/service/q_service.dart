import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:iota/components/question_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyStats {
  int attempted;
  int correct;
  int incorrect;
  //String date; 

  DailyStats({this.attempted = 0, this.correct = 0, this.incorrect = 0, });
      //: this.date = date ?? DateFormat('yyyy-MM-dd').format(DateTime.now());


  void reset() {
    attempted = 0;
    correct = 0;
    incorrect = 0;
   // date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  void update({required bool isCorrect}) {
    attempted++;
    isCorrect ? correct++ : incorrect++;
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('attempted', attempted);
    await prefs.setInt('correct', correct);
    await prefs.setInt('incorrect', incorrect);
    //await prefs.setString('date', date);
  }

  static Future<DailyStats> load() async {
    final prefs = await SharedPreferences.getInstance();
    //final storedDate = prefs.getString('date');
    //final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // if (storedDate != today) {
    //   return DailyStats();
    // } else {
      return DailyStats(
        attempted: prefs.getInt('attempted') ?? 0,
        correct: prefs.getInt('correct') ?? 0,
        incorrect: prefs.getInt('incorrect') ?? 0,
        //date: storedDate,
      );
    //}
  }
}



class QuestionDataService {
  static Future<List<QuestionModel>>fetchQuestion(String dataname)async{
    try {
      final response = await rootBundle.loadString('assets/$dataname');
      final List<dynamic> data = jsonDecode(response)as List;
      return data.map((item) =>QuestionModel.fromJson(item)).toList();
    } catch(e){
      throw Exception('Error: $e');
    }
  }
}
