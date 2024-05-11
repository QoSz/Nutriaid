import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutriaid/pages/base_page.dart';
import 'package:nutriaid/models/caloriemodel.dart';
import 'package:nutriaid/widgets/calorieoverviewcard.dart';
import 'package:provider/provider.dart';

class CaloriePage extends StatefulWidget {
  const CaloriePage({super.key});

  @override
  State<CaloriePage> createState() => _CaloriePageState();
}

class _CaloriePageState extends State<CaloriePage> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _showAddCaloriesDialog(BuildContext context, String mealType) {
    TextEditingController caloriesController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Calories to $mealType"),
          content: TextField(
            controller: caloriesController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Calories",
              hintText: "Enter calories",
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("Add"),
              onPressed: () {
                int calories = int.tryParse(caloriesController.text) ?? 0;
                Provider.of<CalorieModel>(context, listen: false)
                    .addMealLog(mealType, calories);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _mealRow(
      BuildContext context, String mealName, IconData icon, Color iconColor) {
    return Consumer<CalorieModel>(
      builder: (context, model, child) {
        int eaten = model.getCalories(mealName);
        int total = model.getGoal(mealName);
        double progress = total != 0 ? eaten / total : 0;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey[300],
                            color: iconColor,
                            strokeWidth: 5,
                          ),
                          Icon(icon, color: iconColor, size: 24),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(mealName,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        Text('$eaten / $total kcals',
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon:
                    Icon(Icons.add_circle_outline, size: 30, color: iconColor),
                onPressed: () => _showAddCaloriesDialog(context, mealName),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Calorie Tracker',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Today',
                      style:
                          TextStyle(fontSize: 45, fontWeight: FontWeight.w600)),
                  IconButton(
                    icon: const Icon(Icons.calendar_month_rounded,
                        size: 45, color: Color.fromARGB(255, 209, 57, 57)),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
            ),
            Consumer<CalorieModel>(
              builder: (context, model, child) {
                return CaloriesOverviewCard(
                  totalCaloriesEaten: model.totalCaloriesEaten,
                  caloriesRemaining: model.caloriesRemaining,
                  caloriesBurned: model.caloriesBurned,
                );
              },
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: const BorderSide(
                    color: Color.fromARGB(255, 230, 230, 230), width: 2.0),
              ),
              child: Column(
                children: [
                  _mealRow(context, 'Breakfast', Icons.breakfast_dining,
                      Colors.orange),
                  _mealRow(context, 'Lunch', Icons.lunch_dining, Colors.blue),
                  _mealRow(context, 'Dinner', Icons.dinner_dining, Colors.red),
                  _mealRow(context, 'Snacks', Icons.cookie, Colors.green),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: const BorderSide(
                    color: Color.fromARGB(255, 230, 230, 230), width: 2.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Consumer<CalorieModel>(
                  builder: (context, model, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: model.mealLogs.length,
                      itemBuilder: (context, index) {
                        final log = model.mealLogs[index];
                        return ListTile(
                          title: Text("${log.mealType}: ${log.calories} kcals"),
                          trailing: Text(
                            DateFormat('hh:mm a').format(log.timestamp),
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
