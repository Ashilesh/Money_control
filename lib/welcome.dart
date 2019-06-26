//this file is for welcome page
//in which user will see this page only once
//when the app starts

import 'dart:ui';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Material(
          //if material is not root then we get yellow lines under Text

          child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/photos/beach_2.jpg'),
                      fit: BoxFit.cover)),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Welcome!',
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.grey[600],
                            fontFamily: "OpenSans"
                        ),
                      ),
                    )
                  ],
                ),
              )
          ),
        )
    );
  }
}
