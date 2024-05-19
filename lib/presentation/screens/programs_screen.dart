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

class ProgramsPage extends StatelessWidget {


  // Method to get a random image based on program type
  String getImageForProgramType(String programType) {
    switch (programType) {
      case 'Calisthenics':
        return "assets/images/back.jpg";
      case 'Weighted':
        return "assets/images/back.jpg";
      case 'Weighted Calisthenics':
        return "assets/images/upperbody.jpg";
      default:
        return "assets/images/back.jpg"; // Default to Calisthenics image
    }
  }

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
                    return Column(
                      children: [
                        Expanded(child: buildProgramGrid(state.calisthenicsPrograms, 'Calisthenics')),
                        Expanded(child: buildProgramGrid(state.weightedPrograms, 'Weighted')),
                        Expanded(child: buildProgramGrid(state.weightedCalisthenicsPrograms, 'Weighted Calisthenics')),
                      ],
                    );
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

  Widget buildProgramGrid(List<Program> programs, String title) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold
              )
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // Use 1 to simulate a row-like appearance
                childAspectRatio: 0.5 // Adjust aspect ratio for better control of item size
            ),
            scrollDirection: Axis.horizontal,
            itemCount: programs.length,
            itemBuilder: (context, index) {
              final program = programs[index];
              String imagePath = getImageForProgramType(title); // Get image based on program type

              return InkWell(
                onTap: () {
                  Navigator.push (
                    context,
                    MaterialPageRoute (
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
                          program.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //Center(child: Text(program.name)),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
