import 'dart:async';
import 'package:Raylex/logic/playerLogic.dart';
import 'package:flutter/material.dart';

class LibraryAppBar extends StatefulWidget {
  @override
  _LibraryAppBarState createState() => _LibraryAppBarState();
}

class _LibraryAppBarState extends State<LibraryAppBar> with TickerProviderStateMixin {
  AnimationController __animationController;
  StreamSubscription __subscriptionPlayerStateChanged;
  PlayerLogic _playerLogic;
  bool isPlaying=false;
  bool isActive=true;
  
  @override 
  void didChangeDependencies(){
    super.didChangeDependencies();
    print("didchangeddependencies library");
    if(__subscriptionPlayerStateChanged!=null){
      print("canceled onstatechangedSecondary");
      __subscriptionPlayerStateChanged.cancel();
      __subscriptionPlayerStateChanged = null;
    }else{
      isActive = true;
      _playerLogic.setMethodCallHandler();
      print("creating onstateSecondary");
    __subscriptionPlayerStateChanged = _playerLogic.onPlayerSecondaryStateChanged.handleError((e)=>print("streamerror $e")).listen((state) {
      print("onStateChangedSecondary");
      
      if(state == true){
        setState(() {
          isPlaying = true;
        });
        __animationController.forward();
      }
      if(state == false){
        setState(() {
          isPlaying = false;
        });
        __animationController.reverse();
      }
      
    });
    }
    _playerLogic.onInstanceIsPlaying().then((isP) {
      setState(() {
        isPlaying = isP;
      });
      if(isP){
        __animationController.forward(from: __animationController.upperBound);
      }else{
        __animationController.reverse(from: __animationController.lowerBound);
      }
    });

  }
  
  @override
  void initState(){
    super.initState();
    print("library init");
     _playerLogic = PlayerLogic();
     __animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  
  @override
  void dispose(){
    super.dispose();
    print("library dispose");
    __animationController.dispose();
    __subscriptionPlayerStateChanged.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: SafeArea(
        bottom: false,
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
          alignment: Alignment.bottomLeft,
          height: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: Text(
                  "Library",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.bold
                  )
                ),
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.fast_rewind,
                      color: Colors.white,
                    ),
                    onPressed: (){}
                  ),
                  IconButton(
                    iconSize: 35,
                    icon: AnimatedIcon(
                      icon: AnimatedIcons.play_pause,
                      progress: __animationController,
                      color: Colors.white,
                    ),
                    onPressed: (){
                      if(isPlaying){
                        setState(() {
                          isPlaying = false;
                        });
                        _playerLogic.pauseMusic();
                        //__animationController.reverse();
                      }
                      else{
                        setState(() {
                          isPlaying = true;
                        });
                        _playerLogic.playPausedMusic();
                        //__animationController.forward();
                      }
                    }
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.fast_forward,color: Colors.white,
                    ),
                    onPressed: (){}
                  ),
                ],
              )
            ],
          )
        )
      ),
    );
  }
}