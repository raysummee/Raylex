import 'dart:async';
import 'package:Raylex/logic/models/playerStateNotify.dart';
import 'package:Raylex/logic/models/playlistPosition.dart';
import 'package:Raylex/logic/models/songInfo.dart';
import 'package:Raylex/logic/playerLogic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class GroupPlayerControl extends StatefulWidget {
  final PlayerLogic _playerLogic;

  GroupPlayerControl(this._playerLogic);
  @override
  _GroupPlayerControlState createState() => _GroupPlayerControlState();
}

class _GroupPlayerControlState extends State<GroupPlayerControl> with TickerProviderStateMixin{
  Duration _playerSeekValue = Duration();
  Duration _audioDuration = Duration();
  AnimationController _animationController;
  bool isPlaying = false;
  StreamSubscription _subscriptionAudioPositionChanged;
  StreamSubscription _subscriptionPlayerStateChanged;
  StreamSubscription _subscriptionAudioDurationChanged;
  //PlaylistPosition appstatepos;
  //PlayerStateNotify appstatelist;
  
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    print("player didchangeddependencies");
    print("initial $_audioDuration");    
    final appstatepos = Provider.of<PlaylistPosition>(context, listen: false);
    final appstatelist = Provider.of<PlayerStateNotify>(context, listen: false);

    _subscriptionAudioPositionChanged = widget._playerLogic.onAudioPositionChanged.listen((pos) {
      if(mounted)
      setState(() {
        _playerSeekValue = pos;
      });
    });
    _subscriptionAudioDurationChanged = widget._playerLogic.onDurationChanged.listen((duration) {
      print(duration.inMilliseconds.toString());
      if(mounted)
      setState(() {
        if(duration != Duration.zero)
        _audioDuration = duration;
      });
    });
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
          print("song stopped at ${_playerSeekValue.inSeconds} of ${_audioDuration.inSeconds}");
          if(_playerSeekValue.inSeconds == _audioDuration.inSeconds){
            print("song ended");
            widget._playerLogic.nextSong(appstatelist.songinfos, appstatepos.index);
            ++appstatepos.index;
          }
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
    print("player init");
    widget._playerLogic.setMethodCallHandler();
    widget._playerLogic.getInitDuration();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    
    //widget._playerLogic.setPlaylistPostion(index);
  }

  @override
  void dispose(){
    super.dispose();
    print("player dispose");
    _animationController.dispose();
    _subscriptionPlayerStateChanged.cancel();
    _subscriptionAudioPositionChanged.cancel();
    _subscriptionAudioDurationChanged.cancel();
  }
  onPlayerSeekChange(double pos){
    setState(() {
      _playerSeekValue = Duration(milliseconds: (pos).toInt());
    });
    widget._playerLogic.seekToMusic(pos);
  }
 
  @override
  Widget build(BuildContext context) {
    var appstatelist = Provider.of<PlayerStateNotify>(context);
    var appstatepos = Provider.of<PlaylistPosition>(context);
    return Column(
      children: <Widget>[
        Container(
          height: 25,
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
              max: _audioDuration.inMilliseconds.toDouble()+1000,
              onChanged: (double pos)=> {onPlayerSeekChange(pos)},
            ):Slider(
              value: 0,
              onChanged: (pos){},
            ),
          )
        ),
        Container(
          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                ((){
                  if(_audioDuration != Duration.zero){
                    if(_playerSeekValue.inSeconds%60<10){
                      return "${_playerSeekValue.inMinutes.toString()}:0${_playerSeekValue.inSeconds%60}";
                    }else{
                      return "${_playerSeekValue.inMinutes.toString()}:${_playerSeekValue.inSeconds%60}";
                    }
                  }else{
                    return "0:00";
                  }
                }()),
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.bold
                ),    
              ),
              Text(
                ((){
                  if(_audioDuration.inSeconds%60<10){
                    return "${_audioDuration.inMinutes.toString()}:0${_audioDuration.inSeconds%60}";
                  }else{
                    return "${_audioDuration.inMinutes.toString()}:${_audioDuration.inSeconds%60}";
                  }
                }()) ,
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.bold
                ),     
              )
            ],
          ),
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
                onPressed: (){
                  widget._playerLogic.prevSong(appstatelist.songinfos, appstatepos.index);
                  --appstatepos.index;
                },
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
                    widget._playerLogic.pauseMusic();
                  }
                  else{
                    widget._playerLogic.playMusic(appstatelist.songinfos.elementAt(appstatepos.index).uri);
                    //appstate.index = index;
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
                onPressed: (){
                  widget._playerLogic.nextSong(appstatelist.songinfos, appstatepos.index);
                  ++appstatepos.index;
                }
              )
            ],
          )
        )
      ],
    );
  }
}