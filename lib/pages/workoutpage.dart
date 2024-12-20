import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker/components/exercise_tile.dart';
import 'package:workout_tracker/data/workout_data.dart';

class Workoutpage extends StatefulWidget {
  final String workoutName;
  const Workoutpage({super.key, required this.workoutName});

  @override
  State<Workoutpage> createState() => _WorkoutpageState();
}

class _WorkoutpageState extends State<Workoutpage> {
  //Checkbox change for completed workout
  void onCheckBoxChange(String workoutName, String exerciseName){
    Provider.of<WorkoutData>(context, listen: false).checkOffExercise(workoutName, exerciseName);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(builder: (context, value, child) => Scaffold(
      appBar: AppBar(
        title: Text(widget.workoutName),
      ),
      body: ListView.builder(
          itemCount: value.numberOfExerciseInWorkout(widget.workoutName),
          itemBuilder: (context, index) => ExerciseTile(
            exerciseName: value.getRelevantWorkout(widget.workoutName).exercises[index].name, 
            weight: value.getRelevantWorkout(widget.workoutName).exercises[index].weight, 
            reps: value.getRelevantWorkout(widget.workoutName).exercises[index].reps, 
            sets: value.getRelevantWorkout(widget.workoutName).exercises[index].sets, 
            isCompleted: value.getRelevantWorkout(widget.workoutName).exercises[index].isCompleted,
            onCheckboxChanged: (val) => onCheckBoxChange(widget.workoutName, value.getRelevantWorkout(widget.workoutName).exercises[index].name),
          )
    )
    )
    );
  }
}