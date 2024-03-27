import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StudyMaterial extends StatelessWidget {
  String title;
  String subtitle;
  StudyMaterial({super.key,required this.title,required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => null,
      child: Container(
        padding: const EdgeInsets.only(top:10,bottom: 10,left: 10,right: 10),
        decoration: BoxDecoration(
          border: Border.all(width: 3.5,color: Colors.yellow),
          borderRadius: BorderRadius.circular(25),
          color: const Color.fromARGB(255, 253, 242, 156)
        ),
        height: MediaQuery.of(context).size.height/7.9,
        width: MediaQuery.of(context).size.width/2.2,
        child:Column(
          children: [
            Text(title),
            const SizedBox(height: 10,),
            Text(subtitle)
          ],
        ) ,
      ),
    );
  }
}