import 'dart:convert';

import 'package:flutter/material.dart';
import 'Database.dart';

class Demo extends StatelessWidget {

  Future<Client> recover()async{

    return await DBProvider.db.getClient(8);

  }

  @override
  Widget build(BuildContext context){
    final client = recover();
    return Container(
      child: FutureBuilder(
        future: client,
        builder: (BuildContext context,AsyncSnapshot<Client> snapshot){

         if(snapshot.hasData) {
           print('future builder : ${snapshot.data.image == 'null'}');
           return snapshot.data.image == 'null' ?
           Center(
             child: Text('No Image', style: TextStyle(color: Colors.white),),
           ) :
            Stack(
              children: <Widget>[
                Image.memory(
                  Base64Decoder().convert(snapshot.data.image), fit: BoxFit.cover,),
                Center(
                  child: Text('Hi', style: TextStyle(color: Colors.white),),
              )
              ],
            );
         }
         else
           return Center(
             child: CircularProgressIndicator(),
           );
        },),
    );
  }
}
