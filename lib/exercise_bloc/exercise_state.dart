import 'package:equatable/equatable.dart';
import 'package:exercise_app/models/exercise_model.dart';


abstract class ExerciseState extends Equatable {
  const ExerciseState();

  @override
  List<Object> get props => [];
}

class ExercisesLoadInProgress extends ExerciseState {}

class ExercisesLoadSuccess extends ExerciseState {
  final List<Exercise> exercises;

  const ExercisesLoadSuccess(this.exercises);

  @override
  List<Object> get props => [exercises];
}

class ExercisesLoadFailure extends ExerciseState {}
