import 'package:flutter/material.dart';
import 'database_helper.dart';

class Data extends StatefulWidget {
  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {

  call()async{
    Transaction t = Transaction();
    t.amount = 1002;

    DatabaseHelper dh = DatabaseHelper.instance;
    int id = await dh.insert(t);

    t = null;
    t = await dh.queryTrans(4);

    if(t == null)
      print('NULL!!!!!');
    else
      print('read row ${t.amount} and id is ${t.id}');
  }
  @override
  Widget build(BuildContext context) {

    call();
    return MaterialApp(
      home: Scaffold(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SafeArea(
              child: Text('hello'),
            )
          ],
        ),
      ),
    );
  }
}
