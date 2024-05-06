import 'package:flutter/material.dart';
import 'package:nutriaid/pages/base_page.dart';
import 'package:intl/intl.dart';

class MealLog {
  String mealType;
  int calories;
  DateTime timestamp;

  MealLog(this.mealType, this.calories, this.timestamp);
}

class CaloriePage extends StatefulWidget {
  const CaloriePage({super.key});

  @override
  State<CaloriePage> createState() => _CaloriePageState();
}

class _CaloriePageState extends State<CaloriePage> {
  // Fetch these from a database or API
  int caloriesBurned = 244;
  int breakfastCalories = 56;
  int breakfastGoal = 635;
  int lunchCalories = 856;
  int lunchGoal = 847;
  int dinnerCalories = 379;
  int dinnerGoal = 529;
  int snackCalories = 0;
  int snackGoal = 106;
  List<MealLog> mealLogs = [];
  DateTime selectedDate = DateTime.now();

  late int totalCaloriesEaten; // Total calories eaten
  late int caloriesRemaining; // Calories remaining in the day

  @override
  void initState() {
    super.initState();
    totalCaloriesEaten =
        breakfastCalories + lunchCalories + dinnerCalories + snackCalories;
    caloriesRemaining = 2000 - totalCaloriesEaten;
  }

  void addCalories(String mealType, int calories) {
    setState(() {
      final now = DateTime.now();
      mealLogs.add(MealLog(mealType, calories, now));

      totalCaloriesEaten += calories;
      caloriesRemaining -= calories;
      if (mealType == 'Breakfast') {
        breakfastCalories += calories;
      } else if (mealType == 'Lunch') {
        lunchCalories += calories;
      } else if (mealType == 'Dinner') {
        dinnerCalories += calories;
      } else if (mealType == 'Snacks') {
        snackCalories += calories;
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer to the current selected date
      firstDate: DateTime(2000), // Earliest allowable date
      lastDate: DateTime(2100), // Latest allowable date
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
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
                  const Text(
                    'Today',
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.w600),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.calendar_month_rounded,
                          color: Color.fromARGB(255, 209, 57, 57),
                          size: 45,
                        ),
                        onPressed: () {
                          _selectDate(context);
                        },
                      ),
                      const Text(
                        'Calendar', // Adding label text
                        style: TextStyle(
                          fontSize: 16, // Adjust the font size as needed
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: const BorderSide(
                  color: Color.fromARGB(255, 230, 230, 230),
                  width: 2.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                          bottom:
                              16.0), // Spacing between the title and the content
                      child: Text(
                        "Calories Overview",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 56, 165, 25),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '$totalCaloriesEaten',
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                            const Text(
                              'Eaten',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                height: 150,
                                width: 150,
                                child: CircularProgressIndicator(
                                  value: totalCaloriesEaten / 2000.0,
                                  backgroundColor: Colors.grey[300],
                                  color: Colors.green,
                                  strokeWidth: 12,
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '$caloriesRemaining',
                                    style: const TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    'Remaining',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            Color.fromARGB(255, 174, 174, 174)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '$caloriesBurned',
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                            const Text(
                              'Burned',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: const BorderSide(
                  color: Color.fromARGB(255, 230, 230, 230),
                  width: 2.0,
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Column(
                  children: [
                    _mealRow(context, 'Breakfast', breakfastCalories,
                        breakfastGoal, Icons.breakfast_dining, Colors.orange),
                    _mealRow(context, 'Lunch', lunchCalories, lunchGoal,
                        Icons.lunch_dining, Colors.blue),
                    _mealRow(context, 'Dinner', dinnerCalories, dinnerGoal,
                        Icons.dinner_dining, Colors.red),
                    _mealRow(context, 'Snacks', snackCalories, snackGoal,
                        Icons.cookie, Colors.green),
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: const BorderSide(
                  color: Color.fromARGB(255, 230, 230, 230),
                  width: 2.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text("Meal Logs",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: mealLogs.length,
                      itemBuilder: (context, index) {
                        final log = mealLogs[index];
                        return ListTile(
                          title: Text(
                            "${log.mealType}: ${log.calories} kcals",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                          trailing: Text(
                            DateFormat('hh:mm a').format(log.timestamp),
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mealRow(BuildContext context, String mealName, int eaten, int total,
      IconData icon, Color iconColor) {
    double progress = eaten / total;
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
            icon: Icon(Icons.add_circle_outline, size: 30, color: iconColor),
            onPressed: () => _showAddCaloriesDialog(context, mealName),
          ),
        ],
      ),
    );
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
            decoration: const InputDecoration(
              labelText: "Calories",
              hintText: "Enter calories",
            ),
            keyboardType: TextInputType.number,
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
                addCalories(mealType, calories);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
