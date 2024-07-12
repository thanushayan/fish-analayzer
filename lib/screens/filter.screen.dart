// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fish_analyser/common/const.dart';
import 'package:fish_analyser/models/filter.model.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../common/widgets.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKeyDemand =
      GlobalKey<ScaffoldState>();
  var dio = Dio();

  File? _image;
  final picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();

  Image? _imageWidget;

  String? filterType;

  bool dataLoaded = false;

  @override
  void initState() {
    super.initState();
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
      _imageWidget = Image.file(_image!);
    });
  }

  Future getImageCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile!.path);
      _imageWidget = Image.file(_image!);
    });
  }

  Future<void> _getFilterType(File file) async {
    String filePath = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "filePath": await MultipartFile.fromFile(file.path, filename: filePath),
    });
    Response response = await dio.post(BASE_URL + 'filter/', data: formData);

    filterType = FilterModel.fromJson(response.data).response;
    if (filterType != null) {
      setState(() {
        dataLoaded = true;
      });
    }
    print("filter res*********************");
    print(filterType);
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
          title: Text("Filter Detection"),
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
                      _image == null
                          ? Text(
                              'No image selected.',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            )
                          : Container(
                              padding: EdgeInsets.only(top: 10),
                              constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height / 2),
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              child: _imageWidget,
                            ),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .lightGreen, // Set the background color here
                            ),
                            onPressed: () => getImageCamera(),
                            child:
                                Text('Click Here To Select Image From Camera'),
                          )),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .lightGreen, // Set the background color here
                            ),
                            onPressed: () => getImage(),
                            child:
                                Text('Click Here To Select Image From Gallery'),
                          )),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .lightGreen, // Set the background color here
                            ),
                            onPressed: () => _getFilterType(_image!),
                            child: Text('CheckImage'),
                          )),
                    ]),
                SizedBox(height: 10),
                dataLoaded
                    ? Center(
                        child: Text(
                        "Detected ->" + filterType! + " Filter",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ))
                    : Container()
              ],
            ),
          ],
        ));
  }
}
