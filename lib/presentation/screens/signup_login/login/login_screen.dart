import 'package:exercise_app/presentation/screens/signup_login/loading.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup/signup_info.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup/signup_screen.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup_login_design/background_image.dart';
import 'package:exercise_app/presentation/services/auth.dart';
import 'package:exercise_app/presentation/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Login_page extends StatefulWidget {


  @override
  _Login_pageState createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  bool valuefirst = false;
  bool valuesecond = false;
  bool _Pass = true;
  String email = "";
  String password = "";
  String error = "";
  Authservice _auth = Authservice();

  @override
  Widget build(BuildContext context) {
    return _loading ? loading():  Stack(
      children:[
        BackgroundImage(),
        Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              Column(
                    children: [
                      SizedBox(
                        height: 100.h,
                      ),
                      Text(
                        'Login',
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
                            children: [
                              SizedBox(
                                height: 80.h,
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
                                    prefixIcon: Icon(
                                      size: 30.sp,
                                      Icons.person_outline_rounded,
                                      color: Colors.white,
                                    ),
                                    hintText: 'Enter your email',
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                    ),
                                    labelText: 'Email',
                                    labelStyle: TextStyle(
                                      fontSize: 25.sp,
                                      color: Colors.white,
                                    ),
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(),
                                    filled: true,
                                  ),
                                  onChanged: (val) {
                                    email = val;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "please type your email";
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
                                        vertical: 20.0, horizontal: 20.0,
                                    ),
                                    hintText: 'Enter password',
                                    hintStyle: TextStyle(
                                      fontSize: 20.sp,
                                      letterSpacing: 1,
                                      color: Colors.white,
                                    ),
                                    alignLabelWithHint: true,
                                    labelText: 'Password\n',
                                    labelStyle: TextStyle(
                                      fontSize: 25.sp,
                                      color: Colors.white,
                                    ),
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(),
                                    filled: true,

                                    //Display Password Button
                                    prefixIcon: Icon(
                                      size: 30.sp,
                                      Icons.lock_outline,
                                      color: Colors.white,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(_Pass
                                          ? Icons.remove_red_eye_outlined
                                          : Icons.visibility_off,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _Pass = !_Pass;
                                        });
                                      },
                                      iconSize: 30.sp,
                                    ),
                                  ),
                                  onChanged: (val) {
                                    password = val;
                                  },
                                  obscureText: _Pass,
                                  validator: (value) {
                                    if (value!.length < 8) {
                                      return "your password should be 8 digit long  ";
                                    } else
                                      return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 35.h,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // --------Save data option--------
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Forget password?  ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => register()));
                              },
                              child: const Text(
                                " Reset password",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                ),
                              ),
                            ),
                            //--------Reset Password option-------
                            /*TextButton(
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => forgetpass(),
                                //     ));
                              },
                              child: Text('Forgot Password?',
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    color: Colors.blue,
                                  )),
                            )*/
                          ]
                      ),

                      //Login Button
                      SizedBox(height: 30.h),
                      Padding(
                        padding: EdgeInsets.only(left: 1.sp),
                        child: SizedBox(
                          width: 0.9.sw,
                          height: 0.08.sh,
                          child: ElevatedButton(
                            child: Text(
                              ' Login ',
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
                            //-------Switch to Next Page 'Main'------
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => _loading = true);

                                dynamic result = await _auth
                                    .signinwithemailandpassword(email, password);
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
                                    "Something went wrong please try again ";
                                    _loading = false;
                                  });
                                }
                              }
                            },
                          ),
                        ),
                      ),

                      //New account option
                      SizedBox(height: 25.sp),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "\t Don't have account?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => SignUpPage()));
                            },
                            child: const Text(
                              " Create account",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]
                ),
              Text(
                error,
                style: TextStyle(color: Colors.red),
              ),
            ]),
          ),
        ),
        backgroundColor: Colors.transparent,
      ), ]
    );
  }
}
