import 'package:exercise_app/exercise_bloc/exercise_event.dart';
import 'package:exercise_app/exercise_bloc/exercise_state.dart';
import 'package:exercise_app/models/exercise_model.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup_login_design/background_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../exercise_bloc/exercise_bloc.dart';

class ExercisePage extends StatelessWidget {
  final String workoutId;

  const ExercisePage({required this.workoutId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExerciseBloc(firestore: FirebaseFirestore.instance)
        ..add(FetchExercisesByWorkoutId(workoutId)),
      child: Stack(
        children: [
          BackgroundImage(),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                } ,
                icon: Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.red,
                  size: 30,
                ),
              ),
              centerTitle: true,
              title: Text(
                'Exercises',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 25,
                ),
              ),
              backgroundColor: Colors.transparent,
            ),
            body: BlocBuilder<ExerciseBloc, ExerciseState>(
              builder: (context, state) {
                if (state is ExercisesLoadInProgress) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ExercisesLoadSuccess) {
                  return ListView.builder(
                    itemCount: state.exercises.length,
                    itemBuilder: (context, index) {
                      final exercise = state.exercises[index];
                      return ExerciseCard(exercise: exercise);
                    },
                  );
                } else {
                  return Center(child: Text('Failed to load exercises'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;

  const ExerciseCard({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[600]?.withOpacity(0.6),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            exercise.imageUrl,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          exercise.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          exercise.description,
          style: TextStyle(
            color: Colors.white
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Icon(
            Icons.arrow_forward_ios,
          color: Colors.white,
        ),
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            builder: (context) => ExerciseDetailsBottomSheet(exercise: exercise),
          );
        },
      ),
    );
  }
}

class ExerciseDetailsBottomSheet extends StatefulWidget {
  final Exercise exercise;

  const ExerciseDetailsBottomSheet({required this.exercise});

  @override
  _ExerciseDetailsBottomSheetState createState() => _ExerciseDetailsBottomSheetState();
}

class _ExerciseDetailsBottomSheetState extends State<ExerciseDetailsBottomSheet> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.exercise.videoUrl)!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[600]?.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.only(bottom: 16),
            ),

            SizedBox(height: 10),
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.red,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                    "Describtion:",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              widget.exercise.description,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded edges with a radius of 20
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
