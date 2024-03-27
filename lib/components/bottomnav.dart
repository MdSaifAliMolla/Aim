import 'package:flutter/material.dart';
import 'package:iota/mock_test/test_list.dart';
import 'package:iota/pages/home.dart';
import 'package:iota/pages/profile.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _page=0;

  List<Widget>pages=[
    const Home(),const TestList(),const ProfilePage()
  ];

  void updatePage(int page){
    setState(() {
      _page=page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar:BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor:Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: updatePage,
        iconSize: 28,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: 40,
              decoration: BoxDecoration(
                border: Border(top: BorderSide(
                  color:_page==0?Colors.blue:Colors.white,
                  width: 5 
                ))
              ),
              child:const Icon(Icons.home_outlined) ,
            ),
            label: ''
          ),
           BottomNavigationBarItem(
            icon: Container(
              width: 40,
              decoration: BoxDecoration(
                border: Border(top: BorderSide(
                  color:_page==1?Colors.blue:Colors.white,
                  width:5 ,
                ))
              ),
              child:const Icon(Icons.text_snippet_outlined) ,
            ),
          label: ''
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 40,
              decoration: BoxDecoration(
                border: Border(top: BorderSide(
                  color:_page==2?Colors.blue:Colors.white,
                  width:5 ,
                ))
              ),
              child:const Icon(Icons.person_outline) ,
            ),
          label: ''
          )
        ]
      ) ,
    );
  }
}