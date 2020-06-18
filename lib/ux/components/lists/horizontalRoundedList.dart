import 'package:raylex/ux/components/cards/circularImageCard.dart';
import 'package:flutter/material.dart';

class HorizontalRoundedList extends StatelessWidget {
  final String headerName;
  final List<String> contentList;
  HorizontalRoundedList({
    @required this.headerName,
    @required this.contentList,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(10, 10, 10, 2),
          child: Text(
            headerName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black38
            ),
          ),
        ),
        Container(
          height: 110,
          margin: EdgeInsets.fromLTRB(0, 2, 0, 10),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: contentList.length,
            itemBuilder: (context, index){
              return CircularImageCard(contentList.elementAt(index));
            },
          ),
        ),
      ],
    );
  }
}