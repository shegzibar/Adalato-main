import 'package:exercise_app/presentation/screens/bottom_navigator/bottom_navigator.dart';
import 'package:exercise_app/presentation/screens/bottom_navigator/home_screen.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup_login_design/text_form.dart';
import 'package:flutter/material.dart';



class Buttonlog extends StatelessWidget {
  const Buttonlog({
    Key? key,
    required this.buttonText,
  }) : super(key: key);

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextButton(
        onPressed: () {  Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BottomNavigator()));},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            buttonText,
            style: kBodyText,
          ),
        ),
      ),
    );
  }
}