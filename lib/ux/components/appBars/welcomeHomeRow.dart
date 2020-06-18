import 'package:flutter/material.dart';

class WelcomeHomeRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 200,
      bottom: PreferredSize(
        child: Text(""), 
        preferredSize: Size.fromHeight(50)
      ),
      backgroundColor: Colors.lightBlue,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          "Library",
        ),
      ),
    );
  }
}