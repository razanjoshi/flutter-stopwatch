import 'package:flutter/material.dart';

class HolidayLandingPage extends StatelessWidget {
  HolidayLandingPage(this.data);
  dynamic data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data["hotel"]),
      ),
      body: 
      Center(
        child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: InkWell(
              child: Column(
                    children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                          child: Image.network(
                            data["thumbnail_url"],
                            fit:BoxFit.fill

                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, bottom: 12.0, top:12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    ("£" + data["price"].toString()),
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]
                          
                        ),
                        
                        ListTile(
                          title: Text("Overview"),
                          subtitle: Text(
                            "Situated in the heart of Costa Teguise town centre on the island of"
                                          "Lanzarote, Oasis Lanz Beach is an attractive apartment complex twined"
                                          "together with towering palm trees and boasting a variety of facilities."
                                          "Framed by expansive green gardens and within walking distance of the beach,"
                                          "shops and leisure area, this resort has something for everyone."
                                          "## Please note that building works are currently taking place in this hotel"
                                          "in the reception and part of the main restaurant which is closed off. ##"),
                        ),
                        ButtonTheme(
                          minWidth: 600.0,
                          height: 50.0,
                          child: RaisedButton(
                            onPressed: () {},
                            child: Text("BOOK NOW"),
                            color: Colors.yellow,
                            textColor: Color(0xff17317f),
                          ),
                        )
                    ],
              ),
            ),
        ),
      )
    );
  }
}