import "package:flutter/material.dart";
import 'package:travel_buddy_finder/MyPage.dart';
import 'package:travel_buddy_finder/SearchPage.dart';

import 'FeedPage.dart';
import 'InterestPage.dart';

class BasicBottomNavigation extends StatefulWidget {
  const BasicBottomNavigation(
      {Key? key, required this.user, required this.password})
      : super(key: key);
  final String user;
  final String password;

  @override
  State<BasicBottomNavigation> createState() => _BasicBottomNavigationState();
}

class _BasicBottomNavigationState extends State<BasicBottomNavigation> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //contains list of available pages to navigate to
        //followed https://nikkigoel.com/state-persistence-techniques-for-the-flutter-bottom-navigation-bar#heading-implementation

        body: [
          FeedPage(user: widget.user, password: widget.password),
          SearchPage(user: widget.user,password: widget.password,),
          InterestPage(user:widget.user,password:widget.password),
          Profile(user:widget.user,password:widget.password),
        ][currentIndex],
        //add button that allows for trips to be created

        bottomNavigationBar: BottomNavigationBar(

          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;

              /// Switching tabs
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.map), label: "feed",backgroundColor: Colors.cyan),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "search",backgroundColor: Colors.red),
            BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "interest",backgroundColor: Colors.pink),
            BottomNavigationBarItem(icon: Icon(Icons.person),label:"profile",backgroundColor: Colors.lightBlue)
          ],
        ),
      ),
    );
  }
}
