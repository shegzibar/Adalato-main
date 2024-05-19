import 'package:cloud_firestore/cloud_firestore.dart';

class Program {
  final String id;
  final String name;
  final String type; // "Calisthenics", "Weighted", "Weighted Calisthenics"

  Program({required this.id, required this.name, required this.type});

  factory Program.fromSnapshot(DocumentSnapshot snapshot) {
    return Program(
      id: snapshot.id,
      name: snapshot['name'],
      type: snapshot['type'],
    );
  }
}
