import 'package:Raylex/ux/pages/navPages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarColor: Colors.lightBlue,
    statusBarColor: Colors.blue
  ));
  runApp(Launch());
}

class Launch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        routes: {
          "/": (context)=>NavPages(),
        },
        initialRoute: "/",
      
    );
  }
}