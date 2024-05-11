import 'package:flutter/material.dart';
import 'package:nutriaid/pages/base_page.dart';
import 'package:nutriaid/pages/hydrationprogresscard.dart';
import 'package:provider/provider.dart';
import 'hydration_model.dart'; // Ensure this matches the correct import path for your project

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
                    // Additional content can be placed here if needed
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
}
