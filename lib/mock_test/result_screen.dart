import 'package:flutter/material.dart';
import 'package:iota/components/stat_card.dart';
import 'package:iota/mock_test/mock_test_service.dart';
import 'package:iota/mock_test/solution_screen.dart';

// ignore: must_be_immutable
class ResultScreen extends StatefulWidget {

  String testkey;
  final List<TestQuestionModel>list;
  ResultScreen({super.key,required this.testkey,required this.list});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {

   ScoreManager? result;

  @override
  void initState() {
    super.initState();
    _loadRes();
  }

  Future<void> _loadRes() async {
    result = await ScoreManager.load(widget.testkey);
    if (result!.correct==0&&result!.incorrect==0) {
      result!.correct = widget.list.where((q) => q.userAnswer == q.answer).length;
      result!.incorrect = widget.list.where((q) => q.userAnswer != q.answer && q.userAnswer != null).length;
      await result!.save();
    }
    
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:result!=null?
          Padding(
            padding: const EdgeInsets.symmetric(vertical:30,horizontal:20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Test Report',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 25
                    ),),
                    const Spacer(),
                     IconButton(onPressed:(){setState(() {
                  result!.reset();
                  result!.save();
                });}
                , icon: const Icon(Icons.refresh))
                  ],
                ),
                const SizedBox(height: 9,),
                const Row(
                  children: [
                    Icon(Icons.timer_rounded,color:Color.fromARGB(255, 147, 147, 147)),
                    SizedBox(width: 7,),
                    Text('2 hr 30 mins')
                  ],
                ),
                const SizedBox(height: 25,),
                Row(
                  children: [
                    Stack(
                      children: [
                        const SizedBox(
                          height: 150,
                          width: 150,
                          child: CircularProgressIndicator(
                            value:1,
                            strokeWidth: 16,
                            backgroundColor:Colors.transparent,
                            valueColor:AlwaysStoppedAnimation(Color.fromARGB(255, 201, 200, 200)),
                          ),
                        ),
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: CircularProgressIndicator(
                            value:(result!.correct+result!.incorrect)/10,
                            strokeWidth: 16,
                            backgroundColor:Colors.transparent,
                            valueColor:const AlwaysStoppedAnimation(Color.fromARGB(255, 255, 42, 27)),
                          ),
                        ),
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: CircularProgressIndicator(
                            value:result!.correct/10,
                            strokeWidth: 16,
                            backgroundColor:Colors.transparent,
                            valueColor:const AlwaysStoppedAnimation(Color.fromARGB(255, 0, 255, 8)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 25,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Correct : ${result!.correct} Qs',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 2, 197, 9)
                        ),),
                        const SizedBox(height: 14,),
                        Text('Incorrect : ${result!.incorrect} Qs',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color:Color.fromARGB(255, 255, 42, 27) 
                        ),),
                        const SizedBox(height: 14,),
                        Text('Not Answered : ${150-(result!.correct+result!.incorrect)} Qs',
                        style:const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                        ),),
                        const SizedBox(height: 14,),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StatsCard(
                      x:'',
                      title:'Score' , 
                      Stat: ('${result!.correct}/150') , 
                      icon:'attempted'),
    
                   StatsCard(
                    x:'%',
                    title:'Accuracy' , 
                    Stat:(( result!.correct/(result!.correct+result!.incorrect))*100).toStringAsFixed(1) , 
                    icon:'accuracy'),
                  ]
                ),
                const SizedBox(height: 15,),
                 GestureDetector(
                    onTap:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SolutionScreen(
                            list: widget.list,
                            q:widget.list[0],
                            qIndex: 0,
                            testkey: widget.testkey,
                          ),
                        ),
                      );
                    }, 
                    child:Container(
                      padding:const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                      height:MediaQuery.of(context).size.height/10,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(
                          width: 1.3,
                          color: const Color.fromARGB(255, 206, 203, 203)
                        )
                      ),
                      child:const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Solutions',
                              style: TextStyle(
                                color: Color.fromARGB(255, 21, 150, 255),
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                              ),
                              Text('View questions with solutions',)
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    )),
              ],
            ),
          )
          :const Center(child: CircularProgressIndicator(),)
      ),
    );
  }
}