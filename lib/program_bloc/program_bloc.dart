import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise_app/models/program_model.dart';
import 'package:meta/meta.dart';

part 'program_event.dart';
part 'program_state.dart';

class ProgramBloc extends Bloc<ProgramEvent, ProgramState> {
  final FirebaseFirestore firestore;

  ProgramBloc({required this.firestore}) : super(ProgramsInitial()) {
    on<LoadPrograms>(_onLoadPrograms);
  }

  Future<void> _onLoadPrograms(ProgramEvent event, Emitter<ProgramState> emit) async {
    emit(ProgramsLoadInProgress());
    try {
      QuerySnapshot snapshot = await firestore.collection('program').get();
      List<Program> allPrograms = snapshot.docs.map((doc) => Program.fromSnapshot(doc)).toList();
      emit(ProgramsLoadSuccess(
        calisthenicsPrograms: allPrograms.where((p) => p.type == "Calisthenics").toList(),
        weightedPrograms: allPrograms.where((p) => p.type == "Weighted").toList(),
        weightedCalisthenicsPrograms: allPrograms.where((p) => p.type == "Weighted Calisthenics").toList(),
      ));
    } catch (_) {
      emit(ProgramsLoadFailure());
    }
  }
}
