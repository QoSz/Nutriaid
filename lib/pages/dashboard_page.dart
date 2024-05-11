import 'package:flutter/material.dart';
import 'package:nutriaid/pages/base_page.dart';
import 'package:nutriaid/models/caloriemodel.dart';
import 'package:nutriaid/widgets/calorieoverviewcard.dart';
import 'package:nutriaid/models/hydration_model.dart';
import 'package:nutriaid/widgets/hydrationprogresscard.dart';
import 'package:nutriaid/widgets/macronutrientsoverviewcard.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Dashboard',
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text('Dashboard Overview',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            Consumer<CalorieModel>(
              builder: (context, model, child) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/calorie');
                  },
                  child: CaloriesOverviewCard(
                    totalCaloriesEaten: model.totalCaloriesEaten,
                    caloriesRemaining: model.caloriesRemaining,
                    caloriesBurned: model.caloriesBurned,
                  ),
                );
              },
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/nutrition');
              },
              child: const MacronutrientsOverviewCard(
                proteinConsumed: 55.4,
                carbsConsumed: 151.0,
                fatsConsumed: 60.2,
                proteinTarget: 74,
                carbsTarget: 302,
                fatsTarget: 71,
              ),
            ),
            Consumer<HydrationModel>(
              builder: (context, hydration, child) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/hydration');
                  },
                  child:
                      const HydrationProgressCard(), // Assuming this card handles its own data from the HydrationModel
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
