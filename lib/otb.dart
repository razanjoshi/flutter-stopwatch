import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


void main() => runApp(new Otb());

String cnt;

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

  Future<String> getData(dynamic country) async {
    var response = await http.get(
      Uri.encodeFull(url+country),
      headers: {
        'Accept': 'application/json'
      }
    );
    try {
      List data = json.decode(response.body);
      print(data);
    } catch(_) {
      print('Authentication Error');
    }
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
                if (cnt != null && !cnt.isEmpty) {
                  // If the form is valid, display a Snackbar.
                  getData(cnt);
                  Navigator.push(context, MaterialPageRoute<void>(
                    builder: (BuildContext context) {                
                        return Scaffold(                
                            appBar: AppBar(
                                title:
                                  Text(
                                    "Holiday Results",
                                  ), ),
                              body: ListView(
                                // child: FlatButton(
                                //   child: Text('POP'),
                                //   onPressed: () {
                                //     Navigator.pop(context);
                                //   },          
                                // ), 
                                children: <Widget>[
                                  Container(
                                        margin:EdgeInsets.all(8.0),
                                        child: Card(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                            child: InkWell(
                                              onTap: () => print("ciao"),     
                                              child: Column(
                                                    children: <Widget>[
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(8.0),
                                                            topRight: Radius.circular(8.0),
                                                          ),
                                                          child: Image.network(
                                                            'https://i.onthebeach.co.uk/v1/hotel_images/7bc4f24e-2c59-4f6f-bd2e-8655c2cd5f1d/cover/767/620/medium/1.0/sol-tenerife',
                                                            width: 300,
                                                            height: 150,
                                                            fit:BoxFit.fill  

                                                          ),
                                                        ),
                                                        ListTile(
                                                          title: Text('Sol Tenerife'),
                                                          subtitle: Text('Tenerife'),
                                                        ),
                                                    ],
                                              ),
                                            ),
                                        ),
                                  ),
                                ], 
                              ),
                          );
                      },            
                  ));          
                  print("Country: " + cnt);
                }
                else {
                  Scaffold.of(context)
                    .showSnackBar(SnackBar(duration: Duration(seconds: 1), content: Text("Validation error")));
                }
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
        
        child: DropdownButton<String>(
          items: [
            DropdownMenuItem<String>(
              child: Text('Malta'),
              value: 'malta',
            ),
            DropdownMenuItem<String>(
              child: Text('Kathmandu'),
              value: 'ktm',
            ),
            DropdownMenuItem<String>(
              child: Text('UK'),
              value: 'UK',
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
      );
    }
  }

