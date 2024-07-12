// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';

import '../common/widgets.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key}) : super(key: key);
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        key: _scaffoldKey,
        body: Stack(
          fit: StackFit.expand,
          children: [
            buildBackgroundImage('assets/backgroundMain.png'),
            ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/filter');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey,
                              width: 5.0,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          image: DecorationImage(
                            image: AssetImage("assets/filter.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        width: (width - 16),
                        height: (height - 70) / 3,
                        child: Padding(
                          padding: EdgeInsets.only(top: (height - 70) / 4),
                          child: Text(
                            "Filter Detection",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                                fontFamily: 'Open Sans',
                                fontSize: 25),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/behaviour');
                      },
                      child: Container(
                        width: (width - 16),
                        height: (height - 70) / 3,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey,
                              width: 5.0,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          image: DecorationImage(
                            image: AssetImage("assets/behaviour.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: (height - 70) / 4),
                          child: Text(
                            "Behaviour",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                                fontFamily: 'Open Sans',
                                fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/food');
                      },
                      child: Container(
                        width: (width - 16),
                        height: (height - 70) / 3,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey,
                              width: 5.0,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          image: DecorationImage(
                            image: AssetImage("assets/food.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: (height - 70) / 4),
                          child: Text(
                            "FoodConsumption",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                                fontFamily: 'Open Sans',
                                fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            )
          ],
        ));
  }
}
