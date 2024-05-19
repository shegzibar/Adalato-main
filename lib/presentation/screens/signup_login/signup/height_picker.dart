import 'package:exercise_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeightModel extends ChangeNotifier {
  int _selectedHeight = 150;  // Default selected height in centimeters

  int get selectedHeight => _selectedHeight;

  set selectedHeight(int newHeight) {
    _selectedHeight = newHeight;
    notifyListeners();
  }
}



class HeightPicker extends StatefulWidget {
  const HeightPicker({Key? key}) : super(key: key);

  @override
  State<HeightPicker> createState() => _HeightPickerState();
}

class _HeightPickerState extends State<HeightPicker> {
  late FixedExtentScrollController _heightController;

  @override
  void initState() {
    super.initState();
    final initialHeight = Provider.of<HeightModel>(context, listen: false).selectedHeight;
    _heightController = FixedExtentScrollController(initialItem: initialHeight - 100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).height,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 200,
                  child: ListWheelScrollView.useDelegate(
                    controller: _heightController,
                    itemExtent: 50,
                    perspective: 0.005,
                    diameterRatio: 1.2,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      final newHeight = 100 + index;
                      Provider.of<HeightModel>(context, listen: false).selectedHeight = newHeight;
                    },

                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 151,  // Height range from 100 cm to 250 cm
                      builder: (context, index) {
                        return Center(
                          child: Text(
                            '${100 + index}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  S.of(context).cm,
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _heightController.dispose();
    super.dispose();
  }

}
