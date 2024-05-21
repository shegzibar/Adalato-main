import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:exercise_app/presentation/screens/signup_login/intro_screen.dart';
import 'package:exercise_app/presentation/screens/bottom_navigator/bottom_navigator.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user == null) {
      // If there is no user, return to intro/login page
      return IntroPage();
    } else {
      // Make sure user ID is never null here
      if (user.uid == null) {
        // Ideally, this case should never happen if `user` is not null
        return const Text("User ID is unavailable.");
      }
      // Proceed to BottomNavigator with a guaranteed non-null userId
      return BottomNavigator(userId: user.uid);
    }
  }
}
