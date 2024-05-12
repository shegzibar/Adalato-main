import 'package:exercise_app/presentation/screens/app_router.dart';
import 'package:exercise_app/presentation/screens/bottom_navigator/bottom_navigator.dart';
import 'package:exercise_app/presentation/screens/signup_login/intro_screen.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup/gender_button.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup/height_picker.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup/level_picker.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup/weight_picker.dart';
import 'package:exercise_app/presentation/screens/workouts/workouts_screen.dart';
import 'package:exercise_app/presentation/services/auth.dart';
import 'package:exercise_app/presentation/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'generated/l10n.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey:
    "AIzaSyCXGOo-siJZ25PjJKFAUdfiRqYUMZJlm3k", // paste your api key here
    appId:
    "1:209540537504:android:07549d6c8cca225d78fdc5", //paste your app id here
    messagingSenderId: "209540537504", //paste your messagingSenderId here
    projectId: "adalato-3c4bc", //paste your project id here
  ),
);
  runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => HeightModel()),
      ChangeNotifierProvider(create: (context) => WeightModel()),
      ChangeNotifierProvider(create: (context) => GenderModel()),
      ChangeNotifierProvider(create: (context) => FitnessLevelModel()),
    ],
    child: MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {

  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
 User user ;
    return StreamProvider<User?>.value(
      value: Authservice().user,
      initialData:  null,
      // builder: (context, snapshot) {
       child :MaterialApp(
              locale: Locale("en"),
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              debugShowCheckedModeBanner: false,
              title: 'Flutter Workout App',
              home: ScreenUtilInit(
        designSize: Size(360, 690),
        builder: (_ , child) => Wrapper(),
        )
        ),

    );
}
  }

