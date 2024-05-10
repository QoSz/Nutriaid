import 'package:flutter/material.dart';
import 'package:nutriaid/pages/base_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double weight = 80; // Initial weight, can be dynamic based on user data
  double height = 190; // Initial height, can be dynamic based on user data
  DateTime dateOfBirth = DateTime(2000, 1, 1); // Set initial date of birth
  String gender = 'Male'; // Initial gender, can be dynamic based on user data

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'My Profile',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Card(
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('assets/images/profileimg.png'),
                      ),
                    ),
                    const SizedBox(height: 30),
                    RichText(
                      text: const TextSpan(
                        text: 'Name: ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 117, 117, 117),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sam Doe',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    RichText(
                      text: const TextSpan(
                        text: 'Email: ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 117, 117, 117),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'sam.doe@gmail.com',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'DOB: ',
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 117, 117, 117),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: dateOfBirth
                                    .toLocal()
                                    .toString()
                                    .split(' ')[0],
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_today,
                              color: Colors.red),
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: dateOfBirth,
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null && picked != dateOfBirth) {
                              setState(() {
                                dateOfBirth = picked;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    RichText(
                      text: const TextSpan(
                        text: 'Username: ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 117, 117, 117),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'SweetToothSam',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    RichText(
                      text: const TextSpan(
                        text: 'Password: ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 117, 117, 117),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '***********',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/change-password');
                      }, // Define functionality
                      child: RichText(
                        text: const TextSpan(
                          text: 'Change Password',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 151, 151, 151),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // take the user to the login page
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ), // Define functionality
                      child: const Text(
                        'Sign Out',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
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
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Weight',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                        Text('${weight.toStringAsFixed(0)} kg',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Slider(
                      value: weight,
                      min: 0,
                      max: 150,
                      divisions: 150,
                      label: weight.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          weight = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Height',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '${height.toStringAsFixed(0)} cm',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Slider(
                      value: height,
                      min: 100,
                      max: 250,
                      divisions: 150,
                      label: height.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          height = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
