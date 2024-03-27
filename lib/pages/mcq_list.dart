import 'package:flutter/material.dart';
import 'package:iota/components/progressbar.dart';
import 'package:iota/pages/q_page.dart';
import 'package:iota/components/question_model.dart';
import 'package:iota/service/q_service.dart';
import 'package:iota/service/subject_service.dart';


// ignore: must_be_immutable
class MCQList extends StatefulWidget {
  
  String subjson;
  String subject;
  MCQList({super.key,required this.subjson,required this.subject});

  @override
  State<MCQList> createState() => _MCQListState();
}

class _MCQListState extends State<MCQList> {

  String selectedCategory = 'All';

  SubjectStat? sst;
  late Future<List<QuestionModel>>Q;
  List<QuestionModel> q=[];
  List<QuestionModel> questions = [];
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    _loadSubStat();
    Q=QuestionDataService.fetchQuestion('data/${widget.subjson}');
    _getCategories();
  }

   Future<void> _loadSubStat() async {
    sst = await SubjectStat.load(widget.subject);
    if (mounted) {
      setState(() {});
    }
  }

    Future<void> _getCategories() async {
    final questions = await Q;
    categories = questions.map((q) => q.category).toSet().toList();
    if (!categories.contains('All')) {
      categories.add('All');
    }
    if (mounted) {
      setState(() {});
    }
  }

  void _onCategoryChange(String? newCategory) {
    setState(() {
      selectedCategory = newCategory ?? 'All';
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:AppBar(
          toolbarHeight: 100,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 20),
              ProgressBar(sst: sst!),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                DropdownButton<String>(
              padding:const EdgeInsets.symmetric(horizontal: 7),
              dropdownColor: const Color.fromARGB(255, 255, 245, 161),
              value: selectedCategory,
              items: categories
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ))
                    .toList(),
                  onChanged: _onCategoryChange,
                  ),
                  Text("${sst!.attempted/10}%",
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
        ) ,
        body: FutureBuilder(
          future: Q, 
          builder:(context,snapshot){
            if (snapshot.hasError) {
              return Center(child: Text('Error:${snapshot.error}'),);
            }else if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }
            else if (snapshot.hasData) {
              final allQuestions = snapshot.data as List<QuestionModel>;
              final filteredQuestions = selectedCategory == 'All'
                  ? allQuestions
                  : allQuestions.where((q) => q.category == selectedCategory).toList();
              return ListView.builder(
                itemCount:filteredQuestions.length,
                itemBuilder: (context, index) {
            return GestureDetector(
              
            onTap: () {
                   Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>questionPage(
                      subject:widget.subject ,
                      q: filteredQuestions[index],
                      list: filteredQuestions,
                      qIndex: index,)
                  ));
            },
    
            child:Padding(
                  padding: const EdgeInsets.symmetric(horizontal:5,vertical: .5),
                  child: Card(
                    surfaceTintColor: Colors.blue,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 14),
                      height: 50,
                      width:MediaQuery.of(context).size.width/1.27,
                      child: Row(
                        children: [
                          Text("${index+1} ."),
                          const SizedBox(width: 6,),
                          Expanded(child: Text(
                            filteredQuestions[index].question,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 17,
                              fontFamily: 'Noto Serif Bengali',
                              fontWeight: FontWeight.w400
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                  ),
                );
                }
              );
            }else{
              return const Center(child: Text('Unknown Error'),);
            }
          } 
          )
        ),
    );
  }
} 
