import 'package:exercise_app/cubit/workouts_cubit.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup_login_design/background_image.dart';
import 'package:exercise_app/presentation/screens/workouts/myworkouts.dart';
import 'package:exercise_app/presentation/screens/workouts/tips.dart';
import 'package:exercise_app/presentation/screens/workouts/workouts_screen.dart';
import 'package:flutter/material.dart';
import 'package:exercise_app/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> _journals = [];
  bool _isloading = true;
  DateTime today = DateTime.now();

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
              S.of(context).home,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: TableCalendar(
                    focusedDay: today,
                    firstDay: DateTime.utc(2010, 1, 1),
                    lastDay: DateTime.utc(2030, 1, 1),
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(color: Colors.white), // Title color
                      leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white), // Left icon color
                      rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white), // Right icon color
                    ),
                    calendarStyle: CalendarStyle(
                      defaultTextStyle: TextStyle(color: Colors.white), // Default text style
                      weekendTextStyle: TextStyle(color: Colors.red), // Weekend text style
                      outsideTextStyle: TextStyle(color: Colors.white.withOpacity(0.5)), // Outside days text style
                      todayTextStyle: TextStyle(color: Colors.black), // Today text style
                      todayDecoration: BoxDecoration(
                        color: Colors.white, // Today color
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.red, // Selected day color
                        shape: BoxShape.circle,
                      ),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: Colors.white), // Weekday style
                      weekendStyle: TextStyle(color: Colors.red), // Weekend style
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Handle onTap for "My Workouts" container
                      },
                      child: Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                          color: Colors.transparent, // Transparent background color
                          border: Border.all(
                            color: Colors.red, // Color of the border
                            width: 3, // Thickness of the border
                          ),
                          borderRadius: BorderRadius.circular(20), // Rounded corners with a radius of 20
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.fitness_center, // You can use any icon you prefer
                                size: 48,
                                color: Colors.red, // Color of the icon
                              ),
                              Text(
                                "My Workouts",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,  MaterialPageRoute(
                          builder: (_) =>
                              BlocProvider(
                                create: (BuildContext context) => WorkoutsCubit(workoutsRepository),
                                child: WorkoutsScreen(value: "",),
                              ),
                        ),);
                      },
                      child: Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                          color: Colors.transparent, // Transparent background color
                          border: Border.all(
                            color: Colors.red, // Color of the border
                            width: 3, // Thickness of the border
                          ),
                          borderRadius: BorderRadius.circular(20), // Rounded corners with a radius of 20
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.directions_run, // You can use any icon you prefer
                                size: 48,
                                color: Colors.red, // Color of the icon
                              ),
                              Text(
                                "All Workouts",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Handle onTap for "My Workouts" container
                      },
                      child: Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                          color: Colors.transparent, // Transparent background color
                          border: Border.all(
                            color: Colors.red, // Color of the border
                            width: 3, // Thickness of the border
                          ),
                          borderRadius: BorderRadius.circular(20), // Rounded corners with a radius of 20
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.fitness_center, // You can use any icon you prefer
                                size: 48,
                                color: Colors.red, // Color of the icon
                              ),
                              Text(
                                "My Workouts",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkoutTipsPage(),
                ),
              );
            },
            child: Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                color: Colors.transparent, // Transparent background color
                border: Border.all(
                  color: Colors.red, // Color of the border
                  width: 3, // Thickness of the border
                ),
                borderRadius: BorderRadius.circular(20), // Rounded corners with a radius of 20
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lightbulb_outline, // You can use any icon you prefer
                      size: 48,
                      color: Colors.red, // Color of the icon
                    ),
                    Text(
                      "Tips",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
                  ],
                ),
              ],
            ),
          ),

        ),
      ],
    );
  }
}
