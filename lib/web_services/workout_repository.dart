import 'package:exercise_app/models/workouts.dart';
import 'package:exercise_app/web_services/workout_webservices.dart';
import 'package:flutter/cupertino.dart';

class WorkoutsRepository {
  final WorkoutWebServices workoutWebServices;

  WorkoutsRepository(this.workoutWebServices);

  Future<List<Workouts>> listOfWorkouts() async {
    final workouts = await workoutWebServices.getAllWorkouts();
    return workouts.map((character) => Workouts.fromJson(character)).toList();
  }
}