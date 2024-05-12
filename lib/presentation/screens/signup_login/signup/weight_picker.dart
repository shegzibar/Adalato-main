import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class WeightModel extends ChangeNotifier {
  int _selectedWeight = 50;  // Default selected weight in kilograms

  int get selectedWeight => _selectedWeight;

  set selectedWeight(int newWeight) {
    _selectedWeight = newWeight;
    notifyListeners();
  }
}


class WeightPicker extends StatefulWidget {
  const WeightPicker({Key? key}) : super(key: key);

  @override
  State<WeightPicker> createState() => _WeightPickerState();
}

class _WeightPickerState extends State<WeightPicker> {
  late FixedExtentScrollController _weightController;

  @override
  void initState() {
    super.initState();
    final initialWeight = Provider.of<WeightModel>(context, listen: false).selectedWeight;
    _weightController = FixedExtentScrollController(initialItem: initialWeight - 20);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Weight",
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
                    controller: _weightController,
                    itemExtent: 50,
                    perspective: 0.005,
                    diameterRatio: 1.2,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      final newWeight = 20 + index;
                      Provider.of<WeightModel>(context, listen: false).selectedWeight = newWeight;
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 131,  // Weight range from 20 kg to 150 kg
                      builder: (context, index) {
                        return Center(
                          child: Text(
                            '${20 + index}',
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
                const Text(
                  'kg',
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
    _weightController.dispose();
    super.dispose();
  }
}

// save button
/*
IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // Action to save or use the selected height
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Height Selected"),
                  content: Text("You have selected $selectedHeight cm."),
                  actions: <Widget>[
                    TextButton(
                      child: Text("OK"),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              );
            },
          ),
 */