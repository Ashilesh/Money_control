import 'package:flutter/material.dart';

class friend_info extends StatefulWidget {
  @override
  _friend_infoState createState() => _friend_infoState();
}

class _friend_infoState extends State<friend_info> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var cherryTomato = const Color(0xffe94b3c);
    return Scaffold(

      body: CustomScrollView(
        slivers: <Widget>[
           SliverAppBar(
            pinned: false,

            expandedHeight: height - 100,

            bottom: PreferredSize(
              preferredSize: Size.fromHeight(103),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Text('Ashilesh Sonkusle',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "OpenSans",
                          fontSize: 30
                        ),
                      )
                    ],
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Text('540 \u20B9',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "OpenSans",
                            fontSize: 30
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          child: Text('Give',
                            style: TextStyle(
                                color: Colors.green,
                                fontFamily: "OpenSans",
                                fontSize: 30
                            ),
                          ),
                          onPressed: () { print('Give tapped');},
                        ),
                      ),
                      Expanded(
                        child: FlatButton(
                          child: Text('Take',
                            style: TextStyle(
                                color: cherryTomato,
                                fontFamily: "OpenSans",
                                fontSize: 30
                            ),
                          ),
                          onPressed: () { print('Take tapped');},
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 10,
                  )
                ],
              ),
            ),
            actions: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: IconButton(
                  icon: Icon(Icons.settings),
                  iconSize: 27,
                  color: Colors.white,
                  onPressed: (){},
                )
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              //gradient image
              background: ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.transparent],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: Image.asset(
                  'assets/photos/beach_2_low.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),


          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                  child: Text('grid item $index'),
                );
              },
              childCount: 20,
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: Text('list item $index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
