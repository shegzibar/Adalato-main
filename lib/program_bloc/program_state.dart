part of 'program_bloc.dart';

@immutable
abstract class ProgramState {}

class ProgramsInitial extends ProgramState {}

class ProgramsLoadInProgress extends ProgramState {}

class ProgramsLoadSuccess extends ProgramState {
  final List<Program> calisthenicsPrograms;
  final List<Program> weightedPrograms;
  final List<Program> weightedCalisthenicsPrograms;

  ProgramsLoadSuccess({
    required this.calisthenicsPrograms,
    required this.weightedPrograms,
    required this.weightedCalisthenicsPrograms,
  });
}

class ProgramsLoadFailure extends ProgramState {}