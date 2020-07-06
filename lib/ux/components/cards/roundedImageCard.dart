import 'package:Raylex/ux/pages/allSongsPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RoundedImageCard extends StatelessWidget {
  final String imageUri;
  final String title;
  final AsyncValueGetter future;
  RoundedImageCard(this.imageUri, this.title, this.future);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(2, 10,2, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image(
              image: AssetImage(
                imageUri
              )
            ),
          ),
          Material(
            borderRadius: BorderRadius.circular(4),
            color: Colors.transparent,
            child: InkWell(
              hoverColor: Colors.lightBlue.withOpacity(0.4),
              splashColor: Colors.black.withOpacity(0.2),
              highlightColor: Colors.lightBlue.withAlpha(100),
              borderRadius: BorderRadius.circular(4),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context)=>AllSongsPage(
                      future: future,
                      uri: imageUri,
                      title: title,
                    )
                  )
                );
              },
            )
          )
        ],
      ),
      height: 160,
      width: 160,
    );
  }
}