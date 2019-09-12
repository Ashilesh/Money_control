import 'package:flutter/material.dart';
import 'dart:ui';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  EdgeInsetsGeometry pad(int i) {
    if (i % 2 == 0)
      return EdgeInsets.fromLTRB(15, 15, 10, 0);
    else
      return EdgeInsets.fromLTRB(10, 15, 15, 0);
  }

  var cherryTomato = const Color(0xffe94b3c);
  var blackColor = const Color(0xff2d2926);

  call() {
    print('hello');
  }

  final GlobalKey<ScaffoldState> _scaf = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            // to give colors to theme
            primaryColor: cherryTomato,
        ),
        home: Scaffold(
          key: _scaf,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: (){},
            backgroundColor: cherryTomato,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          drawer: Drawer(
            child: SafeArea(
              child: Text('hello'),
            ),
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: false,

                leading: IconButton(
                  icon: Icon(Icons.drag_handle),
                  onPressed: () {
                    print('Drawer clicked!');
                    _scaf.currentState.openDrawer();
                  },
                  iconSize: 40,
                  tooltip: 'Drawer',
                ),
                expandedHeight: 250.0,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Image(
                    image: AssetImage('assets/photos/night_sky.png'),
                    fit: BoxFit.cover,
                  ) ,
                ),

                bottom: PreferredSize(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            //color: Colors.grey.shade200.withOpacity(0.6),
                            child: Text(
                              'Welcome, Ashilesh!',
                              overflow: TextOverflow.fade,
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 30,
                                  color: Colors.white,

                              ),
                            ),
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                          ),
                        )
                      ],
                    ),
                  preferredSize: Size.fromHeight(30),
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
                    return Container(
                      color: Colors.black,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GestureDetector(
                          onTap: () {
                            print('$index clicked!');
                          },
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Image(
                                image: AssetImage('assets/photos/beach_1.jpg'),
                                fit: BoxFit.cover,
                              ),
                              SafeArea(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        color: Colors.grey.withOpacity(0.4),
                                        child: Text(
                                          '$index Grid!',
                                          softWrap: true,
                                          overflow: TextOverflow.fade,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      padding: pad(index),
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
