import 'package:equatable/equatable.dart';

abstract class ExerciseEvent extends Equatable {
  const ExerciseEvent();

  @override
  List<Object> get props => [];
}

class FetchExercisesByWorkoutId extends ExerciseEvent {
  final String workoutId;

  const FetchExercisesByWorkoutId(this.workoutId);

  @override
  List<Object> get props => [workoutId];
}
class FetchAllExercises extends ExerciseEvent {}

