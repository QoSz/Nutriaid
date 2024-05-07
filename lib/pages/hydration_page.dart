import 'package:flutter/material.dart';
import 'package:nutriaid/pages/base_page.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:fl_chart/fl_chart.dart';

class HydrationPage extends StatefulWidget {
  const HydrationPage({super.key});

  @override
  State<HydrationPage> createState() => _HydrationPageState();
}

class _HydrationPageState extends State<HydrationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentIntake = 800;
  int waterIntakeGoal = 2400;
  final int idealIntake = 2800;
  List<Map<String, dynamic>> waterLogs = [];
  List<double> weekIntake = [1400, 1600, 1800, 1200, 1900, 2100, 800];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    waterLogs.add({"amount": 100, "time": "11:25 AM"});
    waterLogs.add({"amount": 500, "time": "08:45 AM"});
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Hydration Tracker',
      child: Column(
        children: [
          TabBar(
            // Increase the height of the TabBar
            labelPadding: const EdgeInsets.symmetric(vertical: 8),
            controller: _tabController,
            tabs: const [
              Tab(icon: Icon(Icons.water_drop, size: 40, color: Colors.blue)),
              Tab(icon: Icon(Icons.show_chart, size: 40, color: Colors.red)),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      waterIntakeCard(),
                      const SizedBox(height: 20),
                      progressCard(),
                      const SizedBox(height: 20),
                      waterLogCard(),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: AspectRatio(
                    aspectRatio:
                        1.0, // Adjust the aspect ratio to fit the graph appropriately on your screen
                    child: LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: false),
                        minY: 0, // Set minimum Y value
                        maxY: 5000, // Set maximum Y value
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize:
                                  22, // Adjust the size to fit the labels
                              interval:
                                  1, // Ensure labels are displayed at every index
                              getTitlesWidget: _getWeekDayTitles,
                            ),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: false), // Hide top titles
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval:
                                  1000, // Set interval for the y-axis labels
                              getTitlesWidget:
                                  _getLeftSideTitles, // Custom function to show water amounts
                            ),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(
                                showTitles:
                                    false), // Optionally hide right titles if needed
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            isCurved: true,
                            dotData: const FlDotData(show: true),
                            spots: List.generate(
                              weekIntake.length,
                              (index) =>
                                  FlSpot(index.toDouble(), weekIntake[index]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getWeekDayTitles(double value, TitleMeta meta) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    if (value % 1 == 0 && value >= 0 && value < days.length) {
      Widget text = Text(
        days[value.toInt()],
        style: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      );
      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 8.0, // Adjust spacing as necessary
        child: text,
      );
    }
    return const SizedBox
        .shrink(); // Returns an empty widget for non-valid indices
  }

  Widget _getLeftSideTitles(double value, TitleMeta meta) {
    return Text(
      "${value.toInt()} mL", // Ensure consistent formatting with "mL" right next to the number
      style: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );
  }

  Widget waterIntakeCard() {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(
            color: Color.fromARGB(255, 230, 230, 230), width: 2.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Ideal Water Intake Column
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.water_drop, size: 30, color: Colors.blue),
                    const SizedBox(height: 4),
                    Text("$idealIntake ml",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    const Text(
                      "Ideal Water Intake",
                      style: TextStyle(
                          fontSize: 18, color: Color.fromARGB(255, 94, 94, 94)),
                    ),
                  ],
                ),
                // Water Intake Goal Column
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.track_changes_outlined,
                        size: 30, color: Colors.green),
                    const SizedBox(height: 4),
                    Text("$waterIntakeGoal ml",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    const Text(
                      "Water Intake Goal",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 94, 94, 94),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Positioned Edit Icon on the right side of the Water Intake Goal
            Positioned(
              right: 9,
              top: 0,
              bottom: 0,
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.edit,
                      size: 28, color: Color.fromARGB(255, 142, 142, 142)),
                  onPressed: _showWaterGoalDialog,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget progressCard() {
    double completionPercent =
        (currentIntake / waterIntakeGoal).clamp(0.0, 1.0);
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(
            color: Color.fromARGB(255, 230, 230, 230), width: 2.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            CircularPercentIndicator(
              radius: 130.0,
              lineWidth: 15.0,
              circularStrokeCap: CircularStrokeCap.round,
              percent: completionPercent,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$currentIntake / $waterIntakeGoal ml",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "You have Completed ${(completionPercent * 100.0).toStringAsFixed(2)}%",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    "Daily Target",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(117, 117, 117, 1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              progressColor: Colors.blue,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                floatingActionButton("Reminder", Icons.alarm, Colors.teal),
                floatingActionButton(
                    "Custom Amount", Icons.add, Colors.deepPurple),
                floatingActionButton("+100ml", Icons.local_drink, Colors.cyan),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget floatingActionButton(String label, IconData icon, Color bgColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: () {
            if (label == 'Custom Amount') {
              showCustomEntryDialog();
            } else if (label == 'Reminder') {
              showReminderDialog();
            } else {
              addWater(100);
            }
          },
          // change the size of the FloatingActionButton
          backgroundColor: bgColor,
          mini: false,
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
              fontSize: 16, color: bgColor, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  void showReminderDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Set Reminder Interval"),
          content: const TextField(
            decoration: InputDecoration(hintText: "Enter minutes"),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Set reminder logic goes here
                Navigator.of(context).pop();
              },
              child: const Text("Set"),
            ),
          ],
        );
      },
    );
  }

  Widget waterLogCard() {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(
            color: Color.fromARGB(255, 230, 230, 230), width: 2.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Center(
              child: Text("Water Log",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue)),
            ),
            for (var log in waterLogs)
              ListTile(
                leading:
                    const Icon(Icons.local_drink, color: Colors.blue, size: 30),
                title: Text(
                  "${log['amount']} ml",
                  style: const TextStyle(fontSize: 18),
                ),
                trailing: Text(
                  log['time'],
                  style: const TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void showCustomEntryDialog() {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Water Intake"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Enter amount in ml"),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                int amount = int.tryParse(controller.text) ?? 0;
                if (amount > 0) {
                  addWater(amount);
                }
                Navigator.of(context).pop();
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void addWater(int amount) {
    setState(() {
      currentIntake += amount;
      waterLogs.insert(0, {
        "amount": amount,
        "time": DateTime.now().toString().substring(11, 16)
      });
    });
  }

  void _showWaterGoalDialog() {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Set Water Intake Goal"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "$waterIntakeGoal"),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                int? newGoal = int.tryParse(controller.text);
                if (newGoal != null) {
                  updateWaterGoal(newGoal);
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  void updateWaterGoal(int newGoal) {
    setState(() {
      waterIntakeGoal = newGoal;
    });
  }
}
