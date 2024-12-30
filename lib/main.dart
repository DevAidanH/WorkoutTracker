import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
//import 'package:workout_tracker/data/hive_database.dart';
import 'package:workout_tracker/data/workout_data.dart';
import 'pages/homepage.dart';

void main() async {
  //Init HIve - local storage
  await Hive.initFlutter();
  
  //Open hive box
  await Hive.openBox("workout_database3");


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => WorkoutData(),
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    ),);
  }
}
