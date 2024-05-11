import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'hydration_model.dart'; // Ensure this matches the correct import path for your project

class HydrationProgressCard extends StatelessWidget {
  const HydrationProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HydrationModel>(
      builder: (context, hydration, child) {
        double completionPercent =
            hydration.currentIntake / hydration.waterIntakeGoal;

        return Card(
          margin: const EdgeInsets.all(8.0),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: const BorderSide(
                color: Color.fromARGB(255, 230, 230, 230), width: 2.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          "Hydration Progress",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh,
                            color: Color.fromARGB(255, 209, 60, 60)),
                        onPressed: () => hydration.resetHydration(),
                      ),
                    ],
                  ),
                ),
                CircularPercentIndicator(
                  radius: 130.0,
                  lineWidth: 15.0,
                  circularStrokeCap: CircularStrokeCap.round,
                  percent: completionPercent.clamp(0.0, 1.0),
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${hydration.currentIntake} / ${hydration.waterIntakeGoal} ml",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "You have Completed ${(completionPercent * 100).toStringAsFixed(2)}%",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w600),
                      ),
                      const Text(
                        "Daily Target",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(117, 117, 117, 1),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  progressColor: Colors.blue,
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                        context,
                        () => showReminderDialog(context),
                        Colors.teal,
                        "Reminder",
                        Icons.alarm),
                    _buildActionButton(
                        context,
                        () => showCustomEntryDialog(context),
                        Colors.deepPurple,
                        "Custom Amount",
                        Icons.edit),
                    _buildActionButton(context, () {
                      hydration.addWater(100);
                    }, Colors.cyan, "+100ml", Icons.local_drink),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showReminderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Set Reminder Interval"),
          content: const TextField(
            decoration: InputDecoration(hintText: "Enter minutes"),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Reminder logic implementation placeholder
                Navigator.of(context).pop();
              },
              child: const Text("Set"),
            ),
          ],
        );
      },
    );
  }

  void showCustomEntryDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Water Intake"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Enter amount in ml"),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                int amount = int.tryParse(controller.text) ?? 0;
                if (amount > 0) {
                  Provider.of<HydrationModel>(context, listen: false)
                      .addWater(amount);
                }
                Navigator.of(context).pop();
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildActionButton(BuildContext context, Function onPressed,
      Color bgColor, String label, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: onPressed as void Function()?,
          backgroundColor: bgColor,
          heroTag: "btn$label", // Ensures unique hero tags
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(label,
            style: TextStyle(
                fontSize: 16, color: bgColor, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
