import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:money_control/Database_log.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:money_control/add_friend.dart';
import 'Database.dart';
import 'friend.dart';

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
  Future friends;

  // delete option in sidebar
  _delteAll(BuildContext context){
    return showDialog(context: context,builder: (context){
        return AlertDialog(
          backgroundColor: blackColor,

            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),

            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Do you really want to delete all Data?',
                  style: TextStyle(
                      fontSize: 25,
                    color: cherryTomato
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
                              fontFamily: "OpenSans",
                            color: cherryTomato
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
                              fontFamily: "OpenSans",
                            color: cherryTomato
                          ),
                        ),
                        onPressed: ()async{
                          print('yes');
                          await DBProvider.db.deleteAll();
                          await DBLog.db.deleteAll();
                          Navigator.of(context).pop();
                          },
                      )
                    ],
                  ),
                ),
              ],
            )

        );
    }
    ).then((_) {setState(() {

    });});
  }

  _drawer(BuildContext context){

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.70,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Image(
              image: AssetImage('assets/photos/drawer_header_5.jpg'),
              fit: BoxFit.fill,
            ),
            Expanded(
              child: Container(
                color: Colors.black,
                child: Column(

                  children: <Widget>[

                    Container(
                      padding: EdgeInsets.only(top: 50),
                    ),

                    MaterialButton(
                      onPressed: (){
                        print('delete!');
                        _delteAll(context);
                        },
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Icon(
                            Icons.delete_forever,
                            color: cherryTomato,
                            size: 25,
                          ),

                          Opacity(
                            opacity: 0,
                            child: Container(
                              width: 55,
                            ),
                          ),

                          Text(
                            'Delete',
                            style: TextStyle(
                                color: cherryTomato,
                                fontSize: 25
                            ),
                          )
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(top: 20),
                    ),

                    MaterialButton(
                      onPressed: (){print('About!');},
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Icon(
                            Icons.error,
                            color: cherryTomato,
                            size: 25,
                          ),

                          Opacity(
                            opacity: 0,
                            child: Container(
                              width: 55,
                            ),
                          ),

                          Text(
                            'About',
                            style: TextStyle(
                                color: cherryTomato,
                                fontSize: 25
                            ),
                          )
                        ],
                      ),
                    ),

                    Spacer(flex: 1),

                    Text(
                      'v1.0',
                      style: TextStyle(
                          color: cherryTomato
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }




  final GlobalKey<ScaffoldState> _scaf = new GlobalKey<ScaffoldState>();

  Future<String> getName() async{

    final prefs = await SharedPreferences.getInstance();
    print('UserName : ${prefs.getString('User Name')}');
    return prefs.getString('User Name');
  }

  @override
  Widget build(BuildContext context) {

    Future<String> userName = getName();

    friends = DBProvider.db.getAll();

//    _scaf.currentState.removeCurrentSnackBar();

    return Scaffold(
      key: _scaf,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()async{
          bool success = await Navigator.push(context, new MaterialPageRoute(builder: (context) => AddFriend()));
          print('in home :$success');

          // working on same object similar to _scaf.currenState.removeCurrentSnackBar();
          // _scaf.currenState.showSnackBar();

          _scaf.currentState
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('Added succesfully!', style:TextStyle(color: Theme.of(context).primaryColor),),));

        },
        backgroundColor: cherryTomato,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      drawer: _drawer(context),
      body: Container(
        color: Colors.black,
        child: FutureBuilder(
          future: Future.wait([
            userName,
            friends
          ]),
          builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
            if(snapshot.hasData) {
              print('Has Data');

              return CustomScrollView(

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
                                  'Welcome, ${snapshot.data[0]}',
                                  overflow: TextOverflow.fade,
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: 30,
                                    color: Colors.white,
                                  )
                              ),
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                            ),
                          )
                        ],
                      ),
                      preferredSize: Size.fromHeight(50),
                    ),

                  ),
                  snapshot.data[1].length ==0 ?
                  SliverFillRemaining(
                    child: Center(
                      child: Text("Press '+' to add friends",
                        style: TextStyle(color: Colors.grey[700],
                          fontSize: 20,


                        ),
                      ),

                    ),
                  ) :
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
                                Navigator.push(context,
                                    new MaterialPageRoute(builder: (context) => friend_info(id: snapshot.data[1][index]["id"])));
                              },
                              child: Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  snapshot.data[1][index]["image"] == 'null'?
                                  Image(
                                    image: AssetImage('assets/photos/beach_2_low.jpg'),
                                    fit: BoxFit.cover,
                                  ):
                                  Image.memory(Base64Decoder().convert(snapshot.data[1][index]["image"]),fit: BoxFit.cover,),
                                  SafeArea(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            color: Colors.grey.withOpacity(0.4),
                                            child: Text(
                                              snapshot.data[1][index]["first_name"],
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
                      childCount: snapshot.data[1].length,
                    ),
                  ),
                ],
              );
            }else{
              print('In else');
              return Center(child: Text('Wait'));
            }
              },
        ),
      ),
    );
  }
}
