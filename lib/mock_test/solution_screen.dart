import 'package:flutter/material.dart';
import 'package:iota/mock_test/mock_test_service.dart';

class SolutionScreen extends StatefulWidget {
  final List<TestQuestionModel> list;
  final TestQuestionModel q;
  final int qIndex;
  final String testkey;

  SolutionScreen({
    super.key,
    required this.list,
    required this.q,
    required this.qIndex,
    required this.testkey,
  });

  @override
  State<SolutionScreen> createState() => _SolutionScreenState();
}

class _SolutionScreenState extends State<SolutionScreen> {

  void QuickNavigate(int ind) {
    if (ind >= 0 && ind < widget.list.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SolutionScreen(
            list: widget.list,
            q: widget.list[ind],
            qIndex: ind,
            testkey: widget.testkey,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemCount: widget.list.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Container(
                margin: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: widget.list[index].userAnswer==null?
                  Colors.grey
                  :widget.list[index].userAnswer==widget.list[index].answer?Colors.green
                  :widget.list[index].answer!=widget.list[index].userAnswer?Colors.red:Colors.grey
                ),
                child: Center(child: Text("${index + 1}")),
              ),
              onTap: () {
                QuickNavigate(index);
              },
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 30),
        child: SingleChildScrollView(
          child: ListView(
            shrinkWrap:true,
            physics:const NeverScrollableScrollPhysics(),
            children: [
              Text('Q${widget.qIndex+1}. ${widget.q.question}',
              style: const TextStyle(
                fontFamily: 'Noto Serif Bengali',
                fontWeight: FontWeight.w600,
                fontSize: 20
              ),),
              const SizedBox(height: 20,),
              for (int i = 0; i < widget.q.options.length; i++)
                Container(
                  margin: const EdgeInsets.only(bottom: 9),
                  padding: const EdgeInsets.symmetric(vertical:9),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(
                      width: 2.5,
                      color: _getOptionColor(i),
                    ),
                  ),
                  child: ListTile(
                    title: Row(
                      children: [
                        const SizedBox(width: 4),
                        Text('${i + 1} .'),
                        const SizedBox(width:4),
                        Expanded(
                          child: Text(
                            widget.q.options[i],
                            style: _getOptionTextStyle(i),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 40,),
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
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
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
                        child:const Text('Next',
                        style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),)
                      ),
                    ],),
            ],
          ),
        ),
      ),
    );
  }

  Color _getOptionColor(int index) {
  if (index == widget.q.answer) {
    return Colors.green; 
  } else if (index == widget.q.userAnswer) {
    if (widget.q.userAnswer == widget.q.answer) {
      return Colors.green; 
    } else {
      return Colors.red;
    }
  } else {
    return const Color.fromARGB(255, 206, 203, 203);
  }
}

TextStyle _getOptionTextStyle(int index) {
  if (index == widget.q.answer) {
    return const TextStyle(fontWeight: FontWeight.bold,fontFamily:'Noto Serif Bengali',fontSize: 20, );
  } else if (index == widget.q.userAnswer) {
    if (widget.q.userAnswer == widget.q.answer) {
      return const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 18, 250, 25),fontSize: 23,fontFamily: 'Noto Serif Bengali');
    } else {
      return const TextStyle(fontWeight: FontWeight.bold, color: Colors.red,fontSize: 23,fontFamily: 'Noto Serif Bengali');
    }
  } else {
    return const TextStyle(
      fontFamily: 'Noto Serif Bengali',
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ); 
  }
}
}