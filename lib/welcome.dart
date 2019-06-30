//this file is for welcome page
//in which user will see this page only once
//when the app starts

import 'dart:ui';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          // to give colors to theme
          primaryColor: Colors.grey[600]
        ),
        home: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

          // floating action button
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
                        Spacer(flex: 1),

                        // Welcome text
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
                         ),
                        Spacer(flex: 1),

                        // textfield
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(22, 0, 22, 0),

                                child: TextField(
                                  textInputAction: TextInputAction.done,
                                  textCapitalization: TextCapitalization.sentences,
                                  style:  TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontSize: 25,

                                  ),
                                  cursorColor: Colors.grey[600  ],



                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(1),
                                    ),

                                      labelText: 'Name',

                                      contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Spacer(flex: 10,)

              ],
            ),
          )),
    ));
  }
}
