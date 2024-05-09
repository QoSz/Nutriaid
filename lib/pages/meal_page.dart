import 'package:flutter/material.dart';
import 'package:nutriaid/pages/base_page.dart';

class MealPage extends StatefulWidget {
  const MealPage({super.key});

  @override
  State<MealPage> createState() => _MealPageState();
}

class _MealPageState extends State<MealPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
  final DateTime today = DateTime.now();
  String kcal = '1600';
  String protein = '120g';
  String carbs = '160g';
  String fat = '53g';
  Map<String, List<Map<String, String>>> weeklyMeals = {
    'MON': [
      {
        'mealType': 'Breakfast',
        'mealName': 'Peanut Butter Power Smoothie',
        'preparationTime': '5m',
        'imagePath': 'assets/images/milkshake.png'
      },
      {
        'mealType': 'Lunch',
        'mealName': 'Mexican Bean Soup With Guacamole',
        'preparationTime': '15m',
        'imagePath': 'assets/images/Mexican.png'
      },
      {
        'mealType': 'Dinner',
        'mealName': 'Chilli Prawn Spaghetti',
        'preparationTime': '30m',
        'imagePath': 'assets/images/chilli.png'
      },
    ],
    'TUE': [
      {
        'mealType': 'Breakfast',
        'mealName': 'French Toast Blueberry Banana',
        'preparationTime': '5m',
        'imagePath': 'assets/images/frenchtoast.jpg'
      },
      {
        'mealType': 'Lunch',
        'mealName': 'Salad With Grilled Chicken',
        'preparationTime': '5m',
        'imagePath': 'assets/images/salad.jpg'
      },
      {
        'mealType': 'Dinner',
        'mealName': 'Meal balls with tomato sauce',
        'preparationTime': '30m',
        'imagePath': 'assets/images/pasta.jpg'
      },
    ],
    'WED': [
      {
        'mealType': 'Breakfast',
        'mealName': 'Fried Egg on Toast with Guacamole',
        'preparationTime': '5m',
        'imagePath': 'assets/images/eggbread.jpg'
      },
      {
        'mealType': 'Lunch',
        'mealName': 'Sea Bass Grill Steak',
        'preparationTime': '15m',
        'imagePath': 'assets/images/sea.jpg'
      },
      {
        'mealType': 'Dinner',
        'mealName': 'Tenderloin Steak with Veggies',
        'preparationTime': '30m',
        'imagePath': 'assets/images/steak.jpg'
      },
    ],
    'THU': [
      {
        'mealType': 'Breakfast',
        'mealName': 'English Breakfast',
        'preparationTime': '5m',
        'imagePath': 'assets/images/ebs.jpg'
      },
      {
        'mealType': 'Lunch',
        'mealName': 'Pork Bean Burrito',
        'preparationTime': '5m',
        'imagePath': 'assets/images/burrito.jpeg'
      },
      {
        'mealType': 'Dinner',
        'mealName': 'Lasagna with Garlic Bread',
        'preparationTime': '30m',
        'imagePath': 'assets/images/laza.jpg'
      },
    ],
    'FRI': [
      {
        'mealType': 'Breakfast',
        'mealName': 'Breakfast Burrito',
        'preparationTime': '5m',
        'imagePath': 'assets/images/breakfastburrito.jpg'
      },
      {
        'mealType': 'Lunch',
        'mealName': 'Feta Salad with Pita Bread',
        'preparationTime': '15m',
        'imagePath': 'assets/images/sandwich.jpg'
      },
      {
        'mealType': 'Dinner',
        'mealName': 'Chilli Prawn Spaghetti',
        'preparationTime': '30m',
        'imagePath': 'assets/images/chilli.png'
      },
    ],
    'SAT': [
      {
        'mealType': 'Breakfast',
        'mealName': 'Pan Cake with Syrup',
        'preparationTime': '5m',
        'imagePath': 'assets/images/Pancakes.jpg'
      },
      {
        'mealType': 'Lunch',
        'mealName': 'Salad With Grilled Chicken',
        'preparationTime': '5m',
        'imagePath': 'assets/images/salad.jpg'
      },
      {
        'mealType': 'Dinner',
        'mealName': 'Meal balls with tomato sauce',
        'preparationTime': '30m',
        'imagePath': 'assets/images/pasta.jpg'
      },
    ],
    'SUN': [
      {
        'mealType': 'Breakfast',
        'mealName': 'Granloa with Berries and Yoghurt',
        'preparationTime': '5m',
        'imagePath': 'assets/images/granola.jpg'
      },
      {
        'mealType': 'Lunch',
        'mealName': 'Mexican Bean Soup With Guacamole',
        'preparationTime': '15m',
        'imagePath': 'assets/images/Mexican.png'
      },
      {
        'mealType': 'Dinner',
        'mealName': 'Chilli Prawn Spaghetti',
        'preparationTime': '30m',
        'imagePath': 'assets/images/chilli.png'
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _tabController.index = today.weekday - 1;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _editNutrition() async {
    TextEditingController kcalController = TextEditingController(text: kcal);
    TextEditingController proteinController =
        TextEditingController(text: protein);
    TextEditingController carbsController = TextEditingController(text: carbs);
    TextEditingController fatController = TextEditingController(text: fat);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Nutritional Values'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                  controller: kcalController,
                  decoration: const InputDecoration(labelText: 'KCAL')),
              TextField(
                  controller: proteinController,
                  decoration: const InputDecoration(labelText: 'Protein')),
              TextField(
                  controller: carbsController,
                  decoration: const InputDecoration(labelText: 'Carbs')),
              TextField(
                  controller: fatController,
                  decoration: const InputDecoration(labelText: 'Fat')),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  kcal = kcalController.text;
                  protein = proteinController.text;
                  carbs = carbsController.text;
                  fat = fatController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget nutritionCard() {
    return Card(
      margin: const EdgeInsets.all(12.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(
            color: Color.fromARGB(255, 230, 230, 230), width: 2.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  kcal,
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'KCAL',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  protein,
                  style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                const Text(
                  'PROTEIN',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  carbs,
                  style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple),
                ),
                const Text(
                  'CARBS',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  fat,
                  style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange),
                ),
                const Text(
                  'FAT',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
              ],
            ),
            IconButton(
                icon: const Icon(
                  Icons.edit,
                  size: 30,
                ),
                onPressed: () {
                  _editNutrition();
                }),
          ],
        ),
      ),
    );
  }

  Widget mealCard(String mealType, String mealName, String preparationTime,
      String imagePath) {
    return Card(
      margin: const EdgeInsets.all(12.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(
            color: Color.fromARGB(255, 230, 230, 230), width: 2.0),
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(20.0), // Increased padding for more spacing
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mealType.toUpperCase(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Color.fromARGB(255, 124, 124, 124)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    mealName,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.refresh), onPressed: () {}),
                      IconButton(
                          icon: const Icon(Icons.note_alt_outlined),
                          onPressed: () {}),
                      IconButton(
                          icon: const Icon(Icons.delete), onPressed: () {}),
                    ],
                  ),
                ],
              ),
            ),
            Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(imagePath, width: 85, height: 85),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(137, 89, 89, 89),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.access_time,
                            color: Colors.white, size: 15),
                        Text(preparationTime,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDayMeals(String day) {
    var mealsForDay = weeklyMeals[day] ?? [];
    return ListView(
      children: [
        const SizedBox(height: 12),
        nutritionCard(),
        ...mealsForDay.map((meal) => mealCard(meal['mealType']!,
            meal['mealName']!, meal['preparationTime']!, meal['imagePath']!)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Meal Plan",
      selectedIndex: 2,
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: List<Widget>.generate(7, (index) {
              return Tab(
                text: days[index] == days[today.weekday - 1]
                    ? 'TODAY'
                    : days[index],
              );
            }),
            labelColor: Colors.green,
            unselectedLabelColor: Colors.black,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: days.map((day) => buildDayMeals(day)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
