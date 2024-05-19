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
