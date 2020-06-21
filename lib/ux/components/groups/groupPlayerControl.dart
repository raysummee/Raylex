import 'dart:async';

import 'package:Raylex/logic/playerLogic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class GroupPlayerControl extends StatefulWidget {
  final String uri;
  final Duration totalDuration;
  GroupPlayerControl(this.uri, this.totalDuration);
  @override
  _GroupPlayerControlState createState() => _GroupPlayerControlState();
}

class _GroupPlayerControlState extends State<GroupPlayerControl> with TickerProviderStateMixin{
  Duration _playerSeekValue = Duration();
  Duration _audioDuration = Duration();
  AnimationController _animationController;
  bool isPlaying = false;
  PlayerLogic playerLogic;
  StreamSubscription _subscriptionAudioPositionChanged;
  StreamSubscription _subscriptionPlayerStateChanged;
  StreamSubscription _subscriptionAudioDurationChanged;
  
  
  @override
  void initState(){
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    
    
    playerLogic = PlayerLogic();
    playerLogic.getInitDuration();
    
    print("initial $_audioDuration");
    _subscriptionAudioPositionChanged = playerLogic.onAudioPositionChanged.listen((pos) {
      setState(() {
        _playerSeekValue = pos;
      });
    });
    _subscriptionAudioDurationChanged = playerLogic.onDurationChanged.listen((duration) {
      setState(() {
        print(duration.inMilliseconds.toString());
        if(duration != Duration.zero)
        _audioDuration = duration;
      });
    });
    _subscriptionPlayerStateChanged = playerLogic.onPlayerStateChanged.listen((state) {
      print("onStateChanged");
      if(state == PlayerState.PLAYING){
        setState(() {
          isPlaying = true;
        });
        _animationController.forward();
      }
      if(state == PlayerState.PAUSED){
        setState(() {
          isPlaying = false;
        });
        _animationController.reverse();
      }
    });
    playerLogic.onInstanceIsPlaying().then((isP) {
      setState(() {
        isPlaying = isP;
        if(isP){
          _animationController.forward();
        }
      });
    });
    if(!isPlaying){
      playerLogic.playMusic(widget.uri);
    }
  }

  @override
  void dispose(){
    super.dispose();
    _animationController.dispose();
    _subscriptionPlayerStateChanged.cancel();
    _subscriptionAudioPositionChanged.cancel();
    _subscriptionAudioDurationChanged.cancel();
  }
  onPlayerSeekChange(double pos){
    setState(() {
      _playerSeekValue = Duration(milliseconds: (pos).toInt());
    });
    playerLogic.seekToMusic(pos);
  }
 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: SliderTheme(
            data: SliderThemeData(
              activeTickMarkColor: Colors.blue.shade900,
              activeTrackColor: Colors.blue.shade900,
              inactiveTrackColor: Colors.grey.shade400,
              trackHeight: 6,
              thumbColor: Colors.blue.shade900,
            ),
            child: _audioDuration!=Duration.zero?Slider(
              value: _playerSeekValue.inMilliseconds.toDouble(),
              min: 0,
              max: _audioDuration.inMilliseconds.toDouble(),
              onChanged: (double pos)=> {onPlayerSeekChange(pos)},
            ):Slider(
              value: 0,
              onChanged: (pos){},
            ),
          )
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                iconSize: 45,
                alignment: Alignment.center,
                icon: Icon(
                  FlutterIcons.rewind_fea,
                  color: Colors.grey.shade600,
                ),
                onPressed: (){},
              ),
              IconButton(
                iconSize: 70,
                alignment: Alignment.center,
                icon: AnimatedIcon(
                  icon: AnimatedIcons.play_pause,
                  progress: _animationController,
                  color: Colors.blue.shade900,
                ),
                onPressed: (){
                  if(isPlaying){
                    playerLogic.pauseMusic();
                  }
                  else{
                    playerLogic.playMusic(widget.uri);
                  }
                },
              ),
              IconButton(  
                iconSize: 45,
                alignment: Alignment.center,
                icon: Icon(
                  FlutterIcons.fast_forward_fea,
                  color: Colors.grey.shade600,
                ),
                onPressed: (){},
              )
            ],
          )
        )
      ],
    );
  }
}