import 'package:exercise_app/generated/l10n.dart';
import 'package:exercise_app/presentation/screens/signup_login/login/login_screen.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'signup_login_design/background_image.dart';



class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: _controller,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Colors.black, Colors.black12],
                begin: Alignment.bottomCenter,
                end: Alignment.center,
              ).createShader(bounds),
              blendMode: BlendMode.darken,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/wallpaper1.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
                  ),
                ),
              ),
            ),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Colors.black, Colors.black12],
                begin: Alignment.bottomCenter,
                end: Alignment.center,
              ).createShader(bounds),
              blendMode: BlendMode.darken,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/wallpaper2.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
                  ),
                ),
              ),
            ),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Colors.black, Colors.black12],
                begin: Alignment.bottomCenter,
                end: Alignment.center,
              ).createShader(bounds),
              blendMode: BlendMode.darken,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/wallpaper3.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
                  ),
                ),
              ),
            ),
        ],
        ),
        Container(
          alignment: Alignment(0, 0.75),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  S.of(context).adlato,
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.all(28.0),
                child: SmoothPageIndicator(effect: SlideEffect(activeDotColor: Colors.red) ,controller: _controller, count: 3),
              ),*/
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 60,
                      width: 140,
                      margin: EdgeInsets.zero,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,MaterialPageRoute(builder: (context) => SignUpPage()),);
                          },
                          child: Text(
                              S.of(context).signup,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                          ),
                          style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.red),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                            ),
                            ),
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 140,
                      margin: EdgeInsets.zero,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,MaterialPageRoute(builder: (context) => Login_page()),);
                        },
                        child: Text(
                          S.of(context).login,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.red),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),

      ],
    );
  }
}