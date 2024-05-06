import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  final Widget child;
  final String title;
  final int selectedIndex;

  const BasePage({
    super.key,
    required this.child,
    required this.title,
    this.selectedIndex = 0,
  });

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
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
        // make the leading button a back and a signout button pointing to '/login' on the right side
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 235, 235, 235),
        elevation: 0,
      ),
      body: widget.child,
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
    );
  }
}
