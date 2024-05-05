import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index, BuildContext context) {
    setState(() {
      _selectedIndex = index;
    });

    // Define route names based on index
    String routeName;
    switch (index) {
      case 0:
        routeName = '/dashboard'; // Dashboard Page
        break;
      case 1:
        routeName = '/nutrition'; // Nutrition Page
        break;
      case 2:
        routeName = '/plans'; // Plans Page
        break;
      case 3:
        routeName = '/community'; // Community Page
        break;
      case 4:
        // Open the drawer and do not navigate to a new page
        Scaffold.of(context).openDrawer();
        return; // Exit the function after opening the drawer
      default:
        routeName =
            '/dashboard'; // Default back to dashboard or consider handling an error
        break;
    }

    // Navigate to the specified route
    Navigator.pushReplacementNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 235, 235, 235),
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {},
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
                            ], // Define your gradient colors here
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode
                            .srcIn, // This blend mode applies the shader to the text color
                        child: const Text(
                          'Calorie Overview',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight
                                .w600, // Use const if all properties are constant
                            color: Colors
                                .white, // Temporary color, the shader will override this
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
                              mainAxisAlignment: MainAxisAlignment
                                  .center, // Align text to the center of the column
                              children: <Widget>[
                                Text(
                                  "826",
                                  style: TextStyle(
                                    fontSize:
                                        24.0, // Increase font size for the number
                                    fontWeight:
                                        FontWeight.bold, // Make the number bold
                                  ),
                                ),
                                Text(
                                  "Remaining",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 174, 174,
                                          174) // Smaller font size for the label
                                      ),
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
              onTap: () {},
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
                            ], // Define your gradient colors here
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode
                            .srcIn, // This blend mode applies the shader to the text color
                        child: const Text(
                          'Macronutrients',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight
                                .w600, // Use const if all properties are constant
                            color: Colors
                                .white, // Temporary color, the shader will override this
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
              onTap: () {},
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

      // Added bottom navigation bar with Dashboard, Nutrition, Plans, Community and More buttons
      bottomNavigationBar: Builder(
        builder: (BuildContext context) {
          return BottomNavigationBar(
            backgroundColor: const Color.fromARGB(255, 240, 240, 240),
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.dashboard,
                  color: Color.fromARGB(255, 7, 133, 196),
                ),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.restaurant_menu, color: Colors.green),
                label: 'Nutrition',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book, color: Colors.orange),
                label: 'Plans',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people, color: Colors.purple),
                label: 'Community',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz, color: Colors.grey),
                label: 'More',
              ),
            ],
            selectedItemColor: const Color.fromARGB(255, 71, 204, 76),
            unselectedItemColor: const Color.fromARGB(255, 121, 121, 121),
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            unselectedLabelStyle:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            // Change the icons sizes
            iconSize: 30,
            currentIndex: _selectedIndex,
            onTap: (index) {
              _onItemTapped(index, context);
            },
          );
        },
      ),

      // Create a drawer with the logo at the top and a list of menu items below it.Add padding to the drawer to ensure the menu items are not too close to the edges of the screen. Make sure the menu items have an icon.
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Image.asset(
                'assets/images/logo.png',
                height: 100,
              ),
              const SizedBox(height: 30),
              ListTile(
                leading:
                    const Icon(Icons.dashboard, color: Colors.blue, size: 40),
                title: const Text(
                  'Dashboard',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/dashboard');
                },
              ),
              ListTile(
                leading: const Icon(Icons.score,
                    color: Color.fromARGB(255, 203, 200, 17), size: 40),
                title: const Text(
                  'Calorie Tracking',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/calorie');
                },
              ),
              ListTile(
                leading: const Icon(Icons.restaurant_menu,
                    color: Colors.green, size: 40),
                title: const Text(
                  'Nutrition Tracking',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/nutrition');
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.water_drop, color: Colors.blue, size: 40),
                title: const Text(
                  'Hydration Tracking',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/hydration');
                },
              ),
              ListTile(
                leading: const Icon(Icons.monitor_weight,
                    color: Color.fromARGB(255, 239, 27, 172), size: 40),
                title: const Text(
                  'Weight Tracking',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/weight');
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.menu_book, color: Colors.orange, size: 40),
                title: const Text(
                  'Meal Plans',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/plans');
                },
              ),
              ListTile(
                leading: const Icon(Icons.school,
                    color: Color.fromARGB(255, 201, 18, 18), size: 40),
                title: const Text(
                  'Educational Section',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/education');
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.people, color: Colors.purple, size: 40),
                title: const Text(
                  'Community Section',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/community');
                },
              ),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.grey, size: 40),
                title: const Text(
                  'My Profile',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/profile');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      color: const Color.fromARGB(255, 240, 240, 240),
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 1, // Lowered elevation
      shadowColor: const Color.fromARGB(255, 0, 0, 0)
          .withOpacity(0.25), // Custom shadow color
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
