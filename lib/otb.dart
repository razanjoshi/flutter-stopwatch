import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


void main() => runApp(new Otb());

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
  
  String url = 'http://localhost:3001/api/v1/search/holidays?country=UK';
  // I have used my own private app's API endpoint here

  Future<String> getData() async {
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {
        'Accept': 'application/json'
      }
    );
    try {
      List data = json.decode(response.body);
      print(data);
    } catch(_) {
      print('WTF');
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
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Where To'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your destination.';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Searching Holidays..')));
                  getData();

                  
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
