import 'package:flutter/material.dart';
import 'welcome.dart';
import 'home.dart';
import 'database.dart';
import 'friend.dart';


void main() {

  var cherryTomato = const Color(0xffe94b3c);
  var blackColor = const Color(0xff2d2926);

  runApp(MaterialApp(
      theme: ThemeData(
          primaryColor: blackColor
      ),
      home: friend_info())
  );
}


