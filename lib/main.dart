import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nutriaid/pages/caloriemodel.dart';
import 'package:nutriaid/pages/hydration_model.dart';
import 'package:nutriaid/pages/calorie_page.dart';
import 'package:nutriaid/pages/changepassword_page.dart';
import 'package:nutriaid/pages/community_page.dart';
import 'package:nutriaid/pages/dashboard_page.dart';
import 'package:nutriaid/pages/education_page.dart';
import 'package:nutriaid/pages/forgotpassword_page.dart';
import 'package:nutriaid/pages/hydration_page.dart';
import 'package:nutriaid/pages/login_page.dart';
import 'package:nutriaid/pages/meal_page.dart';
import 'package:nutriaid/pages/nutrition_page.dart';
import 'package:nutriaid/pages/profile_page.dart';
import 'package:nutriaid/pages/register_page.dart';
import 'package:nutriaid/pages/weight_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CalorieModel()),
        ChangeNotifierProvider(create: (context) => HydrationModel()),
        // Add other providers here as needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NutriAid',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login',
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
          '/community': (context) => const CommunityPage(),
          '/profile': (context) => const ProfilePage(),
          '/change-password': (context) => const ChangePasswordPage(),
          '/forgot-password': (context) => const ForgotPasswordPage(),
        },
      ),
    );
  }
}
