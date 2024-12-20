import 'package:workout_tracker/datetime/datetime.dart';
import 'package:workout_tracker/models/exercise.dart';
import 'package:workout_tracker/models/workout.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabase {
  //Ref hive box
  final _myBox = Hive.box("workout_database");

  //Check if data stored
  bool previousDataExists(){
    if(_myBox.isEmpty){
      print("Previous data does NOT exist");
      _myBox.put("START_DATE", todaysDateYYYYMMDD());
      return false;
    }
    else{
      print("Previous data does exist");
      return true;
    }
  }

  //Return start date
  String getStartDate(){
    return _myBox.get("START_DATE");
  }
  //Write data
  void saveToDatabase(List<Workout> workouts){
    //Convert objects into strings to store
    final workoutList = convertObjectToWorkoutLi(workouts);
    final exerciseList = convertObjectToExerciseList(workouts);

    //Check if any exercises are set to completed
    //Will put 0 or 1 for each date a workout is completed 
    if (exerciseCompleted(workouts)){
      _myBox.put("COMPLETION_STATUS_${todaysDateYYYYMMDD()}", 1);
    }
    else{
      _myBox.put("COMPLETION_STATUS_${todaysDateYYYYMMDD()}", 0);
    }

    //Save into hive
    _myBox.put("WORKOUTS", workoutList);
    _myBox.put("EXERCISES", exerciseList);
  }

  //Read data

  //Check exercises done
  bool exerciseCompleted(List<Workout> workouts){
    for (var workout in workouts){
      for (var exercise in workout.exercises){
        if (exercise.isCompleted){
          return true;
        }
      }
    }
    return false;
  }

  //Return completed status of given date

  //Convert workouts objects into lists
  List<String> convertObjectToWorkoutLi(List<Workout> workouts) {
    List<String> workoutList = [];

    for(int i = 0; 1 < workouts.length; i++){
      workoutList.add(workouts[i].name);
    }

    return workoutList;
  }
  //Convert exercies objects into lists 
List<List<List<String>>> convertObjectToExerciseList(List<Workout> workouts){
      List<List<List<String>>> exerciseList = [];

      for(int i = 0; i < workouts.length; i++){
        List<Exercise> exercisesInWorkout = workouts[i].exercises;

        List<List<String>> individualWorkout = [];

        for(int j = 0; j < exercisesInWorkout.length; j++){
          List<String> individualExercise =[];
          individualExercise.addAll([
              exercisesInWorkout[j].name,
              exercisesInWorkout[j].weight,
              exercisesInWorkout[j].reps,
              exercisesInWorkout[j].sets,
              exercisesInWorkout[j].isCompleted.toString()
          ]);
          individualWorkout.add(individualExercise);
        }
        exerciseList.add(individualWorkout);
      }
      return exerciseList;
    }
}