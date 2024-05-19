import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'gender_button.dart';
import 'height_picker.dart';
import 'level_picker.dart';
import 'signup_info.dart';
import 'weight_picker.dart';
import '../signup_login_design/background_image.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GenderModel()),
        ChangeNotifierProvider(create: (_) => HeightModel()),
        ChangeNotifierProvider(create: (_) => FitnessLevelModel()),
      ],
      child: SignUpPageContent(),
    );
  }
}

class SignUpPageContent extends StatefulWidget {
  @override
  _SignUpPageContentState createState() => _SignUpPageContentState();
}

class _SignUpPageContentState extends State<SignUpPageContent> {
  PageController _controller = PageController();
  int currentPageIndex = 0;
  final int totalPages = 5;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _controller.addListener(() {
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
          children: <Widget>[
            GenderSelection(),
            HeightPicker(),
            WeightPicker(),
            LevelSelection(),
            register(),
          ],
        ),
        if (currentPageIndex < totalPages - 1)
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
                          onTap: () {
                            _controller.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                      SmoothPageIndicator(
                        effect: SlideEffect(activeDotColor: Colors.red),
                        controller: _controller,
                        count: totalPages,
                      ),
                      Visibility(
                        visible: currentPageIndex < totalPages - 1, // Show if not the last page
                        child: Consumer3<GenderModel, HeightModel, FitnessLevelModel>(
                          builder: (context, genderModel, heightModel, fitnessLevelModel, child) {
                            return GestureDetector(
                              onTap: () {
                                if (currentPageIndex == 0 && genderModel.selectedGender == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Please select a gender to proceed.')),
                                  );
                                } else if (currentPageIndex == 1 && heightModel.selectedHeight == 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Please select a height to proceed.')),
                                  );
                                } else if (currentPageIndex == 3 && fitnessLevelModel.selectedLevel == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Please select a fitness level to proceed.')),
                                  );
                                } else {
                                  _controller.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeIn,
                                  );
                                }
                              },
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 40,
                              ),
                            );
                          },
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
