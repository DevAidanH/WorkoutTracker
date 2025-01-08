import 'package:flutter/material.dart';
import 'package:workout_tracker/data/hive_database.dart';
import 'package:workout_tracker/datetime/datetime.dart';
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

    loadHeatMap();
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

  //Delete workout
  void deleteWorkout (String name){
    //Working delete function but not very effiective
    for (int i=0; i<workoutList.length; i++){
      if(workoutList[i].name.contains(name)){
        workoutList.removeAt(i);
      }
    }
    
    notifyListeners();
    loadHeatMap();
    db.saveToDatabase(workoutList);
  }

  void editworkout (String name){
    //Working in progress

    notifyListeners();
    loadHeatMap();
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

  //Delete exercise
  void deleteExercise(String workoutName, String exerciseName){
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);

    Workout relevantWorkout = getRelevantWorkout(workoutName);

    if(relevantWorkout.exercises.contains(relevantExercise)){
      relevantWorkout.exercises.remove(relevantExercise);
    }

    notifyListeners();
    loadHeatMap();
    db.saveToDatabase(workoutList);
  }

  //Check off exercise
  void checkOffExercise(String workoutName, String exerciseName){
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);

    relevantExercise.isCompleted = !relevantExercise.isCompleted;

    notifyListeners();

    //save to database
    db.saveToDatabase(workoutList);
    loadHeatMap();
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

  //Get start date
  String getStartDate(){
    return db.getStartDate();
  }

  //Heatmap dataset
  Map<DateTime, int> heatMapDataSet = {};

  //Load heatmap
  void loadHeatMap(){
    DateTime startDate = createDateTimeObject(getStartDate());

    int daysInBetween = DateTime.now().difference(startDate).inDays;

    //Get completed status
    for (int i = 0; i<daysInBetween+1; i++){
      String yyyymmdd = convertDateTimeToYYYYMMDD(startDate.add(Duration(days:i)));

      int completionStatus = db.getCompletionStatus(yyyymmdd);

      int year = startDate.add(Duration(days: i)).year;
      int month = startDate.add(Duration(days: i)).month;
      int day = startDate.add(Duration(days: i)).day;

      final percentForDay = <DateTime, int>{
        DateTime(year, month, day) : completionStatus
      };

      heatMapDataSet.addEntries(percentForDay.entries);
    }
  }

}