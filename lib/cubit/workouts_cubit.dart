import 'package:bloc/bloc.dart';
import 'package:exercise_app/models/workouts.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:exercise_app/web_services/workout_repository.dart';
part 'workouts_state.dart';

class WorkoutsCubit extends Cubit<WorkoutsState> {
  final WorkoutsRepository workoutsRepository;
   List<Workouts> workouts = [];

  WorkoutsCubit(this.workoutsRepository) : super(WorkoutsInitial());

  List<Workouts> getAllWorkouts() {
    workoutsRepository.listOfWorkouts().then((workouts) {
      emit(WorkoutsLoaded(workouts));
      this.workouts = workouts;
    });
  return workouts;

  }

}
