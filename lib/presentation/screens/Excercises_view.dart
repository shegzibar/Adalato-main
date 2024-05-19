import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise_app/exercise_bloc/exercise_bloc.dart';
import 'package:exercise_app/exercise_bloc/exercise_event.dart';
import 'package:exercise_app/exercise_bloc/exercise_state.dart';
import 'package:exercise_app/presentation/screens/exercise_screen.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup_login_design/background_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExercisePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => ExerciseBloc(firestore: FirebaseFirestore.instance)
        ..add(FetchAllExercises()),
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
                'Exercises',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 25,
                ),
              ),
              backgroundColor: Colors.transparent,
            ),
            body: BlocBuilder<ExerciseBloc, ExerciseState>(
              builder: (context, state) {
                if (state is ExercisesLoadInProgress) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ExercisesLoadSuccess) {
                  return ListView.builder(
                    itemCount: state.exercises.length,
                    itemBuilder: (context, index) {
                      final exercise = state.exercises[index];
                      return ExerciseCard(exercise: exercise);
                    },
                  );
                } else {
                  return Center(child: Text('Failed to load exercises'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
