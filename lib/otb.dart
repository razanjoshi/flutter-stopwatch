import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './holiday_landing_page.dart';
import 'dart:async';
import 'dart:convert';

import 'package:stopwatch/holiday_landing_page.dart';


void main() => runApp(new Otb());

String cnt;
List data;

class Otb extends StatelessWidget {
  Color gradientStart = const Color(0xff00b5ea); //Change start gradient color here
  Color gradientEnd = const Color(0xffffffff);
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: new Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0.2,
                0.4,
                0.6,
                0.9
              ],
              colors: [gradientStart, Color(0xff79c5e8), Color(0xffb6ecec), gradientEnd])
          ),
          
          child: MyCustomForm(),
        ),
      ),
    );
  }
}


// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  
  String url = 'http://localhost:3001/api/v1/search/holidays?country=';
  // I have used my own private app's API endpoint here

  Future<String> getData(dynamic country) async{
    final dest = url+country;
    print("Inside function url: " + dest);
    var response = await http.get(
      Uri.encodeFull(dest),
      headers: {
        'Accept': 'application/json'
      }
    );
    setState(() {
      Iterable result = json.decode(response.body);
      data = result.toList();
    });
    print("Inside function country: " + country);
    print("Inside function data: " + data.toString());
  }
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Image(
            image: NetworkImage('https://upload.wikimedia.org/wikipedia/en/thumb/8/8d/On_the_Beach_logo.svg/1200px-On_the_Beach_logo.svg.png'),
            height: 150,
            width: 200,
          ),
          DropdownExample(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                setState(() {});
                if (cnt != null) {
                  print("Country: " + cnt);
                  getData(cnt);
                  print("data" + data.toString());
                  if (data.length != 0 ) {
                    Navigator.push(context, MaterialPageRoute<void>(
                      builder: (BuildContext context) {                
                          return Scaffold(                
                              appBar: PreferredSize(
                                preferredSize: Size.fromHeight(10.0),
                                child:  FlexibleSpaceBar(
                                  centerTitle: true,
                                  title: Text(data.length.toString() + " hotels found",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),),
                                ),
                              ),
                              body: ListView.builder(
                                itemCount: data == null? 0 : data.length,
                                itemBuilder: (BuildContext context, i){
                                  return Center(
                                    child: Card(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                        child: InkWell(
                                          onTap: () => Navigator.push(context, MaterialPageRoute<void>(
                                                        builder: (BuildContext context) => new HolidayLandingPage(data[i]), ),),    
                                          child: Column(
                                                children: <Widget>[
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(8.0),
                                                        topRight: Radius.circular(8.0),
                                                      ),
                                                      child: Image.network(
                                                        data[i]["thumbnail_url"],
                                                        fit:BoxFit.fill

                                                      ),
                                                    ),
                                                    ListTile(
                                                      title: Text(data[i]["hotel"]),
                                                      subtitle: Text(data[i]["country"]),
                                                      trailing: Text("£" + (data[i]["price"]).toString()),
                                                    ),
                                                ],
                                          ),
                                        ),
                                    ),
                                  );
                                }
                              ),
                            );
                        },            
                    ));          
                  }
                  else if(cnt != null && data.length == 0) {
                    Scaffold.of(context)
                      .showSnackBar(SnackBar(duration: Duration(seconds: 1), content: Text("No Holidays Found")));
                  }
                  else {
                    Scaffold.of(context)
                      .showSnackBar(SnackBar(duration: Duration(seconds: 1), content: Text("Validation error")));
                  }
                };
              },
              textColor: Color(0xff17317f),
              color: Colors.yellow,
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Search",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DropdownExample extends StatefulWidget {
    @override
    _DropdownExampleState createState() {
      return _DropdownExampleState();
    }
  }
  
  class _DropdownExampleState extends State<DropdownExample> {
    String _value;
  
    @override
    Widget build(BuildContext context) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              color: Colors.white,
              child: DropdownButton<String>(
                items: [
                  DropdownMenuItem<String>(
                    child: Text('Malta'),
                    value: 'Malta',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Spain'),
                    value: 'Spain',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('France'),
                    value: 'France',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Dubai'),
                    value: 'Dubai',
                  ),
                ],
                onChanged: (String value) {
                  setState(() {
                    _value = value;
                    cnt = value;
                  });
                },
                hint: Text('Where To'),
                value: _value,
                iconEnabledColor: Colors.yellow,
                isExpanded: true,
                isDense: true,
              ),
            )
          ],
          
      ));
    }
  }

