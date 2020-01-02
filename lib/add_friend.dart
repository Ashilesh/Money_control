import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:image_picker/image_picker.dart';
import 'dart:ui';
import 'package:image_cropper/image_cropper.dart';
import 'add_friend2.dart';
import 'package:path_provider/path_provider.dart';

class AddFriend extends StatefulWidget {
  @override
  _AddFriendState createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {

  File _friendImage;

  Future getImage(ImageSource source) async{
    var image = await ImagePicker.pickImage(source: source);
    
    MediaQueryData query = MediaQuery.of(context);

    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        cropStyle: CropStyle.rectangle,
        aspectRatio: CropAspectRatio(
          ratioX: query.size.width,
          ratioY: query.size.height
        ),
        
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.ratio16x9,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );
    print('in Get Image');
    setState(() {
      _friendImage = croppedFile;
    });
  }

  int i = 1;

  @override
  Widget build(BuildContext context) {

    return  Scaffold(

      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,

      body:Stack(
        children: <Widget>[
          Center(
              child: _friendImage == null ?
              Text('No image selected!', style: prefix0.TextStyle(color: Theme.of(context).primaryColor),)

                  : Container(
                color: Colors.black,
                child: Image.file(_friendImage,filterQuality: FilterQuality.high,fit: BoxFit.fill,),
              )
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: <Widget>[
                    MaterialButton(
                      height: 50,
                      onPressed: () => getImage(ImageSource.gallery),
                      child: Text(
                        'Add Photo',
                        style: prefix0.TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20
                        ),
                      ),
                      color: Theme.of(context).primaryColorDark,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                    ),
                    MaterialButton(
                      height: 50,
                      onPressed: ()async{

                        bool success =  await Navigator.push<bool>(
                            context,
                            new MaterialPageRoute(builder: (context) => AddFriend2(
                                friendImage: _friendImage )
                            )
                        );

                        Navigator.pop(context, success);

                      },
                      child: Text(
                        'Next',
                        style: prefix0.TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20
                        ),
                      ),
                      color: Theme.of(context).primaryColorDark,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                    )
                  ],
                ),
              )
            ],
          )

        ],

      ),
    );
  }
}
