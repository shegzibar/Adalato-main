import 'package:exercise_app/presentation/screens/signup_login/signup/gender_button.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup/height_picker.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup/level_picker.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup/signup_info.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup/weight_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../signup_login_design/background_image.dart';
import '../signup_login_design/password_input.dart';
import '../signup_login_design/text_input.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  PageController _controller = PageController();
  int currentPageIndex = 0;
  final int totalPages = 5;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _controller.addListener(() {
      // Update the state with the new page index
      int nextPage = _controller.page!.round();
      if (nextPage != currentPageIndex) {
        setState(() {
          currentPageIndex = nextPage;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        PageView(
          controller: _controller,
          children:  <Widget>[

            GenderSelection(),
            HeightPicker(),
            WeightPicker(),
            LevelSelection(),
            register(),

          ],
        ),
        Container(
          alignment: const Alignment(0, 0.75),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Visibility(
                      visible: currentPageIndex > 0, // Show if not the first page
                      child: GestureDetector(
                        onTap:() {
                          _controller.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                          },
                        child: Text(
                          "Back",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    SmoothPageIndicator(effect: SlideEffect(activeDotColor:Colors.red),controller: _controller, count: 5),
                    Visibility(
                      visible: currentPageIndex < totalPages - 1, // Show if not the last page
                      child: GestureDetector(
                        onTap:() {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
