import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Create a ChangeNotifier class to manage the selected gender state
class GenderModel extends ChangeNotifier {
  String? _selectedGender;

  String? get selectedGender => _selectedGender;

  void setSelectedGender(String? gender) {
    _selectedGender = gender;
    notifyListeners();
  }
}

class GenderSelection extends StatelessWidget {
  const GenderSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Gender",
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
        Consumer<GenderModel>(
          builder: (context, genderModel, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                genderButton(
                  gender: 'Male',
                  icon: Icons.male,
                  selected: genderModel.selectedGender == 'Male',
                  onPressed: () {
                    genderModel.setSelectedGender('Male');
                  },
                ),
                genderButton(
                  gender: 'Female',
                  icon: Icons.female,
                  selected: genderModel.selectedGender == 'Female',
                  onPressed: () {
                    genderModel.setSelectedGender('Female');
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget genderButton(
      {required String gender,
        required IconData icon,
        required bool selected,
        required VoidCallback onPressed}) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 25, vertical: 18)),
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
        onPressed: onPressed,
        child: Container(
          width: 90.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                icon,
                size: 60,
                color: Colors.white,
              ),
              Text(
                gender,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
