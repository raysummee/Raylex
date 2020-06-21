import 'package:Raylex/logic/models/playerState.dart';
import 'package:Raylex/ux/pages/navPages.dart';
import 'package:Raylex/ux/pages/playerUIPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()=>runApp(Launch());

class Launch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PlayerState>(create: (context)=>PlayerState())
      ],
      child: MaterialApp(
        
        home: NavPages(),
      ),
    );
  }
}