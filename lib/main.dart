import 'package:flutter/material.dart';
import 'welcome.dart';
import 'home.dart';
import 'friend.dart';
import 'add_friend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'Database_log.dart';


void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  var cherryTomato = const Color(0xffe94b3c);
  var blackColor = const Color(0xff2d2926);

  Future checkName()async{

    final prefs = await SharedPreferences.getInstance();

    print('${prefs.getString('User Name')}  name');
    String name = await prefs.getString('User Name');

    return name == null ? '-': name;
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
      home:
//      FutureBuilder(
//        future: res_log,
//        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
//          if(snapshot.hasData)
//            return Text('query received!', style: TextStyle(color: Theme.of(context).primaryColor),);
//          else
//            return Center(
//              child: CircularProgressIndicator(),
//            );
//        },
//      )));
      FutureBuilder(
        future: name,
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            if(snapshot.data == '-')
              return MyApp();
            else
              return Home();
          }
          else
            return CircularProgressIndicator();
        },
      )));

}


