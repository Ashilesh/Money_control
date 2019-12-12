import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class friend_info extends StatefulWidget {
  @override
  _friend_infoState createState() => _friend_infoState();
}

class _friend_infoState extends State<friend_info> {
  FutureOr Function(String value) get onValue => null;
  var cherryTomato = const Color(0xffe94b3c);
  var blackColor = const Color(0xff2d2926);

  // give alert dialog
  Future<String> giveAlertDialog(BuildContext context){

    TextEditingController customController = new TextEditingController();

    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("You have to give to your friend",
                  style: TextStyle(
                    fontSize: 20
                  ),
              ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Opensans",
              ),
              decoration: new InputDecoration(
                prefix: Text('-'),
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w600
                  ),
                  labelText: 'Amount'
              ),
              controller: customController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly     //only no can be entered
              ],
            ),
            TextField(
              style: TextStyle(
                fontSize: 20,
                fontFamily: "OpenSans",

              ),
              decoration: new InputDecoration(
                  labelText: 'Reason',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w600
                ),

              ),

            )
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),

        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Text('Subtract',
              style: TextStyle(
                color: blackColor,
                fontWeight: FontWeight.bold
                ),
              ),
            color: Colors.redAccent,

            onPressed: (){Navigator.of(context).pop(customController.text.toString());},
          )
        ],
      );
    });
  }

  // take alert dialog
  Future<String> takeAlertDialog(BuildContext context){
    TextEditingController customController = new TextEditingController();

    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("You will recieve from your friend",
          style: TextStyle(
              fontSize: 20
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Opensans",
              ),
              decoration: new InputDecoration(
                  prefix: Text('+'),
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w600
                  ),
                  labelText: 'Amount'
              ),
              controller: customController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly     //only no can be entered
              ],
            ),
            TextField(
              style: TextStyle(
                fontSize: 20,
                fontFamily: "OpenSans",

              ),
              decoration: new InputDecoration(
                labelText: 'Reason',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w600
                ),

              ),

            )
          ],
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),

        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Text('Add',
              style: TextStyle(
                  color: blackColor,
                  fontWeight: FontWeight.bold
              ),
            ),
            color: Colors.green,

            onPressed: (){Navigator.of(context).pop(customController.text.toString());},
          )
        ],
      );
    });
  }

  deleteAlertDialog(BuildContext context){
    return showDialog(context: context,builder: (context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Do you really want to delete it?',
              style: TextStyle(
                  fontSize: 25
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    child: Text(
                      'No',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "OpenSans"
                      ),
                    ),
                    onPressed: (){print('No');},
                  ),
                  MaterialButton(
                    child: Text(
                      'Yes',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "OpenSans"
                      ),
                    ),
                    onPressed: (){print('No');},
                  )
                ],
              ),
          ),
          ],
        )

      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;


    return Scaffold(
      body: Builder(builder: (context){
        return CustomScrollView(
          slivers: <Widget>[
            // Appbar
            SliverAppBar(
              pinned: true,
              expandedHeight: height,

              bottom: PreferredSize(
                preferredSize: Size.fromHeight(143),

                // Name, give, take, amount
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
                        Text('- \u20B9 540',
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
                                    color: cherryTomato,
                                    fontFamily: "OpenSans",
                                    fontSize: 30
                                ),
                              ),
                              onPressed: () {
                                giveAlertDialog(context).then((onValue){
                                  SnackBar mySnackbar = SnackBar(
                                    content: Text('Amount $onValue'),
                                  );
                                  Scaffold.of(context).showSnackBar(mySnackbar);
                                  print('in pressed!');
                                });
                              }
                          ),
                        ),
                        Expanded(
                          child: FlatButton(
                            child: Text('Take',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontFamily: "OpenSans",
                                  fontSize: 30
                              ),
                            ),
                            onPressed: () {
                              takeAlertDialog(context).then((onValue){
                                SnackBar mySnackbar = SnackBar(
                                  content: Text('Amount received'),
                                );
                              });
                            },
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 10,
                    ),
                    Container(
                        alignment: Alignment.center,

                        color: Colors.transparent,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),

                                  child: Container(
                                    height: 40,
                                    color: cherryTomato,
                                  )
                              ),
                            )
                          ],
                        )
                    )
                  ],
                ),
              ),

              // setting icon
              actions: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      iconSize: 27,
                      color: Colors.white,
                      onPressed: (){deleteAlertDialog(context);},
                    )
                )
              ],

              // background image, parallax
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

            // List
            SliverFixedExtentList(
              itemExtent: 50.0,
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  var cont;



                  cont = Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: Text('list item $index'),
                  );

                  return cont;
                },
              ),
            ),
          ],
        );
      },),
    );
  }
}
