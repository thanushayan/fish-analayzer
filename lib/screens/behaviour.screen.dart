// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fish_analyser/common/const.dart';
import 'package:fish_analyser/models/filter.model.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../common/widgets.dart';

class BehaviourScreen extends StatefulWidget {
  const BehaviourScreen({Key? key}) : super(key: key);

  @override
  _BehaviourScreenState createState() => _BehaviourScreenState();
}

class _BehaviourScreenState extends State<BehaviourScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKeyDemand =
      GlobalKey<ScaffoldState>();
  var dio = Dio();

  File? _image;
  final picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();

  Image? _imageWidget;

  String? beahviour;

  bool dataLoaded = false;

  @override
  void initState() {
    super.initState();
  }

  Future getVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
      _imageWidget = Image.file(_image!);
    });
  }

  Future getVideoCamera() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile!.path);
      _imageWidget = Image.file(_image!);
    });
  }

  Future<void> _getbeahviour(File file) async {
    String filePath = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "filePath": await MultipartFile.fromFile(file.path, filename: filePath),
    });
    Response response = await dio.post(BASE_URL + 'behaviour/', data: formData);

    beahviour = FilterModel.fromJson(response.data).response;
    if (beahviour != null) {
      setState(() {
        dataLoaded = true;
      });
    }
    print("filter res*********************");
    print(beahviour);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKeyDemand,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: Text("Behaviour Detection"),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/welcome');
              },
              icon: Icon(Icons.arrow_back_ios)),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            buildBackgroundImage('assets/background.png'),
            ListView(
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _videoPlayerWidget(),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .lightGreen, // Set the background color here
                            ),
                            onPressed: () => getVideoCamera(),
                            child:
                                Text('Click Here To Select Video From Camera'),
                          )),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .lightGreen, // Set the background color here
                            ),
                            onPressed: () => getVideo(),
                            child:
                                Text('Click Here To Select Video From Gallery'),
                          )),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .lightGreen, // Set the background color here
                            ),
                            onPressed: () => _getbeahviour(_image!),
                            child: Text('CheckVideo'),
                          )),
                    ]),
                SizedBox(height: 10),
                dataLoaded
                    ? Center(
                        child: Text(
                        "Predicted Behaviour is ->" + beahviour!,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ))
                    : Container()
              ],
            ),
          ],
        ));
  }

  Widget _videoPlayerWidget() {
    if (_image == null) {
      return Text(
        'No video selected.',
        style: TextStyle(fontSize: 20, color: Colors.white),
      );
    } else if (dataLoaded) {
      return Text(
        'Video uploaded',
        style: TextStyle(fontSize: 20, color: Colors.white),
      );
    } else {
      return Text(
        'Video uploading',
        style: TextStyle(fontSize: 20, color: Colors.white),
      );
    }
  }
}
