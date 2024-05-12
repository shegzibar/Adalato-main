import 'package:exercise_app/generated/l10n.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup_login_design/background_image.dart';
import 'package:exercise_app/presentation/services/auth.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  Authservice _auth = Authservice();
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
              S.of(context).account,
              style: TextStyle(
                fontSize: 25,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),

body: ElevatedButton(
  onPressed: (){
        _auth.signout();
  },
  child: Text("Sign out"),
),
        ),
      ],
    );
  }
}
