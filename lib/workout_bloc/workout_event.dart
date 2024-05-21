/*
import 'package:equatable/equatable.dart';

abstract class WorkoutEvent extends Equatable {
  const WorkoutEvent();

  @override
  List<Object> get props => [];
}

class FetchWorkoutsByProgramId extends WorkoutEvent {
  final String programId;

  const FetchWorkoutsByProgramId({required this.programId});

  @override
  List<Object> get props => [programId];
}

class ToggleFavoriteStatus extends WorkoutEvent {
  final String workoutId;
  final bool isFavorite;

  const ToggleFavoriteStatus({required this.workoutId, required this.isFavorite});

  @override
  List<Object> get props => [workoutId, isFavorite];
}

class FetchFavoriteWorkouts extends WorkoutEvent {}
*/
import 'package:equatable/equatable.dart';

abstract class WorkoutEvent extends Equatable {
  const WorkoutEvent();

  @override
  List<Object> get props => [];
}

class FetchWorkoutsByProgramId extends WorkoutEvent {
  final String programId;

  const FetchWorkoutsByProgramId({required this.programId});

  @override
  List<Object> get props => [programId];
}

class FetchFavoriteWorkouts extends WorkoutEvent {
  final String userId;

  const FetchFavoriteWorkouts({required this.userId});

  @override
  List<Object> get props => [userId];
}

class ToggleFavoriteStatus extends WorkoutEvent {
  final String workoutId;
  final String userId;
  final bool isFavorite;

  const ToggleFavoriteStatus({
    required this.workoutId,
    required this.userId,
    required this.isFavorite,
  });

  @override
  List<Object> get props => [workoutId, userId, isFavorite];
}
