import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.lightBlue
            ),
            child: SafeArea(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 0, 50, 0),
                        border: InputBorder.none,
                        filled: true,
                        hintText: "Search...",
                        fillColor: Colors.grey.shade200
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(18),
                        child: IconButton(
                          icon: Icon(
                            Icons.search
                          ), 
                          onPressed: (){}
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text("No Data yet!"),
            )
          )
        ],
      )
    );
  }
}