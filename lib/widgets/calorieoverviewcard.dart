import 'package:flutter/material.dart';

class CaloriesOverviewCard extends StatelessWidget {
  final int totalCaloriesEaten;
  final int caloriesRemaining;
  final int caloriesBurned;

  const CaloriesOverviewCard({
    super.key,
    required this.totalCaloriesEaten,
    required this.caloriesRemaining,
    required this.caloriesBurned,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
              padding: EdgeInsets.only(bottom: 16.0),
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
                _calorieInfo('Eaten', totalCaloriesEaten.toString()),
                _progressIndicator(),
                _calorieInfo('Burned', caloriesBurned.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _calorieInfo(String title, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        Text(
          title,
          style: const TextStyle(
              fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _progressIndicator() {
    double progress = totalCaloriesEaten / 2000.0;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 150,
          width: 150,
          child: CircularProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            color: Colors.green,
            strokeWidth: 12,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              caloriesRemaining.toString(),
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Remaining',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 174, 174, 174)),
            ),
          ],
        ),
      ],
    );
  }
}
