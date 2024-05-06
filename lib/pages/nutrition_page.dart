import 'package:flutter/material.dart';
import 'package:nutriaid/pages/base_page.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  double proteinConsumed = 55.4;
  double carbsConsumed = 151.0;
  double fatsConsumed = 60.2;

  double proteinTarget = 74;
  double carbsTarget = 302;
  double fatsTarget = 71;

  double proteinPercent = 0;
  double carbsPercent = 0;
  double fatsPercent = 0;

  // Updated micronutrients map with colors
  Map<String, List<double>> micronutrients = {
    'Fiber': [14.2, 38],
    'Sugar': [53.2, 110],
    'Cholesterol': [123.2, 300],
    'Potassium': [1200, 3500],
    'Calcium': [500, 1000],
    'Iron': [18, 45],
    'Vitamin C': [90, 200],
    'Zinc': [8, 11],
    'Vitamin B12': [500, 900],
  };

  // Color mapping for each micronutrient
  Map<String, Color> micronutrientColors = {
    'Fiber': Colors.red,
    'Sugar': Colors.orange,
    'Cholesterol': Colors.yellow,
    'Potassium': Colors.green,
    'Calcium': Colors.blue,
    'Iron': Colors.purple,
    'Vitamin C': Colors.pink,
    'Zinc': Colors.teal,
    'Vitamin B12': Colors.indigo,
  };

  @override
  void initState() {
    super.initState();
    // Initialize percentages based on initial values immediately
    proteinPercent = (proteinConsumed / proteinTarget).clamp(0.0, 1.0);
    carbsPercent = (carbsConsumed / carbsTarget).clamp(0.0, 1.0);
    fatsPercent = (fatsConsumed / fatsTarget).clamp(0.0, 1.0);
  }

  void _trackMealDialog() {
    TextEditingController mealController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Enter your meal"),
          content: TextField(
            controller: mealController,
            decoration:
                const InputDecoration(hintText: "What did you eat today?"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                fetchMealData(mealController.text);
                Navigator.of(context).pop();
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchMealData(String meal) async {
    var url = Uri.parse(
        'https://api.spoonacular.com/recipes/complexSearch?query=$meal&addRecipeNutrition=true&apiKey=991a50f261404b3ea371dbda92cc7c14');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      updateNutrients(data);
    } else {
      // Handle errors here
    }
  }

  void updateNutrients(dynamic data) {
    setState(() {
      var nutrients = data['results'][0]['nutrition']['nutrients'];
      double newProtein = getValueFromNutrientList(nutrients, "Protein");
      double newCarbs = getValueFromNutrientList(nutrients, "Carbohydrates");
      double newFats = getValueFromNutrientList(nutrients, "Fat");

      // Log the new values for debugging

      proteinConsumed += newProtein;
      carbsConsumed += newCarbs;
      fatsConsumed += newFats;

      // Recalculate the percentages for the indicators
      proteinPercent = (proteinConsumed / proteinTarget).clamp(0.0, 1.0);
      carbsPercent = (carbsConsumed / carbsTarget).clamp(0.0, 1.0);
      fatsPercent = (fatsConsumed / fatsTarget).clamp(0.0, 1.0);

      // Log the percentage updates for debugging
    });
  }

  double getValueFromNutrientList(List nutrients, String name) {
    // Handle the possibility that the nutrient may not be present in the list
    var nutrient = nutrients.firstWhere(
        (nut) => nut['name'].toString().contains(name),
        orElse: () => {'amount': 0.0});
    return nutrient['amount'] ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Nutrition Tracker',
      selectedIndex: 1,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Today',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),
                  ElevatedButton(
                    onPressed: _trackMealDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      // add a border radius of 16.0 to the button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Track Meal +',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            _buildNutrientCard(),
            _buildMicronutrientCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientCard() {
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

  Widget _buildMicronutrientCard() {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Micronutrients',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 16),
            ...micronutrients.entries.map(
              (entry) => _buildMicronutrientProgress(entry.key, entry.value[0],
                  entry.value[1], micronutrientColors[entry.key]!),
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
          percent: percent, // Use the calculated percentage
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

  Widget _buildMicronutrientProgress(
      String name, double consumed, double target, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$name: $consumed / $target g',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: consumed / target,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 12,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
