import 'package:flutter/material.dart';
import 'dart:ui';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  EdgeInsetsGeometry pad(int i) {
    if (i % 2 == 0)
      return EdgeInsets.fromLTRB(10, 10, 5, 0);
    else
      return EdgeInsets.fromLTRB(5, 10, 10, 0);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          // to give colors to theme
            primaryColor: Colors.grey[600]
        ),
        home: Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            pinned: false,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Demo'),
              background: Image(
                image: AssetImage('assets/photos/morning.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: 0.70,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                   Container(
                     child:  ClipRRect(
                       borderRadius: BorderRadius.circular(10),
                       child: Image(
                         image: AssetImage('assets/photos/beach_1.jpg'),
                         fit: BoxFit.cover,
                       ),
                     ),
                     padding: pad(index),
                   )
                  ],
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    ));
  }
}
