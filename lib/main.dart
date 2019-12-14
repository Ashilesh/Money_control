import 'package:flutter/material.dart';
import 'welcome.dart';
import 'home.dart';
import 'database.dart';
import 'friend.dart';
import 'add_friend.dart';


void main() {

  var cherryTomato = const Color(0xffe94b3c);
  var blackColor = const Color(0xff2d2926);

  runApp(MaterialApp(
      theme: ThemeData(
          primaryColor: cherryTomato,
          backgroundColor: blackColor,
          appBarTheme: AppBarTheme(
            color: blackColor
          ),
        fontFamily: "OpenSans"

      ),
      home: Home())
  );
}


