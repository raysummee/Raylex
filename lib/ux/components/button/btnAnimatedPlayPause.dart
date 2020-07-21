import 'dart:async';

import 'package:Raylex/logic/playerLogic.dart';
import 'package:flutter/material.dart';

class BtnAnimatedPlayPause extends StatefulWidget {
  final PlayerLogic _playerLogic;

  BtnAnimatedPlayPause(this._playerLogic);
  @override
  _BtnAnimatedPlayPauseState createState() => _BtnAnimatedPlayPauseState();
}

class _BtnAnimatedPlayPauseState extends State<BtnAnimatedPlayPause> with TickerProviderStateMixin{
  AnimationController _animationController;
  StreamSubscription _subscriptionPlayerStateChanged;
  bool isPlaying = false;
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _subscriptionPlayerStateChanged = widget._playerLogic.onPlayerStateChanged.listen((state) {
      print("onStateChanged");
      if(state == PlayerState.PLAYING){
        if(mounted){
          setState(() {
            isPlaying = true;
          });
          _animationController.forward();
        }
      }
      if(state == PlayerState.PAUSED){
        if(mounted){
          setState(() {
            isPlaying = false;
          });
          _animationController.reverse();
        }
      }
      if(state == PlayerState.STOPPED){
        if(mounted){
          setState(() {
            isPlaying = false;
          });   
          _animationController.reverse();
        }
      }
    });
    widget._playerLogic.onInstanceIsPlaying().then((isP) {
      if(mounted){
        setState(() {
          isPlaying = isP;
        });
        if(isP){
          _animationController.forward(from: _animationController.upperBound);
        }
      }
    });
  }
  @override 
  void initState(){
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }
  @override
  void dispose(){
    super.dispose();
    _animationController.dispose();
    _subscriptionPlayerStateChanged.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      child: IconButton(
        iconSize: 70,
        icon: AnimatedIcon(
          icon: AnimatedIcons.play_pause, 
          progress: _animationController,
          color: Colors.blue.shade900,
        ), 
        onPressed: (){
          if(!isPlaying)
            widget._playerLogic.playPausedMusic();
          else
            widget._playerLogic.pauseMusic();
        }
      ),
    );
  }
}