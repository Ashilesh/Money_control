import 'package:flutter/material.dart';
import 'welcome.dart';
import 'home.dart';
import 'friend.dart';
import 'add_friend.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {

  var cherryTomato = const Color(0xffe94b3c);
  var blackColor = const Color(0xff2d2926);

  Future checkName()async{

    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('User Name');
  }

  Future name = checkName();

  runApp(MaterialApp(
      theme: ThemeData(
          primaryColor: cherryTomato,
          primaryColorDark: blackColor,
          backgroundColor: blackColor,
          appBarTheme: AppBarTheme(
            color: blackColor
          ),
        fontFamily: "OpenSans"

      ),
      home: AddFriend()
//      FutureBuilder(
//        future: name,
//        builder: (BuildContext context,AsyncSnapshot snapshot){
//          if(snapshot.data == null)
//            return MyApp();
//          else
//            return Home();
//
//        },
//      ))
  ));
}


