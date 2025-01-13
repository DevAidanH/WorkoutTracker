import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker/data/workout_data.dart';
import 'package:workout_tracker/pages/workoutpage.dart';

// ignore: must_be_immutable
class WorkoutTile extends StatelessWidget {
  String workoutName;
  
  WorkoutTile({required this.workoutName, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer <WorkoutData>(
      builder: (context, value, child) => Card(
        color: Theme.of(context).colorScheme.primary,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          contentPadding: EdgeInsets.all(10),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Workoutpage(workoutName: workoutName,)));
          },
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15), 
            child: Text(workoutName.toUpperCase(), style: Theme.of(context).textTheme.displayLarge)
          ),
          trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => value.editworkout(workoutName, context),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => value.deleteWorkout(workoutName, context),
                ),
                /*IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Workoutpage(workoutName: workoutName,)));
                  },
                  icon: Icon(Icons.arrow_forward_ios), color: Theme.of(context).colorScheme.surface,
                ), */
              ],
            ),
        ),
      )
    );
  }
}