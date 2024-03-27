import 'package:flutter/material.dart';
import 'package:iota/components/subject_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:const EdgeInsets.only(left:14,right: 14,bottom: 0,top: 60) ,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const Row(
              children: [
                Text('Hey, Champ!',
                  style:TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(255, 92, 90, 90)
                    ),
                  ),
                Spacer(),
                Image(image:AssetImage('assets/pic/acc.png',)),
                Text('AIM',
                  style:TextStyle(
                      fontFamily: 'Noto Serif Bengali',
                      fontSize: 39,
                      fontWeight: FontWeight.bold,
                      shadows:[ BoxShadow(
                        blurRadius: 3,
                        spreadRadius: -5
                      )]
                    ),
                  ),
              ],
              ),
              const SizedBox(height: 15,),
                  const Text('Supercharge your TET preperation',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(255, 112, 112, 112),
                      shadows:[ BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                        spreadRadius: -4
                      )],
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SubjectCard(sub:'বাংলা',subJson: 'bangla.json',),
                      SubjectCard(sub:'English',subJson: 'English.json',)
                    ],
                  ),
                  const SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SubjectCard(sub:'পেডাগগি',subJson: 'bangla.json'),
                       SubjectCard(sub:'Math',subJson: 'bangla.json'),
                    ],
                  ),
                  const SizedBox(height: 12,),
                  Padding(
                    padding: const EdgeInsets.only(left:10),
                    child: SubjectCard(sub:'EVS',subJson: 'bangla.json'),
                  ),
                  const SizedBox(height: 15),
                  const Divider()
                ], 
                ),
              ),
               Container(
                padding: const EdgeInsets.all(19),
                      height: MediaQuery.of(context).size.height/6,
                      width: MediaQuery.of(context).size.width,
                      child: const Text('AIM',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900
                      ),),
                    )
          ],
        ),
        ),
      ); 
    
  }
}