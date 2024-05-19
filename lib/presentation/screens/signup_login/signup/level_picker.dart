import 'package:exercise_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Create a ChangeNotifier class to manage the selected fitness level state
class FitnessLevelModel extends ChangeNotifier {
  String? _selectedLevel;

  String? get selectedLevel => _selectedLevel;

  void setSelectedLevel(String? level) {
    _selectedLevel = level;
    notifyListeners();
  }
}

class LevelSelection extends StatelessWidget {
  const LevelSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.of(context).fitnesslevel,
          style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            levelButton(
              level: S.of(context).beginner,
            ),
            levelButton(
              level: S.of(context).intermediate,
            ),
            levelButton(
              level: S.of(context).advanced,
            ),
          ],
        ),
      ],
    );
  }

  Widget levelButton({required String level}) {
    return Consumer<FitnessLevelModel>(
      builder: (context, fitnessLevelModel, child) {
        bool selected = fitnessLevelModel.selectedLevel == level;
        return Container(
          padding: const EdgeInsets.all(10),
          child: TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 90, vertical: 18)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(
                    width: 5,
                    color: selected ? Colors.red : Colors.white,
                  ),
                ),
              ),
            ),
            onPressed: () {
              fitnessLevelModel.setSelectedLevel(selected ? null : level);
            },
            child: SizedBox(
              height: 100,
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    level,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
