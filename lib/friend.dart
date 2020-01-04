import 'dart:async';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Database.dart';
import 'Database_log.dart';

class friend_info extends StatefulWidget {
  int id;
  friend_info({Key key, @required this.id}): super(key:key);
  @override
  _friend_infoState createState() => _friend_infoState(id);
}

class _friend_infoState extends State<friend_info> {

  int id;
  _friend_infoState(this.id);

  // to get the value received from alertDialog
  FutureOr Function(String value) get onValue => null;
  var cherryTomato = const Color(0xffe94b3c);
  var blackColor = const Color(0xff2d2926);

  // give alert dialog
  Future<String> giveAlertDialog(BuildContext context){

    TextEditingController customControllerAmount = new TextEditingController();
    TextEditingController customControllerReason = new TextEditingController();
    
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
                  hintText: 'Amount'
              ),
              controller: customControllerAmount,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly     //only no can be entered
              ],
            ),
            TextField(
              controller: customControllerReason,
              style: TextStyle(
                fontSize: 20,
                fontFamily: "OpenSans",

              ),
              decoration: new InputDecoration(
                  hintText: ' Reason',
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

            onPressed: ()async{
              int amount = int.parse(customControllerAmount.text.toString());
              amount = -amount;
              await DBLog.db.newLog(Log(amount: amount,reason: customControllerReason.text.toString(),id: id));
              Navigator.of(context).pop("-${customControllerAmount.text.toString()}");
              },
          )
        ],
      );
    });
  }

  // take alert dialog
  Future<String> takeAlertDialog(BuildContext context){
    TextEditingController customControllerAmount = new TextEditingController();
    TextEditingController customControllerReason = new TextEditingController();

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
                  hintText: 'Amount'
              ),
              controller: customControllerAmount,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly     //only no can be entered
              ],
            ),
            TextField(
              controller: customControllerReason,
              style: TextStyle(
                fontSize: 20,
                fontFamily: "OpenSans",

              ),
              decoration: new InputDecoration(
                hintText: '  Reason',
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

            onPressed: () async{
              int amount = int.parse(customControllerAmount.text.toString());

              await DBLog.db.newLog(Log(id: id,reason: customControllerReason.text.toString(),amount: amount));
              Navigator.of(context).pop(customControllerAmount.text.toString());
              },
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
                    onPressed: (){
                      print('No');
                      Navigator.of(context).pop();
                      },
                  ),
                  MaterialButton(
                    child: Text(
                      'Yes',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "OpenSans"
                      ),
                    ),
                    onPressed: ()async{
                      await DBProvider.db.updateBlocked(id);
                      int i = 0;
                      Navigator.of(context).popUntil((_)=>i++ >= 2);
                      },
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

    Future<Client> friend = DBProvider.db.getClient(id);
    Future friendLogs = DBLog.db.getLogs(id);



    return FutureBuilder(
      future: Future.wait([
        friend,
        friendLogs
      ]),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
        if(snapshot.hasData)
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Builder(builder: (context){
              Client fr = snapshot.data[0];
              return CustomScrollView(
                slivers: <Widget>[
                  // Appbar
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: height,

                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(150),

                      // Name, give, take, amount
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Text('${fr.firstName} ${fr.lastName}',
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
                              Text('${fr.amount} \u20B9',
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
                                          backgroundColor: Theme.of(context).primaryColorDark,
                                          content: Text('Amount $onValue added',
                                            style: TextStyle(color: Theme.of(context).primaryColor),),
                                        );
                                        if(onValue != null)
                                          Scaffold.of(context).showSnackBar(mySnackbar);
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
                                        backgroundColor: Theme.of(context).primaryColorDark,
                                        content: Text('Amount $onValue added',
                                          style: TextStyle(color: Theme.of(context).primaryColor),),
                                      );
                                      if(onValue != null)
                                        Scaffold.of(context).showSnackBar(mySnackbar);
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
                        child: fr.image == 'null'?
                        Image.asset(
                          'assets/photos/beach_2.jpg',
                          fit: BoxFit.cover,
                        ):
                        Image.memory(Base64Decoder().convert(fr.image), fit: BoxFit.cover,),
                      ),
                    ),
                  ),

                  // List
                  SliverList(
                    delegate: SliverChildBuilderDelegate((BuildContext context,int index){
                      return ListTile(
                        title: Text('${snapshot.data[1][snapshot.data[1].length - index - 1]["amount"]}'),
                      ) ;
                    },
                      childCount: snapshot.data[1].length
                    ),
                  ),
                ],
              );
            },),
          );
        else
          return Center(child: CircularProgressIndicator(),);
      },
    );
  }
}
