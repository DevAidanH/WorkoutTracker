import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker/data/workout_data.dart';
import 'workoutpage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //Text controller to access user inputted text
  final newWorkoutNameController = TextEditingController();

  //Create new workout
  void createNewWorkout(){
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text("Create New Workout"),
        content: TextField(
          controller: newWorkoutNameController,
        ),
        actions: [
          //Save button
          MaterialButton(
            onPressed: save, 
            child: Text("Save")
          ),
          //Cancel button
          MaterialButton(
            onPressed: cancel, 
            child: Text("Cancel"),
          )
        ],
        )
    );
  }

  //Go to workout page
  void goToWorkoutPage(String workoutName){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Workoutpage(workoutName: workoutName,)));
  }

  //Save workout
  void save(){
    String newWorkoutName =newWorkoutNameController.text;
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);

    Navigator.pop(context);
    clear();
  }

  //Cancel workout
  void cancel(){
    Navigator.pop(context);
    clear();
  }

  //Clear controller
  void clear(){
    newWorkoutNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
      appBar: AppBar(
        title: const Text("Workout Tracker"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewWorkout,
        child: Icon(Icons.add)
      ),
      body: ListView.builder(
        itemCount: value.getWorkoutList().length,
        itemBuilder: (context, index) => ListTile(
          title: Text(value.getWorkoutList()[index].name),
          trailing: IconButton(
            onPressed: () => goToWorkoutPage(value.getWorkoutList()[index].name),
            icon: Icon(Icons.arrow_forward_ios)
            ),
      )),
    )
    );
  }
}