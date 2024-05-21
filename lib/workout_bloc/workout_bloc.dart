/*
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise_app/models/workout_model.dart';
import 'workout_event.dart';
import 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final FirebaseFirestore firestore;

  WorkoutBloc({required this.firestore}) : super(WorkoutsInitial()) {
    on<FetchWorkoutsByProgramId>(_onFetchWorkoutsByProgramId);
    on<ToggleFavoriteStatus>(_onToggleFavoriteStatus);
    on<FetchFavoriteWorkouts>(_onFetchFavoriteWorkouts);
  }

  void _onFetchWorkoutsByProgramId(
      FetchWorkoutsByProgramId event,
      Emitter<WorkoutState> emit,
      ) async {
    emit(WorkoutsLoadInProgress());
    try {
      final querySnapshot = await firestore
          .collection('workout')
          .where('programId', isEqualTo: event.programId)
          .get();
      final workouts = querySnapshot.docs
          .map((doc) => Workout.fromSnapshot(doc))
          .toList();
      emit(WorkoutsLoadSuccess(workouts));
    } catch (_) {
      emit(WorkoutsLoadFailure());
    }
  }

  void _onToggleFavoriteStatus(
      ToggleFavoriteStatus event,
      Emitter<WorkoutState> emit,
      ) async {
    try {
      await firestore.collection('workout').doc(event.workoutId).update({
        'isFavorite': event.isFavorite,
      });

      final currentState = state;
      if (currentState is WorkoutsLoadSuccess) {
        final updatedWorkouts = currentState.workouts.map((workout) {
          return workout.id == event.workoutId
              ? workout.copyWith(isFavorite: event.isFavorite)
              : workout;
        }).toList();
        emit(WorkoutsLoadSuccess(updatedWorkouts));
      }
    } catch (error) {
      // Handle error if needed
    }
  }

  void _onFetchFavoriteWorkouts(
      FetchFavoriteWorkouts event,
      Emitter<WorkoutState> emit,
      ) async {
    emit(WorkoutsLoadInProgress());
    try {
      final querySnapshot = await firestore
          .collection('workout')
          .where('isFavorite', isEqualTo: true)
          .get();
      final workouts = querySnapshot.docs
          .map((doc) => Workout.fromSnapshot(doc))
          .toList();
      emit(WorkoutsLoadSuccess(workouts));
    } catch (_) {
      emit(WorkoutsLoadFailure());
    }
  }
}
*/
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise_app/models/workout_model.dart';
import 'workout_event.dart';
import 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final FirebaseFirestore firestore;

  WorkoutBloc({required this.firestore}) : super(WorkoutsInitial()) {
    on<FetchWorkoutsByProgramId>(_onFetchWorkoutsByProgramId);
    on<FetchFavoriteWorkouts>(_onFetchFavoriteWorkouts);
    on<ToggleFavoriteStatus>(_onToggleFavoriteStatus);
  }

  void _onFetchWorkoutsByProgramId(
      FetchWorkoutsByProgramId event,
      Emitter<WorkoutState> emit,
      ) async {
    emit(WorkoutsLoadInProgress());
    try {
      final querySnapshot = await firestore
          .collection('workout')
          .where('programId', isEqualTo: event.programId)
          .get();
      final workouts = querySnapshot.docs
          .map((doc) => Workout.fromSnapshot(doc, isFavorite: false))
          .toList();
      emit(WorkoutsLoadSuccess(workouts));
    } catch (_) {
      emit(WorkoutsLoadFailure());
    }
  }

  void _onFetchFavoriteWorkouts(
      FetchFavoriteWorkouts event,
      Emitter<WorkoutState> emit,
      ) async {
    emit(WorkoutsLoadInProgress());
    try {
      final favoriteSnapshot = await firestore
          .collection('users')
          .doc(event.userId)
          .collection('favorites')
          .get();
      final favoriteIds = favoriteSnapshot.docs.map((doc) => doc.id).toList();

      final workoutSnapshot = await firestore.collection('workout').get();
      final workouts = workoutSnapshot.docs.map((doc) {
        final isFavorite = favoriteIds.contains(doc.id);
        return Workout.fromSnapshot(doc, isFavorite: isFavorite);
      }).where((workout) => workout.isFavorite).toList();

      emit(WorkoutsLoadSuccess(workouts));
    } catch (_) {
      emit(WorkoutsLoadFailure());
    }
  }

  void _onToggleFavoriteStatus(
      ToggleFavoriteStatus event,
      Emitter<WorkoutState> emit,
      ) async {
    try {
      final userFavoritesRef = firestore
          .collection('users')
          .doc(event.userId)
          .collection('favorites')
          .doc(event.workoutId);

      if (event.isFavorite) {
        await userFavoritesRef.set({});
      } else {
        await userFavoritesRef.delete();
      }

      add(FetchFavoriteWorkouts(userId: event.userId));
    } catch (_) {
      emit(WorkoutsLoadFailure());
    }
  }
}
