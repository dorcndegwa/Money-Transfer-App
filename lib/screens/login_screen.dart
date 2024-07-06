//importing necessary Flutter materials and specific provider screens
import 'package:flutter/material.dart';
import 'package:money_transfer_app/main.dart';
import 'package:money_transfer_app/services/auth_services.dart';
import 'signup_screen.dart'; // Import the sign-up screen

//defining a stateful widget for the login screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //controllers to capture user input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _auth = AuthService(); // Instance of AuthService for authentication

  @override
  void dispose() {
    //dispose of the controllers to free up resources
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    //capture the input values
    final email = _emailController.text;
    final password = _passwordController.text;

    //attempt to sign in the user
    final user = await _auth.signInWithEmailAndPassword(email, password);

    //check if the widget is still mounted before navigating
    if (!mounted) return;

    //navigate to the home page if login is successful
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    } else {
      //show a snackbar if login fails
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              //center content vertically
              mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
              children: [
                const Icon(
                  Icons.account_circle,
                  size: 100,
                  color: Colors.blue, 
                ),
                const SizedBox(height: 50),
                //name text field 
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color.fromARGB(255, 110, 110, 110),
                  ),
                ),
                const SizedBox(height: 20),
                //email text field 
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color.fromARGB(255, 110, 110, 110),
                  ),
                ),
                const SizedBox(height: 20),
                //password text field 
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color.fromARGB(255, 110, 110, 110),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                // Login button
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20),
                //button to navigate to the sign-up page
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpPage(provider: 'YourProviderName'),
                      ),
                    );
                  },
                  child: const Text('Don\'t have an account? Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
