import 'package:flutter/material.dart';
import 'package:iota/components/question_model.dart';
import 'package:iota/service/q_service.dart';
import 'package:iota/service/subject_service.dart';


// ignore: must_be_immutable
class questionPage extends StatefulWidget {

  final QuestionModel q;
  final List<QuestionModel>list;
  int qIndex;
  String subject;

  questionPage({super.key,
  required this.subject,
  required this.q,
  required this.list,
  required this.qIndex});

  @override
  State<questionPage> createState() => _questionPageState();
}

class _questionPageState extends State<questionPage> {

  int? selectedAns;
  bool isAnswerChecked=false;
  late DailyStats stats;
  late SubjectStat ss;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  void _loadStats() async {
    stats = await DailyStats.load();
    ss=await SubjectStat.load(widget.subject);
    setState(() {});
  }

  Future<void> checkAnswer() async{
    stats.update(isCorrect:selectedAns==widget.q.answer);
    stats.save();
    if (!ss.isAttempted) {
      ss.update(isCorrect:selectedAns==widget.q.answer);
    ss.save();
    }
    setState(() {
      isAnswerChecked=true;
    });
  }

  void selectOption(int index){
    setState(() {
      selectedAns=(selectedAns==index)?null:index;
    });
  }

  void navigateHandle(int ind){
    if (ind>=0 && ind<widget.list.length) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=>questionPage(
          subject: widget.subject,
          q:widget.list[ind],
          qIndex: ind,
          list:widget.list,
        )
      ));
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body:Padding(
        padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 20),
        child:SingleChildScrollView(
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
                  padding: const EdgeInsets.symmetric(vertical:9),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(
                          width: isAnswerChecked?
                              (i==selectedAns)?
                              (i==widget.q.answer)?
                                4
                              :4
                            :2.5:2.5,
                          color:isAnswerChecked?
                              (i==selectedAns)?
                              (i==widget.q.answer)?
                              Colors.green
                              :Colors.red
                            :const Color.fromARGB(255, 206, 203, 203)
                          :const Color.fromARGB(255, 206, 203, 203)
                        )
                      ),
                  child: ListTile( 
                    title:Row(
                      children: [
                        const SizedBox(width: 4,),
                        Text('${i+1} .'),
                        const SizedBox(width:4,),
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
                    trailing: isAnswerChecked?
                        (i==selectedAns)?
                           (i==widget.q.answer)?
                              const Icon(Icons.check,color: Colors.green,size: 45,)
                              :const Icon(Icons.close,color: Colors.red,size: 45,)
                            :null :null,
                    selected:selectedAns==i,
                    onTap: () => selectOption(i),
                  ),
                ),
                const SizedBox(height: 15,),
              
                isAnswerChecked?
                  Text('Answer:\n     ${widget.q.options[widget.q.answer]}',
                  style:const TextStyle(
                  fontFamily: 'Noto Serif Bengali',
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                ),
                )
                :const Text(''),
          
                const SizedBox(height: 40),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height:MediaQuery.of(context).size.height/18.3,
                      width: MediaQuery.of(context).size.width/7,
                      child: ElevatedButton(
                        style:ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5))
                        ),
                        onPressed:widget.qIndex==0?null:
                        (){navigateHandle(widget.qIndex-1);},
                        child:const Icon(Icons.arrow_back_ios,size: 30,)
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/2,
                      height:MediaQuery.of(context).size.height/18.3,
                      child: ElevatedButton(
                        style:ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5))
                        ),
                        onPressed:checkAnswer,
                        child:const Text("Check Answer",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height/18.3,
                      width: MediaQuery.of(context).size.width/7,
                      child: ElevatedButton(
                        style:ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5))
                        ),
                        onPressed:widget.qIndex==widget.list.length-1?null:
                        (){navigateHandle(widget.qIndex+1);}, 
                        child:const Icon(Icons.arrow_forward_ios,size: 30,)
                        
                      ),
                    )
                  ],
                ),
              const SizedBox(height: 40,)
            ],
          ),
        ),
      )
    );
  }
}