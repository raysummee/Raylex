import 'package:flutter/material.dart';
import 'package:raylex/logic/playerLogic.dart';

class GroupPlayerControl extends StatefulWidget {
  @override
  _GroupPlayerControlState createState() => _GroupPlayerControlState();
}

class _GroupPlayerControlState extends State<GroupPlayerControl> with TickerProviderStateMixin{
  Duration _playerSeekValue = Duration(seconds: 0);
  AnimationController _animationController;
  bool isPlaying = false;
  double duration=10;
  PlayerLogic playerLogic;
  
  @override
  void initState(){
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    playerLogic = PlayerLogic();
    playerLogic.onAudioPositionChanged.listen((pos) {
      setState(() {
        _playerSeekValue = pos;
      });
    });
    playerLogic.onPlayerStateChanged.listen((state) {
      print("onStateChanged");
      if(state == PlayerState.PLAYING){
        setState(() {
          isPlaying = true;
        });
        _animationController.forward();
        print("playing");
      }
      else{
        setState(() {
          isPlaying = false;
        });
        print("not playing");
      }
    });
  }

  @override
  void dispose(){
    super.dispose();
    _animationController.dispose();
  }
  onPlayerSeekChange(double pos){
    setState(() {
      _playerSeekValue = Duration(seconds: (pos).toInt());
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
            child: Slider(
              value: _playerSeekValue.inSeconds.toDouble(),
              min: 0,
              max: 100,
              onChanged: (double pos)=> {onPlayerSeekChange(pos)},
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
                  Icons.fast_rewind,
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
                    _animationController.reverse();
                    playerLogic.pauseMusic();
                    setState(() {
                      isPlaying=false;
                    });
                  }
                  else{
                    _animationController.forward();
                    playerLogic.playMusic("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3");
                    setState(() {
                      duration = playerLogic.duration.inSeconds.toDouble();
                      setState(() {
                        isPlaying=true;
                      });
                    });
                  }
                },
              ),
              IconButton(  
                iconSize: 45,
                alignment: Alignment.center,
                icon: Icon(
                  Icons.fast_forward,
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