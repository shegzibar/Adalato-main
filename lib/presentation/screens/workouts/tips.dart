import 'dart:async';
import 'package:flutter/material.dart';

class WorkoutTipsPage extends StatefulWidget {
  @override
  _WorkoutTipsPageState createState() => _WorkoutTipsPageState();
}

class _WorkoutTipsPageState extends State<WorkoutTipsPage> {
  int _currentTipIndex = 0;
  Timer? _timer;
  final List<String> _workoutTips = [
    'Always warm up before starting your workout.',
    'Stay hydrated throughout your exercises.',
    'Focus on your form to prevent injuries.',
    'Incorporate both cardio and strength training into your routine.',
    'Gradually increase the intensity of your workouts.',
    'Take time to cool down after exercising.',
    'Ensure you are getting enough protein in your diet.',
    'Set realistic goals and track your progress.',
    'Listen to your body and rest when needed.',
    'Stay consistent with your workout schedule.',
  ];

  @override
  void initState() {
    super.initState();
    _startRotatingTips();
  }

  void _startRotatingTips() {
    _timer = Timer.periodic(Duration(seconds: 20), (Timer timer) {
      setState(() {
        _currentTipIndex = (_currentTipIndex + 1) % _workoutTips.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            foregroundColor: Colors.red,
            backgroundColor: Colors.transparent,
            title: Text(
                'Workout Tips',
              style: TextStyle(
                fontSize: 25,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Center(
            child: Text(
              _workoutTips[_currentTipIndex],
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}