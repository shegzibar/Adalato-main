/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Workout extends Equatable {
  final String id;
  final String name;
  final String programId;
  final bool isFavorite; // New field for favorite status

  Workout({
    required this.id,
    required this.name,
    required this.programId,
    this.isFavorite = false, // Default to false
  });

  @override
  List<Object?> get props => [id, name, programId, isFavorite];

  @override
  bool get stringify => true; // Optional: Enables readable toString() for debugging

  factory Workout.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>?; // Ensure data is not null
    return Workout(
      id: snapshot.id,
      name: data?['name'] ?? '', // Provide a default value if 'name' is null
      programId: data?['programId'] ?? '', // Provide a default value if 'programId' is null
      isFavorite: data?['isFavorite'] ?? false, // Provide a default value if 'isFavorite' is null
    );
  }

  // Method to update the favorite status
  Workout copyWith({bool? isFavorite}) {
    return Workout(
      id: this.id,
      name: this.name,
      programId: this.programId,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  // Method to convert Workout to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'programId': programId,
      'isFavorite': isFavorite,
    };
  }
}
*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Workout extends Equatable {
  final String id;
  final String name;
  final String programId;
  final bool isFavorite;

  Workout({
    required this.id,
    required this.name,
    required this.programId,
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [id, name, programId, isFavorite];

  @override
  bool get stringify => true;

  factory Workout.fromSnapshot(DocumentSnapshot snapshot, {required bool isFavorite}) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Workout(
      id: snapshot.id,
      name: data['name'],
      programId: data['programId'],
      isFavorite: isFavorite,
    );
  }
}
