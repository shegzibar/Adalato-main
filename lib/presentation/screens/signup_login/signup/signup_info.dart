import 'package:exercise_app/generated/l10n.dart';
import 'package:exercise_app/presentation/screens/signup_login/loading.dart';
import 'package:exercise_app/presentation/screens/signup_login/login/login_screen.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup/gender_button.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup/height_picker.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup/level_picker.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup/weight_picker.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup_login_design/background_image.dart';
import 'package:exercise_app/presentation/services/auth.dart';
import 'package:exercise_app/presentation/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


class register extends StatefulWidget {
  const register({super.key});


  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  bool _pass = true;
  String username = "";
  String email = "";
  String password = "";
  String check = "";
  Authservice _auth = Authservice();
  String error = "";


  @override
  Widget build(BuildContext context) {
    final height = Provider.of<HeightModel>(context).selectedHeight;
    final weight = Provider.of<WeightModel>(context).selectedWeight;
    final gender = Provider.of<GenderModel>(context).selectedGender;
    final level = Provider.of<FitnessLevelModel>(context).selectedLevel;
    return _loading ? loading() : Stack(
        children: <Widget>[
          BackgroundImage(),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50.h,
                      ),
                      Text(
                        S.of(context).signup,
                        style: TextStyle(
                          fontSize: 37.sp,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 25, 25, 0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[600]?.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: TextFormField(
                                  onChanged: (val) {
                                    setState(() {
                                      username = val;
                                    });
                                  },
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.sp,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 15.0),
                                    prefixIcon: Icon(
                                      size: 30.sp,
                                      Icons.person_outline_rounded,
                                      color: Colors.white,
                                    ),
                                    hintText: S.of(context).name_hint,
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                    ),
                                    labelText: S.of(context).name,
                                    labelStyle: TextStyle(
                                      fontSize: 25.sp,
                                      color: Colors.white,
                                    ),
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    filled: true,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return S.of(context).name_warning;
                                    } else
                                      return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 35.h,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[600]?.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: TextFormField(
                                  onChanged: (val) {
                                    setState(() {
                                      email = val;
                                    });
                                  },
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.sp,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 15.0),
                                    prefixIcon: Icon(
                                      size: 30.sp,
                                      Icons.alternate_email,
                                      color: Colors.white,
                                    ),
                                    hintText: S.of(context).email_hint,
                                    hintStyle: TextStyle(
                                      fontSize: 20.sp,
                                      letterSpacing: 1,
                                      color: Colors.white,
                                    ),
                                    labelText: S.of(context).email,
                                    labelStyle: TextStyle(
                                      fontSize: 25.sp,
                                      color: Colors.white,
                                    ),
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    filled: true,
                                  ),
                                  //----------Check isEmpty----------
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return S.of(context).email_warning;
                                    } else
                                      return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 35.h,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[600]?.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: TextFormField(
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.sp,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 15.0),
                                    hintText: S.of(context).password_hint,
                                    hintStyle: TextStyle(
                                      fontSize: 20.sp,
                                      letterSpacing: 1,
                                      color: Colors.white,
                                    ),
                                    alignLabelWithHint: true,
                                    labelText: S.of(context).password,
                                    labelStyle: TextStyle(
                                      fontSize: 25.sp,
                                      color: Colors.white,
                                    ),
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    filled: true,
                                    prefixIcon: Icon(
                                      size: 30.sp,
                                      Icons.lock_outline,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      check = val;
                                    });
                                  },
                                  //----------Check isEmpty----------
                                  obscureText: _pass,
                                  validator: (val) {
                                    if (val!.length < 8) {
                                      return S.of(context).password_warning;
                                    } else
                                      return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 35.h,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[600]?.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: TextFormField(
                                  onChanged: (val) {
                                    setState(() {
                                      password = val;
                                    });
                                  },
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.sp,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 15.0),
                                    hintText: S.of(context).reenter_password,
                                    hintStyle: TextStyle(
                                      fontSize: 20.sp,
                                      letterSpacing: 1,
                                      color: Colors.white,
                                    ),
                                    alignLabelWithHint: true,
                                    labelText: S.of(context).confirm_password,
                                    labelStyle: TextStyle(
                                      fontSize: 25.sp,
                                      color: Colors.white,
                                    ),
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    filled: true,
                                    //Display Password Button
                                    prefixIcon: Icon(
                                      size: 30.sp,
                                      Icons.lock_outline,
                                      color: Colors.white,
                                    ),
                                  ),
                                  //----------Check isEmpty----------
                                  obscureText: _pass,
                                  validator: (val) {
                                    if (val!.length < 6 || val != check) {
                                      return S.of(context).confirm_warning;
                                    } else
                                      return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 25.h),
                              Padding(
                                padding: EdgeInsets.only(left: 1),
                                child: SizedBox(
                                  width: 0.9.sw,
                                  height: 0.08.sh,
                                  child: ElevatedButton(
                                    child: Text(
                                      S.of(context).signup,
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20), // Rounded edges with a radius of 20
                                      ),
                                    ),
                                    //-------Save data and switch to the Next Page------
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() => _loading = true );
                                        dynamic result = await _auth
                                            .registerwithemailandpassword(
                                            email, password, username,"$height","$weight","$level","$gender");
                                        FirebaseAuth.instance
                                            .authStateChanges()
                                            .listen((User? user) {
                                          if (user == null) {
                                            print('User is currently signed out!');
                                          } else {
                                            Navigator.push(context,  MaterialPageRoute (
                                              builder: (BuildContext context) => const Wrapper(),
                                            ),);
                                          }
                                        });
                                        if (result == null) {
                                          setState(() {
                                            error =
                                            "please supply a valide email";

                                          });
                                        }
                                        if (result != null) {

                                          setState(() {
                                            _loading = false;
                                          });
                                          print(result);
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
    Padding(
      padding: const EdgeInsets.all(18),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            S.of(context).have_account,
      style: TextStyle(
      color: Colors.white,
      fontSize: 18,)
      ),
      GestureDetector(
      onTap: () {
      Navigator.push(context,
      MaterialPageRoute(builder: (context) => Login_page()));
      },
      child: Text(
      S.of(context).login,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18
          ),
      ),
      )
      ],
      ),
    ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
  }
}
