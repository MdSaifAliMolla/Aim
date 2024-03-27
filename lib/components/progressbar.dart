import 'package:flutter/material.dart';
import 'package:iota/service/subject_service.dart';

class ProgressBar extends StatelessWidget {

  final SubjectStat sst;
  
  const ProgressBar({super.key,required this.sst});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(
          minHeight:7 ,
          borderRadius: BorderRadius.circular(20),
          value: sst.attempted/100,
          backgroundColor:const Color.fromARGB(255, 212, 206, 206),
          valueColor: const AlwaysStoppedAnimation(Color.fromARGB(255, 6, 209, 43),),
        )
      ],
    );
  }
}