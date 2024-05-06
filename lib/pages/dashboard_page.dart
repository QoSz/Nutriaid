import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'base_page.dart'; // Ensure this path is correct to import BasePage

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Dashboard',
      selectedIndex: 0,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/calorie');
              },
              child: _buildCard(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 26, 211, 32),
                              Color.fromARGB(255, 30, 194, 36),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.srcIn,
                        child: const Text(
                          'Calorie Overview',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildTextColumn('1,291', 'Eaten'),
                          CircularPercentIndicator(
                            radius: 100.0,
                            lineWidth: 10.0,
                            percent: 0.7,
                            center: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "826",
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Remaining",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Color.fromARGB(255, 174, 174, 174)),
                                ),
                              ],
                            ),
                            progressColor: Colors.green,
                            circularStrokeCap: CircularStrokeCap.round,
                          ),
                          _buildTextColumn('244', 'Burned'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/nutrition');
              },
              child: _buildCard(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 26, 211, 32),
                              Color.fromARGB(255, 30, 194, 36),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.srcIn,
                        child: const Text(
                          'Macronutrients',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildMacroIndicator(
                              'Protein', 55.4, 74, Colors.purple),
                          _buildMacroIndicator(
                              'Carbs', 151.0, 302, Colors.orange),
                          _buildMacroIndicator('Fats', 60.2, 71, Colors.yellow),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/hydration');
              },
              child: _buildCard(
                child: const ListTile(
                  leading: Icon(Icons.water_drop, size: 40, color: Colors.blue),
                  title: Text(
                    'Water Intake',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 10, 173, 32),
                    ),
                  ),
                  subtitle: Text(
                    '800 / 2400 ml',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 10, 174, 149),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      color: const Color.fromARGB(255, 240, 240, 240),
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: Color.fromARGB(255, 230, 230, 230),
          width: 2.0,
        ),
      ),
      elevation: 0,
      shadowColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
      child: child,
    );
  }

  Widget _buildTextColumn(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 174, 174, 174)),
        ),
      ],
    );
  }

  Widget _buildMacroIndicator(
      String label, double achieved, double target, Color color) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 50.0,
          lineWidth: 6.0,
          percent: achieved / target,
          center: Text('$achieved g',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              )),
          progressColor: color,
          circularStrokeCap: CircularStrokeCap.round,
        ),
        Column(
          children: [
            const SizedBox(height: 10.0),
            Text(
              label,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 40, 40, 40)),
            ),
            const SizedBox(height: 4.0),
            Text(
              'Target: $target g',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 111, 111, 111)),
            ),
          ],
        ),
      ],
    );
  }
}
