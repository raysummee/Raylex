import 'dart:async';
import 'dart:ui';

import 'package:Raylex/logic/models/playerStateNotify.dart';
import 'package:Raylex/logic/models/playlistPosition.dart';
import 'package:Raylex/logic/models/songInfo.dart';
import 'package:Raylex/logic/playerLogic.dart';
import 'package:Raylex/ux/pages/playerUIPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class MiniPlayer extends StatefulWidget {
  @override
  _MiniPlayerState createState() => _MiniPlayerState();
}



class _MiniPlayerState extends State<MiniPlayer> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  PlayerStateNotify appstate;
  PlaylistPosition appstatepos;
  StreamSubscription _streamSubscriptionState;
  bool isPlaying;
  PlayerLogic _playerLogic;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300)
    );
    _playerLogic = PlayerLogic();
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    if(appstate==null)
    appstate = Provider.of<PlayerStateNotify>(context);
    if(appstatepos==null)
    appstatepos = Provider.of<PlaylistPosition>(context);
    _playerLogic.setMethodCallHandler();
    _streamSubscriptionState = _playerLogic.onPlayerStateChanged.listen((state) {
      print("onStateChanged");
      
      if(state == PlayerState.PLAYING){
        setState(() {
          isPlaying = true;
        });
        _controller.forward();
      }
      if(state == PlayerState.PAUSED){
        setState(() {
          isPlaying = false;
        });
        _controller.reverse();
      }
      if(state == PlayerState.STOPPED){
        setState(() {
          isPlaying = false;
        });   
        _controller.reverse();
      }
    });
    _playerLogic.onInstanceIsPlaying().then((isP) {
      setState(() {
        isPlaying = isP;
      });
      if(isP){
        _controller.forward(from: _controller.upperBound);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _streamSubscriptionState.cancel();
  }


  onPlayClick(){
    if(isPlaying)
      _playerLogic.pauseMusic();
    else
      _playerLogic.playPausedMusic();
  }

  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2,0,2,1),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 10.0,sigmaX: 10.0),
            child: Container(
              height: 60,
              color: Colors.lightBlue.withAlpha(180),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 2,10,2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                     Expanded(
                        flex: 8,
                        child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PlayerUIPage(_playerLogic)));
                      },
                      child: Container(
                          width: 180,
                          margin: EdgeInsets.only(right: 5, left: 5),
                          child: Text(
                            appstate.songinfos!=null&&appstatepos.index!=null?appstate.songinfos.elementAt(appstatepos.index).title:"",
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                            ),
                          ),
                        )
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Material(
                              shadowColor: Colors.red,

                              color: Colors.transparent,
                              child: IconButton(
                                color: Colors.white,
                                icon: AnimatedIcon(
                                  icon: AnimatedIcons.play_pause,
                                  progress: _controller,
                                ),
                                onPressed: ()=>onPlayClick()
                              ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Material(
                            shadowColor: Colors.red,
                                      
                            color: Colors.transparent,
                            child: IconButton(
                              color: Colors.white,
                              icon: Icon(FlutterIcons.fast_forward_mdi),
                              onPressed: (){
                                _playerLogic.nextSong(appstate.songinfos, appstatepos.index);
                                ++appstatepos.index;
                              }
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}