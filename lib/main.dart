import 'package:Raylex/logic/models/modelMiniplayer.dart';
import 'package:Raylex/logic/models/notifyLyrics.dart';
import 'package:Raylex/logic/models/playerStateNotify.dart';
import 'package:Raylex/logic/models/playlistPosition.dart';
import 'package:Raylex/ux/pages/navPages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarColor: Colors.lightBlue.shade600.withAlpha(210),
  ));
  runApp(Launch());
}

class Launch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider<PlayerStateNotify>(create: (_)=>PlayerStateNotify()),
        ChangeNotifierProvider<PlaylistPosition>(create: (_)=>PlaylistPosition()),
        ChangeNotifierProvider<ModelMiniPlayer>(create: (_)=>ModelMiniPlayer()),
        ChangeNotifierProvider<NotifyLyrics>(create: (_)=>NotifyLyrics(),)
      ],
      child: MaterialApp(
          routes: {
            "/": (context)=>NavPages(),
          },
          initialRoute: "/",
        
      ),
    );
  }
}