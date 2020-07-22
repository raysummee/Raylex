import 'package:Raylex/ux/components/appBars/libraryAppBar.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          LibraryAppBar(title: "About",),
          Container(
            color: Colors.grey[200],
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Text(
              "RAYLEX a home audio streaming app ",
              style: TextStyle(
                fontSize: 18
              ),
            ),
          ),
          Container(
            color: Colors.grey[200],
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Text(
              "You can install the server app on your desktop or any local server and the app will automatically connect to it. The app also can be used as a local media player",
              style: TextStyle(
                fontSize: 16
              ),
            ),
          ),
          Container(
            color: Colors.grey[200],
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Text(
              "The app is completely free though you have to buy the server software",
              style: TextStyle(
                fontSize: 16
              ),
            ),
          ),
          Container(
            color: Colors.grey[200],
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Text(
              "Developer: Angshuman Barpujari",
              style: TextStyle(
                fontSize: 18
              ),
            ),
          ),
          Container(
            color: Colors.grey[200],
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Text("Email: Angshuarin@gmail.com")
          ),
          Container(
            color: Colors.grey[200],
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Text("Phone: 8638761581")
          ),
          Container(
            color: Colors.grey[200],
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Text("Instagram: angshuman_barpujari")
          ),
          Container(
            alignment: Alignment.centerLeft,
            color: Colors.grey[200],
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: FlatButton(
              color: Colors.grey[300],
              onPressed: (){}, 
              child: Text("Help us donating")
            )
          ),
        ],
      ),
    );
  }
}