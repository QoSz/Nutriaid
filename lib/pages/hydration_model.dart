import 'package:flutter/material.dart';

class HydrationModel with ChangeNotifier {
  int _currentIntake = 800; // Default intake
  int _waterIntakeGoal = 2400; // Default goal

  // Getter for current intake
  int get currentIntake => _currentIntake;

  // Getter for water intake goal
  int get waterIntakeGoal => _waterIntakeGoal;

  // List to store water log entries
  final List<Map<String, dynamic>> _waterLogs = [
    {"amount": 100, "time": "11:25 AM"},
    {"amount": 500, "time": "08:45 AM"}
  ];

  // Getter for water logs
  List<Map<String, dynamic>> get waterLogs => List.unmodifiable(_waterLogs);

  // Method to add water intake
  void addWater(int amount) {
    _currentIntake += amount;
    _waterLogs.insert(0, {
      "amount": amount,
      "time": DateTime.now().toString().substring(11, 16)
    });
    notifyListeners(); // Notify listeners of change
  }

  // Method to update the water intake goal
  void updateWaterGoal(int newGoal) {
    _waterIntakeGoal = newGoal;
    notifyListeners(); // Notify listeners of change
  }

  // Method to reset the daily intake and clear the log
  void resetHydration() {
    _currentIntake = 0;
    _waterLogs.clear();
    notifyListeners(); // Notify listeners of change
  }
}
