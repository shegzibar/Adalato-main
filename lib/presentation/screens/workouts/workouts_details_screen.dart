import 'package:exercise_app/models/workouts.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup_login_design/background_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WorkoutDetailsScreen extends StatefulWidget {
  final Workouts selectedWorkout;
  const WorkoutDetailsScreen({super.key, required this.selectedWorkout});

  @override
  State<WorkoutDetailsScreen> createState() => _WorkoutDetailsScreenState();
}

class _WorkoutDetailsScreenState extends State<WorkoutDetailsScreen> {
  late YoutubePlayerController _controller;
  Widget workoutInfo(String title, String value) {
    return RichText(
      //maxLines: 2,
      //overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: Colors.red,
      thickness: 2,
    );
  }



  @override
  void initState( ) {
    // TODO: implement initState


    _controller = YoutubePlayerController(initialVideoId: YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=kwG2ipFRgfo")!, flags: const YoutubePlayerFlags(autoPlay: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              "Details",
            ),
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YoutubePlayer(controller: _controller, showVideoProgressIndicator: true, ),
                  buildDivider(1),
                  workoutInfo("Workout : ", widget.selectedWorkout.workout),
                  buildDivider(280),
                  workoutInfo("Difficulty : ", widget.selectedWorkout.difficulty),
                  buildDivider(270),
                  workoutInfo("Sets : ", widget.selectedWorkout.sets),
                  buildDivider(315),
                  workoutInfo("Explanation : ", widget.selectedWorkout.explanation),
                  buildDivider(260),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
