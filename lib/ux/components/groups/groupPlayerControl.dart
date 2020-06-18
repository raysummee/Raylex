import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GroupPlayerControl extends StatefulWidget {
  @override
  _GroupPlayerControlState createState() => _GroupPlayerControlState();
}

class _GroupPlayerControlState extends State<GroupPlayerControl> with TickerProviderStateMixin{
  double _playerSeekValue = 0;
  AnimationController _animationController;
  bool isPlaying = false;
  static const platform = const MethodChannel("com.raysummee.raylex/audio");
  
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
  }
  onPlayerSeekChange(double pos){
    setState(() {
      _playerSeekValue = pos;
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
              max: 100,
              min: 0,   
              value: _playerSeekValue, 
              onChanged: (double pos)=> onPlayerSeekChange(pos),
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
                      platform.invokeMethod("pauseMusic");
                    });
                  }
                  else{
                    _animationController.forward();
                    setState(() {
                      isPlaying = true;
                      platform.invokeMethod("playMusic",<String, String>{
                        'url': "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
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