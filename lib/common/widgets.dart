import 'package:flutter/material.dart';

Widget buildBackgroundImage(String image) {
  return Image.asset(
    image,
    fit: BoxFit.cover,
    width: double.infinity,
    height: double.infinity,
  );
}
