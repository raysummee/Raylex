import 'package:Raylex/logic/models/songInfo.dart';
import 'package:Raylex/ux/pages/playerUIPage.dart';
import 'package:flutter/material.dart';

class VerticalListSimple extends StatefulWidget {
  final List<SongInfo> songinfo;
  VerticalListSimple(this.songinfo);

  @override
  _VerticalListSimpleState createState() => _VerticalListSimpleState();
}

class _VerticalListSimpleState extends State<VerticalListSimple> {
  int currentPlaying;
  @override 
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.songinfo.length,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        itemBuilder: (context, index){
          return ListTile(
            
            title: Text(
              widget.songinfo.elementAt(index).title,
              style: ((){
                if(currentPlaying!=null && currentPlaying == index){
                  return TextStyle(
                    color: Colors.pink.shade300,
                    fontWeight: FontWeight.bold
                  );
                }else{
                  return TextStyle();
                }
              }()),
            ),
            trailing: ((){
              if(currentPlaying!=null && currentPlaying == index)
                return Icon(
                      Icons.bubble_chart,
                      color: Colors.pink.shade300,
                    
                );
              else
                return Text("");
            }()),
            onTap: (){
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => PlayerUIPage(widget.songinfo.elementAt(index)))
              );
              setState(() {
                currentPlaying = index;
              });
            }
          );
        },
      ),
    );
  }
}