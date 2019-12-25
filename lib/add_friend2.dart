import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class AddFriend2 extends StatelessWidget {

  File friendImage;
  AddFriend2({Key key, @required this.friendImage}) : super(key:key);

  Future<String> imagePath()async{
    Directory dir = await getApplicationDocumentsDirectory();
    String local = dir.path;

    return '$local/assets/photos/beach_2_low.jpg';
  }


  @override
  Widget build(BuildContext context) {

    Future<String> img = imagePath();


    return Scaffold(

      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Submit',style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20),),
        backgroundColor: Theme.of(context).primaryColorDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        onPressed: (){},

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
          Image.file(friendImage),

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
