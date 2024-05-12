import 'package:exercise_app/generated/l10n.dart';
import 'package:exercise_app/presentation/screens/app_router.dart';
import 'package:exercise_app/presentation/screens/workouts/workouts_screen.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class Calendar extends StatelessWidget {
  final AppRouter appRouter;
  Calendar({super.key, required this.appRouter});

  List<Map<String, dynamic>> _journals = [];

  bool _isloading = true;

  //DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
