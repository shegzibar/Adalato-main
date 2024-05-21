import 'package:exercise_app/presentation/screens/Excercises_view.dart';
import 'package:exercise_app/presentation/screens/favorite_workout_page.dart';
import 'package:exercise_app/presentation/screens/programlist_view.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup_login_design/background_image.dart';
import 'package:exercise_app/presentation/screens/workouts/tips.dart';
import 'package:flutter/material.dart';
import 'package:exercise_app/generated/l10n.dart';
import 'package:table_calendar/table_calendar.dart';

class Home extends StatefulWidget {
  final String userId; // Add userId as a required parameter

  const Home({super.key, required this.userId});


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
                        Navigator.push(context,  MaterialPageRoute(
                            builder: (_) => FavoriteWorkoutsPage(userId: widget.userId,),
                        ),
                        );
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
                                S.of(context).my_workouts,
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
                            builder: (_) => Programs(userId: widget.userId), // Pass userId here
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
                                Icons.directions_run, // You can use any icon you prefer
                                size: 48,
                                color: Colors.red, // Color of the icon
                              ),
                              Text(
                                S.of(context).programs,
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
                        Navigator.push(context, MaterialPageRoute(
                        builder: (_) => ExercisePage(),
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
                                Icons.e_mobiledata_outlined, // You can use any icon you prefer
                                size: 48,
                                color: Colors.red, // Color of the icon
                              ),
                              Text(
                                S.of(context).exercises,
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
              Navigator.push (
                context,
                MaterialPageRoute (
                  builder: (BuildContext context) => WorkoutTipsPage(),
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
                      S.of(context).tips,
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
