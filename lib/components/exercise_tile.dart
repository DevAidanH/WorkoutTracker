import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker/data/workout_data.dart';

class ExerciseTile extends StatelessWidget {
  final String exerciseName;
  final String weight;
  final String reps;
  final String sets;
  final bool isCompleted;
  final void Function(bool?)? onCheckboxChanged;
  final String workoutContainingExerciseName;

  ExerciseTile({
    super.key, 
    required this.exerciseName, 
    required this.weight, 
    required this.reps, 
    required this.sets, 
    required this.isCompleted,
    required this. onCheckboxChanged,
    required this.workoutContainingExerciseName
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Container(
            color: Colors.blue,
            child: ListTile(
              title: Text(exerciseName),
                subtitle: Row(
                  children: [
                    Chip(label: Text(
                      "${weight}kg",
                      ) 
                    ),
                    Chip(label: Text(
                      "${reps} reps",
                      )
                    ),
                    Chip(label: Text(
                      "${sets} sets",
                      )
                    )
                  ],
                ),
                trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => value.editExercise(workoutContainingExerciseName, exerciseName, context),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => value.deleteExercise(workoutContainingExerciseName, exerciseName, context),
                ),
                Checkbox(value: isCompleted, onChanged: (value) => onCheckboxChanged!(value)),
              ],
            ),
            ),
      )
      );
  }
}