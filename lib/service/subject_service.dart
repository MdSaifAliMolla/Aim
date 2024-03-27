import 'package:shared_preferences/shared_preferences.dart';

class SubjectStat {
  int attempted;
  int correct;
  int incorrect;
  String subject;
  bool isAttempted;

  SubjectStat({this.attempted=0,this.correct=0,this.incorrect=0,required this.subject,this.isAttempted=false});

  void update({required bool isCorrect}){
    attempted++;
    isCorrect?correct++:incorrect++;
    isAttempted=true;
  }

  Future<void>save()async{
    final pf = await SharedPreferences.getInstance();
    await pf.setInt('${subject}_attempted', attempted);
    await pf.setInt('${subject}_correct',correct);
    await pf.setInt('${subject}_incorrect', incorrect);
    await pf.setBool('${subject}_isAttempted', isAttempted);
  }

  static Future<SubjectStat>load(String subject)async{
    final prefs = await SharedPreferences.getInstance();
      return SubjectStat(
        attempted: prefs.getInt('${subject}_attempted') ?? 0,
        correct: prefs.getInt('${subject}_correct') ?? 0,
        incorrect: prefs.getInt('${subject}_incorrect') ?? 0,
        subject: subject,
        isAttempted: prefs.getBool('${subject}_isAttempted') ?? false
      );
    
  }
}