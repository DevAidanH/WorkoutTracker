import 'package:flutter/material.dart';
import 'package:workout_tracker/data/hive_database.dart';
import 'package:workout_tracker/models/exercise.dart';

import '../models/workout.dart';

class WorkoutData extends ChangeNotifier {

  final db = HiveDatabase();

  //Default workout list
  List<Workout> workoutList = [
    Workout(
      name: "Upper Body", 
      exercises: [
        Exercise(
          name: "Bench Press", 
          weight: "85", 
          reps: "5", 
          sets: "3"
        ),
      ],
    ),
    Workout(
      name: "Lower Body", 
      exercises: [
        Exercise(
          name: "Squat", 
          weight: "95", 
          reps: "5", 
          sets: "3"
        ),
      ],
    )
  ];

  //If there is a HIVE box get data otherwise use default list
  void initalizeWorkoutList(){
    if(db.previousDataExists()){
      workoutList = db.readFromDatabase();
    }
    else{
      db.saveToDatabase(workoutList);
    }
  }

  //Get Workouts
  List<Workout> getWorkoutList(){
    return workoutList;
  }

  //Get length of workout
  int numberOfExerciseInWorkout(String workoutName){
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    return relevantWorkout.exercises.length;
  }

  // Add workout
  void addWorkout (String name){
    workoutList.add(Workout(name: name, exercises: []));

    notifyListeners();

    //Save to db
    db.saveToDatabase(workoutList);
  }

  // Add exercise to workout
  void addExercise(String workoutName, String exerciseName, String weight, String reps, String sets){
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    relevantWorkout.exercises.add(Exercise(name: exerciseName, weight: weight, reps: reps, sets: sets));

    notifyListeners();

    //save to database
    db.saveToDatabase(workoutList);
  }

  //Check off exercise
  void checkOffExercise(String workoutName, String exerciseName){
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);

    relevantExercise.isCompleted = !relevantExercise.isCompleted;

    notifyListeners();

    //save to database
    db.saveToDatabase(workoutList);
  }

  //Returns relevant workout 
  Workout getRelevantWorkout(String workoutName){
    Workout relevantWorkout = workoutList.firstWhere((workout) => workout.name == workoutName);

    return relevantWorkout;
  }

  //Returns relevant exercise
  Exercise getRelevantExercise(String workoutName, String exerciseName){
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    Exercise relevantExercise = relevantWorkout.exercises.firstWhere((exercise) => exercise.name == exerciseName);

    return relevantExercise;
  }
}