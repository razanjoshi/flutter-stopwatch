import 'package:flutter/material.dart';
import './pay_with_card.dart';

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
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.credit_card)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.attach_money)),
              ],
            ),
            title: Text('Payment Method'),
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