import 'package:flutter/material.dart';
import './stopwatch.dart';

void main() {
  runApp(MainPage( ));
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }

}

class MainPageState extends State<MainPage>{
  int _selectedPage = 0;
  final _pageOptions = [
    Text('Home page'),
    TimerApp(),
    Text('Lap Records'),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage, // this will be set when a new tab is tapped
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.mail),
              title: new Text('Stopwatch'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('LapTimes')
            )
          ],
        ),
        body: _pageOptions[_selectedPage],
      ),
    );
  }
}