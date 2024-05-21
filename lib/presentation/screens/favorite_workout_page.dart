import 'package:exercise_app/presentation/screens/my_workout_page.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup_login_design/background_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise_app/workout_bloc/workout_bloc.dart';
import 'package:exercise_app/workout_bloc/workout_event.dart';
import 'package:exercise_app/workout_bloc/workout_state.dart';

class FavoriteWorkoutsPage extends StatelessWidget {
  final String userId;

  const FavoriteWorkoutsPage({super.key, required this.userId});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorkoutBloc(firestore: FirebaseFirestore.instance)
        ..add(FetchFavoriteWorkouts(userId: userId)),
      child: Stack(
        children: [
          BackgroundImage(),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.red,
                  size: 30,
                ),
              ),
              centerTitle: true,
              title: Text(
                'Favorite Workouts',
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
                      return WorkoutTile(workout: workout, userId: userId);
                    },
                  );
                } else {
                  return Center(child: Text('Failed to load favorite workouts'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
