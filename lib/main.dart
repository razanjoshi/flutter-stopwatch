import 'package:flutter/material.dart';
import './lap_records.dart';
import './stopwatch.dart';
import './otb.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

void main() {
  runApp(MainPage( ));
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }

}

int tabNumber =  0;

class MainPageState extends State<MainPage>{
  int _selectedPage = 0;
  final _appBarTitle = [
    "Let's get you on the beach!",
    'StopWatch',
    'Lap Time Logs'
  ];

  final _pageOptions = [
    Otb(),
    TimerApp(),
    LapRecords(),
  ];

  Color gradientStart = const Color(0xfffedc07); //Change start gradient color here
  Color gradientEnd = const Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    var appBarCondition = GradientAppBar(
      title: Text(_appBarTitle[_selectedPage], style: TextStyle(color: Color(0xff17317f))),
      backgroundColorStart: gradientStart,
      backgroundColorEnd: gradientEnd,
    );

    return MaterialApp(
      title: 'On The Beach',
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        appBar: (_selectedPage > 0) ? appBarCondition : null,

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage, // this will be set when a new tab is tapped
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
              tabNumber = index;
              cnt = '';
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

