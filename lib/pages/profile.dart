import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iota/components/stat_card.dart';
import 'package:iota/service/auth_service.dart';
import 'package:iota/service/q_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final user =FirebaseAuth.instance.currentUser!;
  DailyStats? stats;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    stats = await DailyStats.load();
    if (mounted) {
      setState(() {});
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:stats!=null?
       StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots() , 
        builder:(context,snapshot){
          if(snapshot.hasData){
            final userData=snapshot.data!.data() as Map<String,dynamic>;

            return Padding(
              padding: const EdgeInsets.only(top: 70,left: 17,right: 15,bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 Material(
                   elevation: 10,
                   borderRadius: BorderRadius.circular(90),
                   child: ClipRRect(
                     borderRadius: BorderRadius.circular(90),
                     child: Image.network(userData['profilePhoto'],height: 100,width: 100,fit: BoxFit.cover,),
                   ),
                 ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text(userData['username'],style: const TextStyle(color: Colors.black,fontFamily: 'Noto Serif Bengali',
                      fontSize: 20,fontWeight: FontWeight.w600)),
                    ),
                    Text(userData['email'],style: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600))
                  ],
                ),
               ],
              ),
           const SizedBox(height: 15,),
           Row(
             children: [
             const Text('My Activity',
             style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 21,
             ),),
             const Spacer(),
             SizedBox(
              height: 35,
              width: 35,
               child: FloatingActionButton(
                elevation: .2,
                onPressed:() async {
                stats!.reset();
                await stats!.save();
                setState(() {});
                },
                child: const Icon(Icons.refresh),
                ),
             )
             ],
           ),
           const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            StatsCard(
              x:'',
              title:'Question \nsolved' , 
              Stat: stats!.attempted.toString() , 
              icon:'attempted'),
            StatsCard(
              x: '',
              title:'Correct \nQuestions' , 
              Stat: stats!.correct.toString(), 
              icon:'check-circle'),
            ],
          ),
          const SizedBox(height: 15,),
          StatsCard(
            x: '%',
            title:'Accuracy' , 
            Stat: (stats!.attempted!=0)?((stats!.correct/stats!.attempted)*100).toStringAsFixed(1):0.toString(), 
            icon:'accuracy'),

            const SizedBox(height: 20,),

            //MockTestScoreGraph(scores: scores),
            
            const Spacer(),
            GestureDetector(
              onTap: () {
                AuthMethods().deleteUser();
              },
              child: Material(
                borderRadius:BorderRadius.circular(10),
                elevation: 2.5,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child:const Row(
                    children: [
                      Icon(Icons.delete,color: Colors.black,),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Delete Account',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
                     GestureDetector(
              onTap: () {
                AuthMethods().SignOut();
              },
              child: Material(
                borderRadius:BorderRadius.circular(10),
                elevation: 2.5,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child:const Row(
                    children: [
                      Icon(Icons.logout,color: Colors.black,),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Log Out',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
            ],
          ),
        );
      }
      else if (snapshot.hasError){
        return const Center(child: Text('Error'),);
      }
      else{return const Center(child: CircularProgressIndicator(),);}
    } 
  ):const CircularProgressIndicator()
    );
  }
}