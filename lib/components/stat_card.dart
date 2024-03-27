import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StatsCard extends StatelessWidget {

  String icon;
  String Stat;
  String title; 
  String x;
  StatsCard({super.key,required this.x,required this.title,required this.Stat,required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
              height: MediaQuery.of(context).size.height/8.5,
              width: MediaQuery.of(context).size.width/2.4,
              decoration: BoxDecoration(
                border: Border.all(width: 1.3,color: const Color.fromARGB(255, 212, 210, 210)),
                borderRadius: BorderRadius.circular(13)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(image: AssetImage('assets/pic/$icon.png')),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text('$Stat $x',
                      style:const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),),
                      Text(title,
                      style:const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey
                      ),)
                    ],
                  )
                ],
              ),
            );
  }
}