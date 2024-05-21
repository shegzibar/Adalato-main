import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise_app/models/workout_model.dart';
import 'package:exercise_app/workout_bloc/workout_bloc.dart';
import 'package:exercise_app/workout_bloc/workout_event.dart';
import 'package:exercise_app/workout_bloc/workout_state.dart';
import 'package:exercise_app/presentation/screens/exercise_screen.dart';

class MyWorkoutsPage extends StatelessWidget {
  final String userId;

  const MyWorkoutsPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorkoutBloc(firestore: FirebaseFirestore.instance)..add(FetchFavoriteWorkouts(userId: userId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Workouts'),
          centerTitle: true,
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
                  return WorkoutTile(workout: workout, userId: userId);
                },
              );
            } else if (state is WorkoutsLoadFailure) {
              return Center(child: Text('Failed to load workouts'));
            } else {
              return Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}

class WorkoutTile extends StatelessWidget {
  final Workout workout;
  final String userId;

  const WorkoutTile({required this.workout, required this.userId});

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
        trailing: IconButton(
          icon: Icon(
            workout.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.white,
          ),
          onPressed: () {
            BlocProvider.of<WorkoutBloc>(context).add(
              ToggleFavoriteStatus(
                workoutId: workout.id,
                userId: userId,
                isFavorite: !workout.isFavorite,
              ),
            );
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ExercisePage(workoutId: workout.id),
            ),
          );
        },
      ),
    );
  }
}
