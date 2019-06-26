//this file is for welcome page
//in which user will see this page only once
//when the app starts

import 'dart:ui';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        home: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

          floatingActionButton: FloatingActionButton(
           onPressed: null,
           backgroundColor: Colors.grey[700],
           foregroundColor: Colors.grey[50],
              child: Icon(
                Icons.navigate_next,
              ),
           ),

             body: Container(

               decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/photos/beach_2.jpg'),
                  fit: BoxFit.cover)),
                child: SafeArea(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        Row(
                           children: <Widget>[
                             Expanded(
                               child: Text(
                                 'Welcome!',
                                 textAlign: TextAlign.center,
                                 style: TextStyle(
                                     fontSize: 40,
                                     color: Colors.grey[600],
                                     fontFamily: "OpenSans"),
                               ),
                             )
                           ],
                         )

              ],
            ),
          )),
    ));
  }
}
