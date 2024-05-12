import 'package:exercise_app/presentation/screens/bottom_navigator/bottom_navigator.dart';
import 'package:exercise_app/presentation/screens/bottom_navigator/home_screen.dart';
import 'package:exercise_app/presentation/screens/signup_login/intro_screen.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup/signup_info.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup/signup_screen.dart';
import 'package:exercise_app/presentation/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user == null) {
      return IntroPage();
    } else {
      print(user);
      return BottomNavigator();
    }
  }
}