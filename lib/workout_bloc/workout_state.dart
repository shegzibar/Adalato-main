/*
import 'package:equatable/equatable.dart';
import 'package:exercise_app/models/workout_model.dart';

abstract class WorkoutState extends Equatable {
  const WorkoutState();

  @override
  List<Object> get props => [];
}

class WorkoutsInitial extends WorkoutState {}

class WorkoutsLoadInProgress extends WorkoutState {}

class WorkoutsLoadSuccess extends WorkoutState {
  final List<Workout> workouts;

  const WorkoutsLoadSuccess(this.workouts);

  @override
  List<Object> get props => [workouts];
}

class WorkoutsLoadFailure extends WorkoutState {}
*/
import 'package:equatable/equatable.dart';
import 'package:exercise_app/models/workout_model.dart';

abstract class WorkoutState extends Equatable {
  const WorkoutState();

  @override
  List<Object> get props => [];
}

class WorkoutsInitial extends WorkoutState {}

class WorkoutsLoadInProgress extends WorkoutState {}

class WorkoutsLoadSuccess extends WorkoutState {
  final List<Workout> workouts;

  const WorkoutsLoadSuccess(this.workouts);

  @override
  List<Object> get props => [workouts];
}

class WorkoutsLoadFailure extends WorkoutState {}
