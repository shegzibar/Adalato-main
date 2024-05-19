import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise_app/models/workout_model.dart';
import 'workout_event.dart';
import 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final FirebaseFirestore firestore;

  WorkoutBloc({required this.firestore}) : super(WorkoutsInitial()) {
    on<FetchWorkoutsByProgramId>(_onFetchWorkoutsByProgramId);
  }

  void _onFetchWorkoutsByProgramId(
      FetchWorkoutsByProgramId event,
      Emitter<WorkoutState> emit,
      ) async {
    emit(WorkoutsLoadInProgress());
    try {
      final querySnapshot = await firestore
          .collection('workouts')
          .where('programId', isEqualTo: event.programId)
          .get();
      final workouts = querySnapshot.docs
          .map((doc) => Workout(
        id: doc.id,
        name: doc['name'],
        programId: doc['programId'],
      ))
          .toList();
      emit(WorkoutsLoadSuccess(workouts));
    } catch (_) {
      emit(WorkoutsLoadFailure());
    }
  }
}
