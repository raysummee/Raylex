import 'package:raylex/ux/pages/navPages.dart';
import 'package:raylex/ux/pages/playerUIPage.dart';
import 'package:flutter/material.dart';

void main()=>runApp(Launch());

class Launch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "playerUI": (context)=> PlayerUIPage(),
      },
      home: NavPages(),
    );
  }
}