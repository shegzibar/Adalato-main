import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise_app/models/exercise_model.dart';
import 'exercise_event.dart';
import 'exercise_state.dart';


class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final FirebaseFirestore firestore;

  ExerciseBloc({required this.firestore}) : super(ExercisesLoadInProgress()) {
    on<FetchExercisesByWorkoutId>(_onFetchExercisesByWorkoutId);
    on<FetchAllExercises>(_onFetchAllExercises);
  }

  void _onFetchAllExercises(FetchAllExercises event, Emitter<ExerciseState> emit) async {
    emit(ExercisesLoadInProgress());
    try {
      final QuerySnapshot snapshot = await firestore.collection('exercises').get();

      final exercises = snapshot.docs.map((doc) {
        return Exercise.fromSnapshot(doc);
      }).toList();

      emit(ExercisesLoadSuccess(exercises));
    } catch (e) {
      emit(ExercisesLoadFailure());
    }
  }

  void _onFetchExercisesByWorkoutId(
      FetchExercisesByWorkoutId event,
      Emitter<ExerciseState> emit,
      ) async {
    emit(ExercisesLoadInProgress());
    try {
      final querySnapshot = await firestore
          .collection('exercises')
          .where('workoutId', isEqualTo: event.workoutId)
          .get();
      final exercises = querySnapshot.docs
          .map((doc) => Exercise(
        id: doc.id,
        name: doc['name'],
        imageUrl: doc['pictureUrl'],
        videoUrl: doc['youtubeLink'],
        description: doc['description'],
      ))
          .toList();
      emit(ExercisesLoadSuccess(exercises));
    } catch (_) {
      emit(ExercisesLoadFailure());
    }

  }

}
