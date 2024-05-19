import 'package:exercise_app/models/workout_model.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup_login_design/background_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise_app/presentation/screens/exercise_screen.dart';
import 'package:exercise_app/workout_bloc/workout_bloc.dart';
import 'package:exercise_app/workout_bloc/workout_event.dart';
import 'package:exercise_app/workout_bloc/workout_state.dart';

class WorkoutsPage extends StatelessWidget {
  final String programId;

  const WorkoutsPage({required this.programId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorkoutBloc(firestore: FirebaseFirestore.instance)
        ..add(FetchWorkoutsByProgramId(programId: programId)),
      child: Stack(
        children: [
          BackgroundImage(),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                } ,
                icon: Icon(
                    Icons.arrow_back_outlined,
                  color: Colors.red,
                  size: 30,
                ),
              ),
              centerTitle: true,
                title: Text(
                    'Workouts',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 25,
                  ),
                ),
              backgroundColor: Colors.transparent,
            ),
            body: BlocBuilder<WorkoutBloc, WorkoutState>(
              builder: (context, state) {
                if (state is WorkoutsLoadInProgress) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is WorkoutsLoadSuccess) {
                  return ListView.builder(
                    itemCount: state.workouts.length,
                    itemBuilder: (context, index) {
                      final workout = state.workouts[index];
                      return WorkoutTile(workout: workout);
                    },
                  );
                } else {
                  return Center(child: Text('Failed to load workouts'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WorkoutTile extends StatelessWidget {
  final Workout workout;

  const WorkoutTile({required this.workout});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[600]?.withOpacity(0.6),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        tileColor: Colors.transparent,
        contentPadding: EdgeInsets.all(15),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ExercisePage(workoutId: workout.id),
            ),
          );
        },
        leading: Icon(
            Icons.fitness_center,
          color: Colors.white,
        ),
        title: Text(
          workout.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(
            Icons.arrow_forward_ios,
          color: Colors.white,
        ),
      ),
    );
  }
}
