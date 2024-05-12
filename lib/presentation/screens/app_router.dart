import 'package:exercise_app/models/workouts.dart';
import 'package:exercise_app/presentation/screens/workouts/workouts_details_screen.dart';
import 'package:exercise_app/presentation/screens/workouts/workouts_screen.dart';
import 'package:flutter/material.dart';
import 'package:exercise_app/presentation/screens/bottom_navigator/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants.dart';
import '../../cubit/workouts_cubit.dart';
import '../../web_services/workout_repository.dart';
import '../../web_services/workout_webservices.dart';


class AppRouter {

  String? value;
  late WorkoutsRepository workoutsRepository;
  late WorkoutsCubit workoutsCubit;

  AppRouter() {
    workoutsRepository = WorkoutsRepository(WorkoutWebServices());
    workoutsCubit = WorkoutsCubit(workoutsRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case workoutsScreen:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(
                create: (BuildContext context) =>
                    WorkoutsCubit(workoutsRepository),
                child: WorkoutsScreen(value: value,),
              ),
        );

      case workoutDetailScreen:
        final selectedWorkout = settings.arguments as Workouts;
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (BuildContext context) =>
                  WorkoutsCubit(workoutsRepository),
              child: WorkoutDetailsScreen(
                  selectedWorkout: settings.arguments as Workouts
              ),
            ));
    }
  }
}