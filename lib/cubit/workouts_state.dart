part of 'workouts_cubit.dart';

@immutable
/*sealed*/ abstract class WorkoutsState {}

/*final*/ class WorkoutsInitial extends WorkoutsState {}

class WorkoutsLoaded extends WorkoutsState{
  final List<Workouts> workouts;

  WorkoutsLoaded(this.workouts);
}
