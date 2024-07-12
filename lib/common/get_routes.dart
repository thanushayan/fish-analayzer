import 'package:fish_analyser/screens/behaviour.screen.dart';
import 'package:fish_analyser/screens/filter.screen.dart';
import 'package:fish_analyser/screens/food.screen.dart';
import 'package:fish_analyser/screens/splash.dart';
import 'package:fish_analyser/screens/welcome.screen.dart';
import 'package:flutter/material.dart';

class Navigate {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/splash': (context) => SplashScreen(),
    '/welcome': (context) => WelcomeScreen(),
    '/filter': (context) => FilterScreen(),
    '/food': (context) => FoodScreen(),
    '/behaviour': (context) => BehaviourScreen(),
  };
}
