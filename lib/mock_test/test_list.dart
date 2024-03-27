import 'package:flutter/material.dart';
import 'package:iota/mock_test/test_card.dart';

class TestList extends StatefulWidget {
  const TestList({super.key});

  @override
  State<TestList> createState() => _TestListState();
}

class _TestListState extends State<TestList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Row(
          children: [
             SizedBox(width: 20,),
             Text('Full Syllabus Mock Tests',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 25),
          child: Column(
            children:[
              TestCard(testJson: 'mock_1.json',testkey: 'mock_1',title: 'Mock Test - 1',),
              //TestCard(testJson: 'mock_2.json',testkey: 'mock_2',title: 'Mock Test - 2',)
            ] 
          ),
        ),
      ),
    );
  }
}