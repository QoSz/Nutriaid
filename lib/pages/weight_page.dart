import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutriaid/pages/base_page.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:fl_chart/fl_chart.dart';

class WeightPage extends StatefulWidget {
  const WeightPage({super.key});
  static const spacingBox = SizedBox(height: 10);
  static const dividerLineColor = Color.fromARGB(255, 189, 189, 189);

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _dateController = TextEditingController();
  double? currentWeight;
  double? targetWeight;
  double startWeight = 80; // Default start weight
  DateTime? targetDate;
  DateTime startDate = DateTime.now();
  double height = 170; // Default height in cm for BMI calculation

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Weight/BMI Tracker',
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(
                  icon:
                      Icon(Icons.monitor_weight, color: Colors.amber, size: 30),
                  text: 'Tracker'),
              Tab(
                  icon: Icon(Icons.show_chart,
                      color: Colors.deepOrangeAccent, size: 30),
                  text: 'Graph'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                trackerTab(),
                weightGraphTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget trackerTab() {
    return SingleChildScrollView(
      child: Card(
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
            mainAxisSize: MainAxisSize.min,
            children: [
              WeightPage.spacingBox,
              weightProgress(),
              WeightPage.spacingBox,
              const Divider(color: WeightPage.dividerLineColor, thickness: 2.3),
              WeightPage.spacingBox,
              progressAndTime(),
              WeightPage.spacingBox,
              const Divider(color: WeightPage.dividerLineColor, thickness: 2.3),
              WeightPage.spacingBox,
              const Text("Current Statistics",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue)),
              WeightPage.spacingBox,
              const Divider(color: WeightPage.dividerLineColor, thickness: 2.6),
              WeightPage.spacingBox,
              currentStatistics(),
              WeightPage.spacingBox,
              const Divider(color: WeightPage.dividerLineColor, thickness: 2.3),
              WeightPage.spacingBox,
              bmiStatistics(),
              WeightPage.spacingBox,
              const Divider(color: WeightPage.dividerLineColor, thickness: 2.3),
              WeightPage.spacingBox,
              dailyLoss(),
              WeightPage.spacingBox,
              const Divider(color: WeightPage.dividerLineColor, thickness: 2.3),
              WeightPage.spacingBox,
              enterWeightButton(),
              WeightPage.spacingBox,
            ],
          ),
        ),
      ),
    );
  }

  Widget weightProgress() {
    double progressPercentage = currentWeight != null && targetWeight != null
        ? (currentWeight! - startWeight) / (targetWeight! - startWeight)
        : 0;
    progressPercentage =
        progressPercentage.clamp(0.0, 1.0); // Ensure it's between 0 and 1

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            const Text("Start",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
            // display the start weight the user entered
            Text("$startWeight kg", style: const TextStyle(fontSize: 18)),
            Text(
                "BMI: ${calculateBMI(currentWeight ?? startWeight, height).toStringAsFixed(1)}",
                style: const TextStyle(fontSize: 18)),
            Text(DateFormat('MMM dd, yy').format(startDate),
                style: const TextStyle(fontSize: 18)),
          ],
        ),
        CircularPercentIndicator(
          radius: 90.0,
          lineWidth: 13.0,
          animation: true,
          percent: progressPercentage,
          center: Text(
            "${currentWeight ?? 75.0} kg",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: Colors.blue,
        ),
        Column(
          children: [
            const Text("Target",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
            Text("${targetWeight ?? 70} kg",
                style: const TextStyle(fontSize: 18)),
            Text(
                "BMI: ${calculateBMI(targetWeight ?? 70, height).toStringAsFixed(1)}",
                style: const TextStyle(fontSize: 18)),
            Text(
                targetDate != null
                    ? DateFormat('MMM dd, yy').format(targetDate!)
                    : "Jan 23, 24",
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ],
    );
  }

  Widget progressAndTime() {
    double weightLoss = (startWeight - (currentWeight ?? startWeight)).abs();
    double weightLossPercentage =
        (weightLoss / (startWeight - (targetWeight ?? startWeight))) * 100;
    weightLossPercentage = weightLossPercentage.clamp(
        0.0, 1.0); // Ensuring the value is between 0 and 1

    return Column(
      children: [
        const Text("Progress",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
        const SizedBox(height: 5),
        LinearProgressIndicator(
          color: const Color.fromARGB(255, 30, 212, 57),
          value: weightLossPercentage,
          minHeight: 13,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        const SizedBox(height: 5),
        Text("${weightLossPercentage.toStringAsFixed(2)}%",
            style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 10),
        const Text("Time",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
        const SizedBox(height: 5),
        LinearProgressIndicator(
          color: const Color.fromARGB(255, 35, 204, 233),
          value:
              weightLossPercentage, // This should ideally be time-based progress
          minHeight: 13,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        const SizedBox(height: 5),
        Text("${(weightLossPercentage * 100).toStringAsFixed(2)}%",
            style: const TextStyle(fontSize: 18)),
      ],
    );
  }

  Widget currentStatistics() {
    double weightLost = (startWeight - (currentWeight ?? startWeight)).abs();
    double weightRemaining =
        (targetWeight ?? startWeight) - (currentWeight ?? startWeight);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Body Fat",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 125, 125, 125))),
            Text("${(20.1 - (weightLost * 0.1)).toStringAsFixed(1)}%",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("You Lost",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 125, 125, 125))),
            Text("${weightLost.toStringAsFixed(1)} kg",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Remaining",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 125, 125, 125))),
            Text("${weightRemaining.toStringAsFixed(1)} kg",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }

  Widget bmiStatistics() {
    double currentBMI = calculateBMI(currentWeight ?? startWeight, height);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("BMI: ${currentBMI.toStringAsFixed(1)}",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
        const SizedBox(width: 16),
        Text(getHealthRating(currentBMI),
            style: const TextStyle(
                fontSize: 20, color: Colors.red, fontWeight: FontWeight.w400)),
      ],
    );
  }

  Widget dailyLoss() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Avg daily loss",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 125, 125, 125))),
            Text("0.1 kg",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600)), // Example value
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Diet",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 125, 125, 125))),
            Text("1500 kcal",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600)), // Example value
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Avg weekly loss",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 125, 125, 125))),
            Text("0.7 kg",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600)), // Example value
          ],
        ),
      ],
    );
  }

  Widget enterWeightButton() {
    return ElevatedButton(
      onPressed: _showWeightEntryDialog,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 39, 202, 27),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text("Enter Weight",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black)),
    );
  }

  void _showWeightEntryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter Your Weight Details"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                DropdownButtonFormField<String>(
                  value: 'Male',
                  items: <String>['Male', 'Female']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {});
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Height in cm'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      height = double.tryParse(value) ?? height;
                    });
                  },
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Start Weight in kg'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      startWeight = double.tryParse(value) ?? startWeight;
                    });
                  },
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Current Weight in kg'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      currentWeight = double.tryParse(value);
                      startDate = DateTime
                          .now(); // Update start date when current weight is updated
                    });
                  },
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Target Weight in kg'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      targetWeight = double.tryParse(value);
                    });
                  },
                ),
                TextFormField(
                  controller: _dateController,
                  decoration:
                      const InputDecoration(labelText: 'Weight achieve by'),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _dateController.text =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        targetDate = pickedDate;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  double calculateBMI(double weight, double height) {
    return (weight / (height * height)) *
        10000; // height in cm converted to meters squared
  }

  String getHealthRating(double bmi) {
    if (bmi < 18.5) {
      return "Underweight";
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return "Healthy";
    } else if (bmi >= 25 && bmi <= 29.9) {
      return "Overweight";
    } else {
      return "Obese";
    }
  }

  Widget weightGraphTab() {
    return SingleChildScrollView(
      // Enable horizontal and vertical scrolling
      scrollDirection: Axis.horizontal,
      child: Container(
        width: 800,
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(show: false),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true, getTitlesWidget: _bottomTitleWidgets),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true, getTitlesWidget: _leftTitleWidgets),
              ),
            ),
            borderData: FlBorderData(show: true),
            minX: 0,
            maxX: 11,
            minY: 60,
            maxY: 90,
            lineBarsData: [
              LineChartBarData(
                spots: const [
                  FlSpot(0, 80),
                  FlSpot(1, 79),
                  FlSpot(2, 78),
                  FlSpot(3, 77),
                  FlSpot(4, 76),
                  FlSpot(5, 75),
                  FlSpot(6, 74),
                  FlSpot(7, 73),
                  FlSpot(8, 72),
                  FlSpot(9, 71),
                  FlSpot(10, 70),
                ],
                isCurved: true,
                color: Colors.blue,
                barWidth: 5,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: true),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Jan', style: style);
        break;
      case 1:
        text = const Text('Feb', style: style);
        break;
      case 2:
        text = const Text('Mar', style: style);
        break;
      case 3:
        text = const Text('Apr', style: style);
        break;
      case 4:
        text = const Text('May', style: style);
        break;
      case 5:
        text = const Text('Jun', style: style);
        break;
      case 6:
        text = const Text('Jul', style: style);
        break;
      case 7:
        text = const Text('Aug', style: style);
        break;
      case 8:
        text = const Text('Sep', style: style);
        break;
      case 9:
        text = const Text('Oct', style: style);
        break;
      case 10:
        text = const Text('Nov', style: style);
        break;
      case 11:
        text = const Text('Dec', style: style);
        break;
      default:
        text = const Text('', style: style);
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.0,
      child: text,
    );
  }

  Widget _leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    return Text(value == 60 ? '60 kg' : '${value.toInt()}', style: style);
  }
}
