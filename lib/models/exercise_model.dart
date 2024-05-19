import 'package:cloud_firestore/cloud_firestore.dart';

class Exercise {
  final String id;
  final String name;
  final String imageUrl;
  final String videoUrl;
  final String description;

  Exercise({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.videoUrl,
    required this.description,
  });
  factory Exercise.fromSnapshot(DocumentSnapshot snapshot) {
    return Exercise(
      id: snapshot.id,
      name: snapshot['name'],
      imageUrl: snapshot['pictureUrl'],
      videoUrl: snapshot['youtubeLink'],
      description: snapshot['description'],
    );
  }
}
