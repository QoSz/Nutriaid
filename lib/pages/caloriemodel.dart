import 'package:flutter/material.dart';

class MealLog {
  String mealType;
  int calories;
  DateTime timestamp;

  MealLog(this.mealType, this.calories, this.timestamp);
}

class CalorieModel with ChangeNotifier {
  final List<MealLog> _mealLogs = [];
  int _caloriesBurned = 244;
  late int _totalCaloriesEaten;
  int _caloriesRemaining = 2000;

  int breakfastCalories = 56;
  int lunchCalories = 856;
  int dinnerCalories = 379;
  int snackCalories = 0;

  int breakfastGoal = 635;
  int lunchGoal = 847;
  int dinnerGoal = 529;
  int snackGoal = 106;

  CalorieModel() {
    _totalCaloriesEaten =
        breakfastCalories + lunchCalories + dinnerCalories + snackCalories;
    _caloriesRemaining = 2000 - _totalCaloriesEaten;
  }

  List<MealLog> get mealLogs => List.unmodifiable(_mealLogs);
  int get caloriesBurned => _caloriesBurned;
  int get totalCaloriesEaten => _totalCaloriesEaten;
  int get caloriesRemaining => _caloriesRemaining;

  int getCalories(String mealType) {
    switch (mealType) {
      case 'Breakfast':
        return breakfastCalories;
      case 'Lunch':
        return lunchCalories;
      case 'Dinner':
        return dinnerCalories;
      case 'Snacks':
        return snackCalories;
      default:
        return 0;
    }
  }

  int getGoal(String mealType) {
    switch (mealType) {
      case 'Breakfast':
        return breakfastGoal;
      case 'Lunch':
        return lunchGoal;
      case 'Dinner':
        return dinnerGoal;
      case 'Snacks':
        return snackGoal;
      default:
        return 0;
    }
  }

  void addMealLog(String mealType, int calories) {
    _mealLogs.add(MealLog(mealType, calories, DateTime.now()));
    addCalories(mealType, calories);
    notifyListeners();
  }

  void addCalories(String mealType, int calories) {
    switch (mealType) {
      case 'Breakfast':
        breakfastCalories += calories;
        break;
      case 'Lunch':
        lunchCalories += calories;
        break;
      case 'Dinner':
        dinnerCalories += calories;
        break;
      case 'Snacks':
        snackCalories += calories;
        break;
    }
    _totalCaloriesEaten += calories;
    _caloriesRemaining -= calories;
    notifyListeners();
  }

  void burnCalories(int calories) {
    _caloriesBurned += calories;
    notifyListeners();
  }
}
