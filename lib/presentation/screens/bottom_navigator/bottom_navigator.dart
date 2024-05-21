import 'package:exercise_app/generated/l10n.dart';
import 'package:exercise_app/presentation/screens/bottom_navigator/account_screen.dart';
import 'package:exercise_app/presentation/screens/bottom_navigator/home_screen.dart';
import 'package:exercise_app/presentation/screens/programs_screen.dart';
import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget {
  final String userId; // Add userId as a required parameter

  const BottomNavigator({super.key, required this.userId});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  late List<Widget> widgetList;

  @override
  void initState() {
    super.initState();
    widgetList = [
      ProgramsPage(userId: widget.userId),
      Home(userId: widget.userId),
      Account(),
    ];
  }
  int myhome = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: widgetList[myhome],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.red,
          unselectedItemColor: Colors.white,
          onTap: (value) {
            setState(() {
              myhome = value;
            });
          },
          currentIndex: myhome,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.explore),label: S.of(context).explore,),
            BottomNavigationBarItem(icon: Icon(Icons.home, ),label: S.of(context).home),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: S.of(context).account),

      ]

      ),
    );
  }
}
