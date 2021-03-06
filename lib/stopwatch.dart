import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(TimerApp( ));
}

class TimerApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TimerAppState();
  }
}

class TimerAppState extends State<TimerApp> {
  

  static const duration = const Duration(seconds: 1);
  int secondsPassed = 0;
  bool isActive = false;

  Timer timer;

  void handleTick() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  List<String> _laptime = [''];

  @override
  Widget build(BuildContext context) {
    if (timer == null)
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });

    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;
    int hours = secondsPassed ~/ (60 * 60);

    return MaterialApp(
      title: 'Stopwatch',
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomTextContainer(
                      label: 'HRS', value: hours.toString().padLeft(2, '0')),
                  CustomTextContainer(
                      label: 'MIN', value: minutes.toString().padLeft(2, '0')),
                  CustomTextContainer(
                      label: 'SEC', value: seconds.toString().padLeft(2, '0')),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: RaisedButton(
                  child: Text(isActive ? 'STOP' : 'START'),
                  onPressed: () {
                    setState(() {
                      isActive = !isActive;
                    });
                  },
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 15),
                child: RaisedButton(
                  child: Text('RESET'),
                  onPressed: () {
                    setState(() {
                      isActive = false;
                      secondsPassed = 0;
                      _laptime = [''];
                    });
                  },
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 15),
                child: RaisedButton(
                  child: Text('Lap'),
                  onPressed: () {
                    setState(() {
                      if (secondsPassed > 0)
                        _laptime.add('lap time: ' + secondsPassed.toString());
                    });
                  },
                ),
              ),
              Column(
                children: _laptime
                  .map((element) => Card(
                        child: Column(
                          children: <Widget>[
                            Text(element)
                          ],
                        ),
                      ))
                  .toList()),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextContainer extends StatelessWidget {
  CustomTextContainer({this.label, this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(20),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(10),
        color: Colors.black87,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
              color: Colors.red,
              fontSize: 54,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$label',
            style: TextStyle(
              color: Colors.white70,
            ),
          )
        ],
      ),
    );
  }
}