import 'package:exercise_app/generated/l10n.dart';
import 'package:exercise_app/presentation/screens/app_router.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup_login_design/background_image.dart';
import 'package:exercise_app/presentation/screens/workouts/workouts_screen.dart';
import 'package:exercise_app/web_services/workout_webservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cubit/workouts_cubit.dart';
import '../../../web_services/workout_repository.dart';

class MyWorkouts extends StatefulWidget {
  const MyWorkouts({super.key});

  @override
  State<MyWorkouts> createState() => _MyWorkoutsState();
}
WorkoutsRepository workoutsRepository = WorkoutsRepository(WorkoutWebServices());
WorkoutsCubit workoutsCubit = WorkoutsCubit(workoutsRepository);
class _MyWorkoutsState extends State<MyWorkouts> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              S.of(context).explore,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                buildWorkoutContainer("assets/images/upperbody.jpg", "Upper Body"),
                buildWorkoutContainer("assets/images/back.jpg", "Back"),
                buildWorkoutContainer("assets/images/abs.jpg", "Abs"),
                buildWorkoutContainer("assets/images/legs.jpg", "Legs"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildWorkoutContainer(String imagePath, String title) {
    return GestureDetector(
      onTap: () {
       if(title == "Upper Body"){
       Navigator.push(context,  MaterialPageRoute(
         builder: (_) =>
             BlocProvider(
               create: (BuildContext context) => WorkoutsCubit(workoutsRepository),
               child: WorkoutsScreen(value: "Upper Body",),
             ),
       ),);
       }
       if(title == "Back"){
         Navigator.push(context,  MaterialPageRoute(
           builder: (_) =>
               BlocProvider(
                 create: (BuildContext context) => WorkoutsCubit(workoutsRepository),
                 child: WorkoutsScreen(value: "Back",),
               ),
         ),);
       }
       if(title == "Abs"){
         Navigator.push(context,  MaterialPageRoute(
           builder: (_) =>
               BlocProvider(
                 create: (BuildContext context) => WorkoutsCubit(workoutsRepository),
                 child: WorkoutsScreen(value: "Abs",),
               ),
         ),);
       }
       if(title == "Legs"){
         Navigator.push(context,  MaterialPageRoute(
           builder: (_) =>
               BlocProvider(
                 create: (BuildContext context) => WorkoutsCubit(workoutsRepository),
                 child: WorkoutsScreen(value: "Legs",),
               ),
         ),);
       }// Placeholder for action
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        height: 200, // Specify your height here
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 1), // Red frame
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover, // This will cover the container's area with the image
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              //color: Colors.black.withOpacity(0.5), // Semi-transparent black background for the text
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}