import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui';
import 'package:image_cropper/image_cropper.dart';

class addFriend extends StatefulWidget {
  @override
  _addFriendState createState() => _addFriendState();
}

class _addFriendState extends State<addFriend> {

  File _friendImage;

  Future getImage(ImageSource source) async{
    var image = await ImagePicker.pickImage(source: source);

    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        cropStyle: CropStyle.rectangle,
        aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
        ],
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
    return Scaffold(
       
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          getImage(ImageSource.gallery);
        },
        child: Icon(Icons.add_a_photo),
      ),
      body: Center(
        child: _friendImage == null ?
        Text('No Image selected')
            : Container(
          color: Colors.black,
          child: Image.file(_friendImage,filterQuality: FilterQuality.high,),
        )
      ),
    );
  }
}
