// ignore_for_file: prefer_const_constructors

import 'dart:ffi';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:dio/dio.dart';
import 'package:fish_analyser/common/const.dart';
import 'package:fish_analyser/models/foodPredict.model.dart';
import 'package:fish_analyser/models/predictResponse.model.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../common/widgets.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({Key? key}) : super(key: key);

  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  int speciesId = 5;
  int stageId = 0;
  int fishCount = 0;

  final GlobalKey<ScaffoldState> _scaffoldKeyDemand =
      GlobalKey<ScaffoldState>();
  var dio = Dio();

  final TextEditingController _textEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  double? foodAmount;

  bool dataLoaded = false;

  @override
  void initState() {
    super.initState();
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
          title: Text("Food Amount"),
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
                SizedBox(height: 20),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    border: Border.all(color: Colors.black38, width: 3),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.57),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: DropdownButton<int>(
                      value: speciesId,
                      hint: Text('Select a species'),
                      items: SPECIES.map((Species species) {
                        return DropdownMenuItem<int>(
                          child: Text(species.name),
                          value: species.id,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          speciesId = value!;
                        });
                        print("You have selected species ID $value");
                      },
                      icon: const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(Icons.arrow_circle_down_sharp),
                      ),
                      iconEnabledColor: Colors.white,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      dropdownColor: Colors.greenAccent,
                      underline: Container(),
                      isExpanded: true,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    border: Border.all(color: Colors.black38, width: 3),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.57),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: DropdownButton<int>(
                      value: stageId,
                      items: STAGES.map((Stage stage) {
                        return DropdownMenuItem<int>(
                          child: Text(stage.name),
                          value: stage.id,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          stageId = value!;
                        });
                        print("You have selected stage ID $value");
                      },
                      icon: const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(Icons.arrow_circle_down_sharp),
                      ),
                      iconEnabledColor: Colors.white,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      dropdownColor: Colors.greenAccent,
                      underline: Container(),
                      isExpanded: true,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    border: Border.all(color: Colors.black38, width: 3),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.57),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        labelText: 'Enter fish count',
                        hintText: 'Fish count',
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        setState(() {
                          fishCount = int.parse(value);
                        });
                      },
                      onSubmitted: (value) {
                        setState(() {
                          fishCount = int.parse(value);
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    getPrediction().then((value) => {});
                  },
                  child: Text('Check Amount'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(color: Colors.black38, width: 3),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    shadowColor: Color.fromRGBO(0, 0, 0, 0.57),
                    elevation: 5,
                    minimumSize: ui.Size.fromHeight(50),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: foodAmount != null
                      ? Text(
                          "Predicted Food amount : $foodAmount",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      : Container(),
                ),
              ],
            ),
          ],
        ));
  }

  Future<void> getPrediction() async {
    FoodPredict request = FoodPredict(
        species: speciesId, fishCount: stageId, fishStage: fishCount);

    Response response =
        await dio.post(BASE_URL + 'food/', data: request.toJson());

    setState(() {
      print("**********api response");
      foodAmount = ResponseApi.fromJson(response.data).response;
      print(foodAmount);
    });
  }
}
