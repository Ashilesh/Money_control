import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_control/Demo.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:async/async.dart';
import 'Database.dart';

// ignore: must_be_immutable
class AddFriend2 extends StatelessWidget {

  File friendImage;
  AddFriend2({Key key, @required this.friendImage}) : super(key:key);

  @override
  Widget build(BuildContext context) {

    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();

    return Scaffold(

      resizeToAvoidBottomInset: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Submit',style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20),),
        backgroundColor: Theme.of(context).primaryColorDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        onPressed: ()async{
          var img;
          if(friendImage != null)
            img = base64.encode(friendImage.readAsBytesSync());


          // Adding friends info to database
         var a = await DBProvider.db.newClient(Client(
              firstName: firstNameController.text,
              image: img,
              lastName: lastNameController.text ));

         print('above insertion');
          print('variable a :$a');


          Navigator.pop(context, true);
        },

      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          friendImage == null ?
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/photos/beach_2_low.jpg'),
                    fit: BoxFit.cover)),

          ) :
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(friendImage),
                    fit: BoxFit.cover)),

          ),

          Center(
            child: Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color:  Color.fromRGBO(0, 0, 0, 0.7),

              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  TextField(
                    controller: firstNameController,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26
                    ),
                    decoration: new InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(20)

                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      labelText: 'First Name',

                    ),
                  ),

                  Container(
                    height: 20,
                  ),

                  TextField(
                    controller: lastNameController,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26
                    ),
                    decoration: new InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(20)

                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      labelText: 'Last Name',

                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
