import 'package:flutter/material.dart';
import 'package:nutriaid/pages/calorie_page.dart';
import 'package:nutriaid/pages/dashboard_page.dart';
import 'package:nutriaid/pages/education_page.dart';
import 'package:nutriaid/pages/hydration_page.dart';
import 'package:nutriaid/pages/login_page.dart';
import 'package:nutriaid/pages/meal_page.dart';
import 'package:nutriaid/pages/nutrition_page.dart';
import 'package:nutriaid/pages/register_page.dart';
import 'package:nutriaid/pages/weight_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NutriAid',
      home: const LoginPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/calorie': (context) => const CaloriePage(),
        '/nutrition': (context) => const NutritionPage(),
        '/hydration': (context) => const HydrationPage(),
        '/weight': (context) => const WeightPage(),
        '/meal': (context) => const MealPage(),
        '/education': (context) => const EducationPage(),
      },
    );
  }
}
