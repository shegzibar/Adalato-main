import 'package:exercise_app/presentation/screens/bottom_navigator/bottom_navigator.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup/gender_button.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup/height_picker.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup/level_picker.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup/signup_info.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup/weight_picker.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup_login_design/text_form.dart';
import 'package:exercise_app/presentation/services/auth.dart';
import 'package:flutter/material.dart';

class Buttonsign extends StatefulWidget {
  const Buttonsign({
    Key? key,
    required this.buttonText,
    required this.name,
    required this.email,
    required this.pass,
  }) : super(key: key);

  final String buttonText;
  final String name;
  final String email;
  final String pass;

  @override
  State<Buttonsign> createState() => _ButtonsignState();
}

class _ButtonsignState extends State<Buttonsign> {
  late Authservice _auth;

  @override
  Widget build(BuildContext context) {
    String? weight = WeightModel().selectedWeight?.toString(); // Convert to string
    String? height = HeightModel().selectedHeight?.toString(); // Convert to string
    //String gender = GenderModel().selectedGender as String;
    String? level = FitnessLevelModel().selectedLevel?.toString(); // Convert to string

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextButton(

        onPressed: () async {
          print(widget.email);
          print(widget.pass);
          print(widget.name);
          print(height);
          print(weight);
          print(level);
          // dynamic result = await _auth.registerwithemailandpassword(
          //     widget.email, widget.pass, widget.name, height!, weight!, level!);
          //
          // if (result == null) {
          //   setState(() {});
          // }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            widget.buttonText,
            style: kBodyText,
          ),
        ),
      ),
    );
  }
}
