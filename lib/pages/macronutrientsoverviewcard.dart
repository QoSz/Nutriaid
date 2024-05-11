import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MacronutrientsOverviewCard extends StatelessWidget {
  final double proteinConsumed;
  final double carbsConsumed;
  final double fatsConsumed;
  final double proteinTarget;
  final double carbsTarget;
  final double fatsTarget;

  const MacronutrientsOverviewCard({
    super.key,
    required this.proteinConsumed,
    required this.carbsConsumed,
    required this.fatsConsumed,
    required this.proteinTarget,
    required this.carbsTarget,
    required this.fatsTarget,
  });

  @override
  Widget build(BuildContext context) {
    double proteinPercent = (proteinConsumed / proteinTarget).clamp(0.0, 1.0);
    double carbsPercent = (carbsConsumed / carbsTarget).clamp(0.0, 1.0);
    double fatsPercent = (fatsConsumed / fatsTarget).clamp(0.0, 1.0);

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
            const Text(
              'Macronutrients',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNutrientIndicator(proteinConsumed, proteinTarget,
                    'Protein', Colors.purple, proteinPercent),
                _buildNutrientIndicator(carbsConsumed, carbsTarget,
                    'Carbohydrates', Colors.orange, carbsPercent),
                _buildNutrientIndicator(
                    fatsConsumed, fatsTarget, 'Fats', Colors.red, fatsPercent),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientIndicator(double consumed, double target,
      String nutrient, Color color, double percent) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 55.0,
          lineWidth: 10.0,
          percent: percent,
          center: Text(
            '${consumed.toStringAsFixed(1)} g',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          progressColor: color,
          backgroundColor: Colors.grey.shade300,
          circularStrokeCap: CircularStrokeCap.round,
        ),
        const SizedBox(height: 10),
        Text(nutrient,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        Text('Target: ${target.toInt()}g',
            style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
