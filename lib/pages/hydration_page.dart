import 'package:flutter/material.dart';
import 'package:nutriaid/pages/base_page.dart';
import 'package:nutriaid/widgets/hydrationprogresscard.dart';
import 'package:provider/provider.dart';
import '../models/hydration_model.dart';
import 'package:nutriaid/widgets/ideal_and_target_water_card.dart';
import 'package:fl_chart/fl_chart.dart';

class HydrationPage extends StatefulWidget {
  const HydrationPage({super.key});

  @override
  State<HydrationPage> createState() => _HydrationPageState();
}

class _HydrationPageState extends State<HydrationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Hydration Tracker',
      child: Column(
        children: [
          TabBar(
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
                      const IdealAndTargetWaterCard(),
                      const SizedBox(height: 20),
                      Consumer<HydrationModel>(
                        builder: (context, hydration, child) =>
                            const HydrationProgressCard(),
                      ),
                      const SizedBox(height: 20),
                      waterLogCard(),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: waterIntakeGraph(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget waterLogCard() {
    return Consumer<HydrationModel>(
      builder: (context, hydration, child) {
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
                ...hydration.waterLogs.map((log) => ListTile(
                      leading: const Icon(Icons.local_drink,
                          color: Colors.blue, size: 30),
                      title: Text("${log['amount']} ml",
                          style: const TextStyle(fontSize: 18)),
                      trailing: Text(log['time'],
                          style: const TextStyle(fontSize: 16)),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget waterIntakeGraph() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine: (value) {
            return const FlLine(
              color: Color(0xff37434d),
              strokeWidth: 0.5,
            );
          },
          getDrawingVerticalLine: (value) {
            return const FlLine(
              color: Color(0xff37434d),
              strokeWidth: 0.5,
            );
          },
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                const style = TextStyle(
                  color: Color(0xff68737d),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                );
                switch (value.toInt()) {
                  case 1:
                    return const Text('Mon', style: style);
                  case 2:
                    return const Text('Tue', style: style);
                  case 3:
                    return const Text('Wed', style: style);
                  case 4:
                    return const Text('Thu', style: style);
                  case 5:
                    return const Text('Fri', style: style);
                  case 6:
                    return const Text('Sat', style: style);
                  case 7:
                    return const Text('Sun', style: style);
                  default:
                    return Container();
                }
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 500,
              getTitlesWidget: (value, meta) {
                const style = TextStyle(
                  color: Color(0xff68737d),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                );
                return Text('${value.toInt()} ml', style: style);
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1),
        ),
        minX: 1,
        maxX: 7,
        minY: 0,
        maxY: 3000,
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(1, 1500),
              const FlSpot(2, 1800),
              const FlSpot(3, 1400),
              const FlSpot(4, 2200),
              const FlSpot(5, 2000),
              const FlSpot(6, 2300),
              const FlSpot(7, 1700),
            ],
            isCurved: true,
            color: Colors.blue,
            barWidth: 4,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(show: false),
            dotData: const FlDotData(show: true),
          ),
        ],
      ),
    );
  }
}
