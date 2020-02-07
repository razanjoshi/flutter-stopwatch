import 'package:flutter/material.dart';
import './pay_with_card.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

Color gradientStart = const Color(0xff00b5ea); //Change start gradient color here
Color gradientEnd = const Color(0xffffffff);

class Passengers extends StatelessWidget {
  Passengers(this.data);
  dynamic data;
  TabController controller;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: GradientAppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.credit_card)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.attach_money)),
              ],
            ),
            title: Text('Payment Method', style: TextStyle(color: Color(0xff17317f))),
              backgroundColorStart: gradientStart,
              backgroundColorEnd: gradientEnd,
            ),
          body: TabBarView(
            children: [
              PayWithCard(data),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}