import 'package:Raylex/ux/pages/navPages.dart';
import 'package:Raylex/ux/pages/playerUIPage.dart';
import 'package:flutter/material.dart';

void main()=>runApp(Launch());

class Launch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: NavPages(),
    );
  }
}