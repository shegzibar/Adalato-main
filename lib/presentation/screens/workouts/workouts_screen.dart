import 'package:exercise_app/cubit/workouts_cubit.dart';
import 'package:exercise_app/models/workouts.dart';
import 'package:exercise_app/presentation/screens/workouts/workout_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exercise_app/generated/l10n.dart';

class WorkoutsScreen extends StatefulWidget {
  WorkoutsScreen({super.key, required this.value});
  String? value;
  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  late List<Workouts> allWorkouts;
  late List<Workouts> upperbodyWorkouts = allWorkouts
      .where((workout) =>
  workout.muscle.startsWith("Biceps")
      || workout.muscle.contains("Chest")
      || workout.muscle.contains("Triceps")
      || workout.muscle.contains("Shoulders") )
      .toList();

  late List<Workouts> BackWorkouts = allWorkouts
      .where((workout) =>
  workout.muscle.startsWith("Back")
      || workout.muscle.contains("Trapezius") )
      .toList();

  late List<Workouts> absWorkouts = allWorkouts
      .where((workout) =>
      workout.muscle.startsWith("Abs"))
      .toList();

  late List<Workouts> LegsWorkouts =  allWorkouts.where((workout) =>
  workout.muscle.startsWith("Legs")
      || workout.muscle.contains("Lats")
      || workout.muscle.contains("Hamstring")
      || workout.muscle.contains("Calves")
      || workout.muscle.contains("Quadriceps")
      || workout.muscle.contains("Glutes") )
      .toList();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //allWorkouts =
        BlocProvider.of<WorkoutsCubit>(context).getAllWorkouts().cast<Workouts>();

  }

  Widget buildBlockWidget() {
    return BlocBuilder<WorkoutsCubit,WorkoutsState>(builder: (context, state) {
      if(state is WorkoutsLoaded){
        allWorkouts = (state).workouts;
        return buildLoadedListWidgets();
      } else {
        return showLoadingIndictor();
      }
    },
    );
  }

  Widget showLoadingIndictor() {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.red,
      ),
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            buildWorkoutsList(),
          ],
        ),
      ),
    );
  }

  Widget buildWorkoutsList() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2/2,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: widget.value == "Upper Body" ? upperbodyWorkouts.length : widget.value == "Back" ?  BackWorkouts.length : widget.value == "Legs" ? LegsWorkouts.length : widget.value  == "Abs" ? absWorkouts.length : allWorkouts.length ,
        itemBuilder: (context,index) {
          return WorkoutItem(workouts:widget.value == "Upper Body" ? upperbodyWorkouts[index] : widget.value  == "Back" ?  BackWorkouts[index] : widget.value  == "Legs" ? LegsWorkouts[index] : widget.value  == "Abs" ? absWorkouts[index] : allWorkouts[index] ,);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: SafeArea(child: buildBlockWidget()),
    );
  }
}
