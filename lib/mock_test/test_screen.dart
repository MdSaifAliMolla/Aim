import 'package:flutter/material.dart';
import 'package:iota/mock_test/mock_test_service.dart';
import 'package:iota/mock_test/result_screen.dart';

// ignore: must_be_immutable
class TestScreen extends StatefulWidget {

  final TestQuestionModel q;
  final List<TestQuestionModel>list;
  int qIndex;
  final TimerController time;
  String testkey;

  TestScreen({super.key,
    required this.list,
    required this.q,
    required this.qIndex,
    required this.time,
    required this.testkey
  });

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {

  int currentIndex = 0;
  int? selectedAns;
  //late ScoreManager sm;

  @override
  void initState() {
    super.initState();
    selectedAns = widget.q.userAnswer;
  }
  
  void QuickNavigate(int ind){
    if (ind>=0 && ind<widget.list.length) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=>TestScreen(
          time: widget.time,
          q:widget.list[ind],
          qIndex: ind,
          list:widget.list,
          testkey: widget.testkey,
        )
      ));
    }
  }

  void onSubmit(){
    showDialog(
      context: context, 
      builder:(context){
        return AlertDialog(
          title: const Text('Are you sure?'),
          actions: [
            TextButton(
              onPressed:()async{
                Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context)=>ResultScreen(
                  testkey:widget.testkey,
                  list:widget.list,)
                ));  
              },
              child:const Text('Yes')
            )
          ],
        );
      }
    );
    
  }
void selectOption(int index){
    setState((){
      widget.q.status = (selectedAns == index)
          ? widget.q.status == QuestionStatus.MarkedforReview
              ? QuestionStatus.MarkedforReview
              : QuestionStatus.unattempted
          : QuestionStatus.attempted;
      selectedAns = (selectedAns == index) ? null : index;
      widget.q.userAnswer = selectedAns;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Row(
          children: [
            StreamBuilder<Duration>(
              stream:widget.time.remainingTime,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final t =snapshot.data!;
                  final hours= t.inHours;
                  final minutes =t.inMinutes.remainder(60);
                  final seconds =t.inSeconds.remainder(60);
                  return Text('${hours.toString().padLeft(2,'0')}:${minutes.toString().padLeft(2,'0')}:${seconds.toString().padLeft(2,'0')}');
                }else{
                  return const Text('...');
              }}
            ),
            const Spacer(),
            ElevatedButton(
              style:ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 248, 94, 83),
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5))
              ),
              onPressed:onSubmit, 
              child:const Text('Submit',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),))
          ],
        )
      ),
      drawer: Drawer(
        child: GridView.builder(
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4
          ),
          itemCount: widget.list.length, 
          itemBuilder:(context,index){
            return GestureDetector(
              child: Container(
                margin: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color:widget.list[index].status==QuestionStatus.unattempted
                    ?Colors.grey
                      :widget.list[index].status==QuestionStatus.attempted
                        ?Colors.green
                        :widget.list[index].status==QuestionStatus.MarkedforReview
                      ?Colors.purple
                    :Colors.red
                ),
                child: Center(child: Text("${index+1}"))
              ),
              onTap: () {
                QuickNavigate(index);
              },
            );
          }
        ),
      ),
      body:
        Padding(
            padding:const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 30),
            child: SingleChildScrollView(
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Text('Q${widget.qIndex+1}. ${widget.q.question}',
                    style: const TextStyle(
                      fontFamily: 'Noto Serif Bengali',
                      fontWeight: FontWeight.w600,
                      fontSize: 20
                    ),
                  ),
                  const SizedBox(height: 20,),
                  for(int i=0;i<widget.q.options.length;i++)
                      Container(
                        margin: const EdgeInsets.only(bottom: 9),
                        padding: const EdgeInsets.symmetric(vertical: 9),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              border: Border.all(
                                width:selectedAns==i?4:2.5,
                                color:selectedAns==i?Colors.blue:const Color.fromARGB(255, 206, 203, 203)
                              )
                            ),
                        child: ListTile( 
                          title:Row(
                            children: [
                              const SizedBox(width: 4,),
                              Text('${i+1} .'),
                              const SizedBox(width: 4,),
                              Expanded(
                                child: Text(widget.q.options[i],
                                  style:const TextStyle(
                                  fontFamily: 'Noto Serif Bengali',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                                ),
                              ),
                            ],
                          ),
                          selected:selectedAns==i,
                          onTap: () => selectOption(i),
                        ),
                      ),

                  const SizedBox(height: 40,),
            
                   ElevatedButton(
                    style:ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5))
                    ),
                    onPressed:
                      (){
                        widget.q.status= widget.q.status==QuestionStatus.MarkedforReview?QuestionStatus.unattempted:QuestionStatus.MarkedforReview;
                       },
                    child:const Text('Mark For Review',
                    style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),)
                    ),
                    const SizedBox(height:15),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style:ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5))
                        ),
                        onPressed:widget.qIndex==0?null:
                          (){QuickNavigate(widget.qIndex-1);},
                        child:const Text('Previous',
                        style: TextStyle(
                          color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),)
                      ),
                      ElevatedButton(
                        style:ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5))
                        ),
                        onPressed:widget.qIndex==widget.list.length-1?null:
                          (){
                            QuickNavigate(widget.qIndex+1);
                            
                          },
                        child:const Text('Save and Next',
                        style: TextStyle(
                          color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),)
                      ),
                    ],),
                ],
              ),
            ), 
          )
      );
    }
  }