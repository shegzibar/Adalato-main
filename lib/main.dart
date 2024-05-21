import 'package:exercise_app/presentation/screens/signup_login/signup/gender_button.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup/height_picker.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup/level_picker.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup/weight_picker.dart';
import 'package:exercise_app/presentation/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCXGOo-siJZ25PjJKFAUdfiRqYUMZJlm3k", // your api key here
      appId: "1:209540537504:android:07549d6c8cca225d78fdc5", // your app id here
      messagingSenderId: "209540537504", // your messagingSenderId here
      projectId: "adalato-3c4bc", // your project id here
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HeightModel()),
        ChangeNotifierProvider(create: (context) => WeightModel()),
        ChangeNotifierProvider(create: (context) => GenderModel()),
        ChangeNotifierProvider(create: (context) => FitnessLevelModel()),
        ChangeNotifierProvider(create: (context) => LocaleProvider()), // Add LocaleProvider here
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: FirebaseAuth.instance.authStateChanges(), //Authservice().user,
      initialData: null,
      child: Builder(
        builder: (context) {
          return Consumer<LocaleProvider>(
            builder: (context, localeProvider, child) {
              return MaterialApp(
                locale: localeProvider.locale,
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
                  builder: (_, child) => Wrapper(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class LocaleProvider with ChangeNotifier {
  Locale _locale = Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!S.delegate.supportedLocales.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }
}
