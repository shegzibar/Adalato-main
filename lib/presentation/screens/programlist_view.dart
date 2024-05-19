import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup_login_design/background_image.dart';
import 'package:exercise_app/presentation/screens/workout_screen.dart';
import 'package:exercise_app/program_bloc/program_bloc.dart';
import 'package:exercise_app/models/program_model.dart';
import 'package:exercise_app/workout_bloc/workout_bloc.dart';
import 'package:exercise_app/workout_bloc/workout_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Programs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => ProgramBloc(firestore: FirebaseFirestore.instance)..add(LoadPrograms()),
      child: Stack(
        children: [
          BackgroundImage(),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: BlocBuilder<ProgramBloc, ProgramState>(
                builder: (context, state) {
                  if (state is ProgramsLoadInProgress) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ProgramsLoadSuccess) {
                    List<Program> allPrograms = [
                      ...state.calisthenicsPrograms,
                      ...state.weightedPrograms,
                      ...state.weightedCalisthenicsPrograms
                    ]; // Combine all program lists into one
                    return buildProgramGrid(allPrograms); // Adjusted to handle all programs
                  } else {
                    return Center(child: Text('Failed to load programs'));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProgramGrid(List<Program> programs) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        childAspectRatio: 0.8, // Aspect ratio of each item
      ),
      itemCount: programs.length,
      itemBuilder: (context, index) {
        final program = programs[index];
        String imagePath = getImageForProgramType(program.type); // Dynamically get image based on type

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => BlocProvider(
                  create: (context) => WorkoutBloc(firestore: FirebaseFirestore.instance)
                    ..add(FetchWorkoutsByProgramId(programId: program.id.toString())),
                  child: WorkoutsPage(programId: program.id),
                ),
              ),
            );
          },
          child: Card(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 1),
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    program.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp, // Adjusted for better readability
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String getImageForProgramType(String programType) {
    switch (programType) {
      case 'Calisthenics':
        return "assets/images/back.jpg";
      case 'Weighted':
        return "assets/images/back.jpg";
      case 'Weighted Calisthenics':
        return "assets/images/upperbody.jpg";
      default:
        return "assets/images/back.jpg";
    }
  }
}
