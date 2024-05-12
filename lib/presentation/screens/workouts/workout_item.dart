import 'package:exercise_app/constants.dart';
import 'package:exercise_app/cubit/workouts_cubit.dart';
import 'package:exercise_app/models/workouts.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup_login_design/background_image.dart';
import 'package:exercise_app/presentation/screens/workouts/myworkouts.dart';
import 'package:exercise_app/presentation/screens/workouts/workouts_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutItem extends StatelessWidget {
  final Workouts workouts;
  const WorkoutItem({super.key, required this.workouts});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(),
        Container(
          width: double.infinity,
          margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
          padding: EdgeInsetsDirectional.all(4),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) =>
                BlocProvider(
                  create: (BuildContext context) =>
                      WorkoutsCubit(workoutsRepository),
                  child: WorkoutDetailsScreen(
                      selectedWorkout: workouts
                  ),
                ))),
            // onTap: () => Navigator.pushNamed(context, workoutDetailScreen, arguments: workouts),
            child: GridTile(
              child: Container(
                color: Colors.transparent,
                child: workouts.video.isEmpty ?
                FadeInImage.assetNetwork(
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: "assets/images/loading.gif",
                    image: workouts.video,
                    fit: BoxFit.cover,
                ) : Image.asset("assets/images/arms2.jpg"),
              ),
              footer: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10,),
                color: Colors.black54,
                alignment: Alignment.bottomCenter,
                child: Text(
                  "${workouts.workout}",
                  style: TextStyle(
                    height: 1.3,
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
