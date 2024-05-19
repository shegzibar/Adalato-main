import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Workout extends Equatable {
  final String id;
  final String name;
  final String programId;

  Workout({
    required this.id,
    required this.name,
    required this.programId,
  });

  @override
  List<Object?> get props => [id, name, programId];

  @override
  bool get stringify => true; // Optional: Enables readable toString() for debugging

  factory Workout.fromSnapshot(DocumentSnapshot snapshot) {
    return Workout(
      id: snapshot.id,
      name: snapshot['name'],
      programId: snapshot['programId'],
    );
  }

}
