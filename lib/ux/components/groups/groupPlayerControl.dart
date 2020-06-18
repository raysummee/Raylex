import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raylex/logic/playerLogic.dart';

class GroupPlayerControl extends StatefulWidget {
  @override
  _GroupPlayerControlState createState() => _GroupPlayerControlState();
}

class _GroupPlayerControlState extends State<GroupPlayerControl> with TickerProviderStateMixin{
  Duration _playerSeekValue = Duration(seconds: 0);
  AnimationController _animationController;
  bool isPlaying = false;
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
  }

  @override
  void dispose(){
    super.dispose();
    _animationController.dispose();
    playerLogic.pauseMusic();
  }
  onPlayerSeekChange(double pos){
    setState(() {
      _playerSeekValue = Duration(seconds: pos.toInt());
    });
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
              max: 10,
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
                    setState(() {
                      isPlaying = false;
                      playerLogic.pauseMusic();
                    });
                  }
                  else{
                    _animationController.forward();
                    setState(() {
                      isPlaying = true;
                      playerLogic.playMusic("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3");
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