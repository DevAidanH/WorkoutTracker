import 'package:flutter/material.dart';
import 'package:workout_tracker/pages/homepage.dart';

class login extends StatelessWidget {
  const login({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(50), 
          ),
          Padding(padding: EdgeInsets.all(20), child: Text("Welcome to LiftLog")),
          GestureDetector(
            child: Text("Click here to get started"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()));
            },
          ),
        ],
      ),
    );
  }
}