//importing necessary Flutter materials and specific provider screens
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_transfer_app/screens/airtel_screen.dart';
import 'package:money_transfer_app/screens/login_screen.dart';
import 'package:money_transfer_app/screens/safaricom_screen.dart';
import 'package:money_transfer_app/screens/telkom_screen.dart';
import 'package:money_transfer_app/services/auth_services.dart';

//signUpPage widget which accepts a provider name
class SignUpPage extends StatefulWidget {
  final String provider;

  const SignUpPage({super.key, required this.provider});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

//state class for SignUpPage
class _SignUpPageState extends State<SignUpPage> {
  //controllers for handling text input
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //instance of AuthService for handling authentication
  final AuthService authService = AuthService();
  //boolean to check if the widget is still mounted
  bool isMounted = true;

  //dispose controllers when the widget is removed from the widget tree
  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up for ${widget.provider}'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.account_circle,
                  size: 100,
                  color: Colors.blue,
                ),
                const SizedBox(height: 50),
                //name text field
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name (required)',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color.fromARGB(255, 110, 110, 110),
                  ),
                ),
                const SizedBox(height: 20),
                //phone number text field
                TextField(
                  controller: phoneNumberController,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number (required, 10 characters)',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color.fromARGB(255, 110, 110, 110),
                  ),
                ),
                const SizedBox(height: 20),
                //email text field
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email (required)',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color.fromARGB(255, 110, 110, 110),
                  ),
                ),
                const SizedBox(height: 20),
                //password text field
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password (required)',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color.fromARGB(255, 110, 110, 110),
                  ),
                ),
                const SizedBox(height: 40),
                //sign Up button
                ElevatedButton(
                  onPressed: () async {
                    //check if any required fields are empty or phone number is not 10 characters long
                    if (nameController.text.isEmpty ||
                        phoneNumberController.text.isEmpty ||
                        phoneNumberController.text.length != 10 ||
                        emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      //display error message if validation fails
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all fields and ensure phone number is 10 characters long.')),
                      );
                      return;
                    }

                    //perform sign up logic
                    User? user = await authService.registerWithEmailAndPassword(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );

                    //if user is registered successfully, navigate to the appropriate provider page
                     if (isMounted && user != null) {
                      // Use a switch statement to determine which provider page to navigate to based on the 'provider' variable
                      switch (widget.provider) {
                        case 'Safaricom':
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => SafaricomPage(name: nameController.text.trim())),
                          );
                          break;
                        case 'Airtel':
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => AirtelPage(name: nameController.text.trim())),
                          );
                          break;
                        case 'Telkom':
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => TelkomPage(name: nameController.text.trim())),
                          );
                          break;
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Registration failed. Please try again.'),
                        ),
                      );
                    }
                  },
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 20),
                //text to navigate to the login page
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text('Already have an account? Login here.'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
