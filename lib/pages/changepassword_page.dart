import 'package:flutter/material.dart';
import 'package:nutriaid/pages/base_page.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  String? _oldPassword, _newPassword, _confirmPassword;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Change Password',
      child: Center(
        // Wraps the padding in a Center widget
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Card(
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        style: const TextStyle(fontSize: 22.0),
                        decoration: InputDecoration(
                          labelText: 'Old Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          prefixIcon: const Icon(Icons.lock_outline),
                        ),
                        obscureText: true,
                        onChanged: (value) => _oldPassword = value,
                      ),
                      const SizedBox(height: 20.0),
                      TextField(
                        style: const TextStyle(fontSize: 22.0),
                        decoration: InputDecoration(
                          labelText: 'New Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          prefixIcon: const Icon(Icons.lock),
                        ),
                        obscureText: true,
                        onChanged: (value) => _newPassword = value,
                      ),
                      const SizedBox(height: 20.0),
                      TextField(
                        style: const TextStyle(fontSize: 22.0),
                        decoration: InputDecoration(
                          labelText: 'Confirm New Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          prefixIcon: const Icon(Icons.lock),
                        ),
                        obscureText: true,
                        onChanged: (value) => _confirmPassword = value,
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                        width: double.infinity,
                        height: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF28C25C), Color(0xFF48B78E)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: InkWell(
                          onTap: _changePassword,
                          child: const Center(
                            child: Text(
                              'Change Password',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _changePassword() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Implement the logic to change the password here.
      // Example: Navigator.pushNamed(context, '/dashboard');
    }
  }
}
