//this file is for welcome page
//in which user will see this page only once
//when the app starts for first time

import 'dart:ui';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatelessWidget {

  final nameController = TextEditingController();

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
           onPressed : ()async{

             final prefs = await SharedPreferences.getInstance();
             prefs.setString('User Name', nameController.text);

             print(nameController.text);
             print('click');
            Navigator.push(context, new MaterialPageRoute(builder: (context) => Home()));
           },
           backgroundColor: Colors.grey[700],
           foregroundColor: Colors.grey[50],
              child: Icon(
                Icons.navigate_next,
              ),
           ),

             body: Container(

               decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/photos/beach_2_low.jpg'),
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
                                  controller: nameController,
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
