import 'package:flutter/material.dart';
import 'package:iota/pages/mcq_list.dart';

// ignore: must_be_immutable
class SubjectCard extends StatelessWidget {

  String sub;
  String subJson;
  SubjectCard({super.key,required this.sub,required this.subJson});

  Future<void>_navigate(BuildContext context,String s,String subject)async{
    await Navigator.push(context,
        MaterialPageRoute(builder:(context)=>MCQList(subjson:s,subject:subject ,)),);
  }

  @override
  Widget build(BuildContext context) {
      return Container(
      padding:const EdgeInsets.symmetric(vertical:20,horizontal: 20),
      width: MediaQuery.of(context).size.width/2.4,
      height:MediaQuery.of(context).size.height/4.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        gradient:const LinearGradient(
          begin:Alignment.topLeft,
          end: Alignment.bottomRight,
          colors:[Color.fromARGB(234, 204, 232, 255),Color.fromARGB(255, 230, 236, 255)] 
        )
      ),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(sub,
            style:const TextStyle(
              fontFamily: 'Noto Serif Bengali',
              fontSize: 26,
              color: Color.fromARGB(255, 10, 92, 159),
              fontWeight: FontWeight.bold,
              shadows:[ BoxShadow(
                color: Colors.lightBlue,
                blurRadius: 3.5,
                spreadRadius: -5
              )]
            ),
          ),
          const SizedBox(height: 4.4),
          const Text('Most selective questions',
          style: TextStyle(
            fontWeight: FontWeight.w500
          ),),
          const Spacer(),
          GestureDetector(
            onTap:(){_navigate(context,subJson,sub); },
            child:Container(
              height: 40,
              width:MediaQuery.of(context).size.width/2.9 ,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 8, 100, 175),
                  boxShadow:const [
                    BoxShadow(
                      color: Color.fromARGB(255, 48, 171, 228),
                      blurRadius: 12,
                      spreadRadius: -4,
                    )
                  ],
                borderRadius: BorderRadius.circular(7)
              ),
              child:const Center(child: Text('View',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
                color: Colors.white
              ),)),
            ) ,
          ),
        ],
      ),
    );
  } 
}