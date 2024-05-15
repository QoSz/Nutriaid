import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/hydration_model.dart';

class IdealAndTargetWaterCard extends StatelessWidget {
  const IdealAndTargetWaterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HydrationModel>(
      builder: (context, hydration, child) {
        return Card(
          margin: const EdgeInsets.all(8.0),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: const BorderSide(
                color: Color.fromARGB(255, 230, 230, 230), width: 2.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Ideal Water Intake',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      '${hydration.idealWaterIntake} ml',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Water Intake Goal',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.red),
                          onPressed: () => _showEditDialog(context, hydration),
                        ),
                      ],
                    ),
                    Text(
                      '${hydration.waterIntakeGoal} ml',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, HydrationModel hydration) {
    final TextEditingController controller = TextEditingController(
      text: hydration.waterIntakeGoal.toString(),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Water Intake Goal'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter new water intake goal',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final int newGoal =
                    int.tryParse(controller.text) ?? hydration.waterIntakeGoal;
                hydration.updateWaterGoal(newGoal);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
