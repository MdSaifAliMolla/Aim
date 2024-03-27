import 'package:flutter/material.dart';
import 'package:iota/mock_test/mock_test_service.dart';
import 'package:iota/mock_test/result_screen.dart';
import 'package:iota/mock_test/test_screen.dart';

// ignore: must_be_immutable
class TestCard extends StatefulWidget {
  
  String testJson;
  String title;
  String testkey;

  TestCard({super.key,required this.testJson,
    required this.testkey,required this.title});

  @override
  State<TestCard> createState() => _TestCardState();
}

class _TestCardState extends State<TestCard> {

  late Future<List<TestQuestionModel>>MQ;
 // bool attemptedTest=false;

  @override
  void initState() {
    super.initState();
    MQ = TestDataService.fetchMQuestion(widget.testJson);
  }

  // Future<void> _loadTestAttemptedStatus() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     attemptedTest = prefs.getBool('${widget.testkey}_attempted') ?? false;
  //   });
  // }
  // void reset()async{
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('${widget.testkey}_attempted',false);
  // }

  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:MQ, 
      builder:(context,snapshot){
        if (snapshot.hasError) {
          return Center(child: Text('Error:${snapshot.error}'),);
        }else if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }else if(snapshot.hasData){
          final mq=snapshot.data;
        return Container(
      height: MediaQuery.of(context).size.height/6.9,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical:10,horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(width: 1.3,color: const Color.fromARGB(255, 212, 210, 210)),
        borderRadius: BorderRadius.circular(7)
      ),
      child:Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              Text(widget.title,
              style:const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 21
              ),),
              const Text('Full Marks : 150',
              style: TextStyle(
                fontSize:15,
                color: Colors.grey 
              ),),
              const Text('Time : 2 hr 30 mins',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey
              ),)
            ],
          ),
          const Spacer(),
          //attemptedTest?

            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 248, 94, 83),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))

                  ),
                  onPressed:(){
                    Navigator.push(context,MaterialPageRoute(builder:
                     ((context) => ResultScreen(
                      testkey:widget.testkey,
                      list: mq!,
                    ))
                   ));
                  } , 
                  child:const Text('View Report',
                  
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                  ),)
                ),
                ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
              ),
              onPressed:(){
                showDialog(
                  context: context, 
                  builder: (context)=>AlertDialog(
                    title: const Text('Are You ready?'),
                    content: const Text('first 30 math\nnext 30 evs'),
                    actions: [
                      TextButton(
                        onPressed:(){
                          Navigator.push(context,MaterialPageRoute(builder:
                            ((context) => TestScreen(
                                testkey:widget.testkey,
                                time: TimerController(),
                                q:mq![0] ,
                                qIndex: 0,
                                list:mq,
                              ))
                          ));
                      } , 
                     child:const Text('Yes,I am ready'))
                    ],
                  )
                );
              } , 
              child:const Text('Take Test',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.white
              ),)
            )
              ],
            ),
        ],
      ),
    );
        }else{
          return const Center(child: Text('Unknown Error'),);
        }
      }
    );

  }
}