// importing necessary flutter materials and specific provider screens
import 'package:flutter/material.dart';
import 'package:money_transfer_app/screens/airtel_screen.dart';
import 'package:money_transfer_app/screens/safaricom_screen.dart';
import 'package:money_transfer_app/screens/telkom_screen.dart';

class SignUpPage extends StatelessWidget {
  final String provider;

  const SignUpPage({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    //text controllers to get input from text fields
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneNumberController = TextEditingController();
    final TextEditingController idNumberController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up for $provider'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              //center content vertically
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_circle,
                  size: 100,
                  color: Colors.blue[700],
                ),
                const SizedBox(height: 50),
                //name textfield
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
                //phone number textfield
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
                //id number textfield
                TextField(
                  controller: idNumberController,
                  decoration: const InputDecoration(
                    labelText: 'ID Number (required)',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color.fromARGB(255, 110, 110, 110),
                  ),
                ),
                const SizedBox(height: 20),
                //password textfield
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
                ElevatedButton(
                  onPressed: () {
                    //check if any of the required fields are empty or if the phone number is not 10 characters long
                      if(nameController.text.isEmpty ||
                          phoneNumberController.text.isEmpty ||
                          phoneNumberController.text.length != 10 ||
                          idNumberController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        //if any condition is not met, display a snack bar with an error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all fields and ensure phone number is 10 characters long.')),
                      );
                      return;
                    }
                    //use a switch statement to determine which provider page to navigate to based on the 'provider' variable
                    switch (provider) {
                      case 'Safaricom':
                      //navigate to SafaricomPage and replace the current page
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const SafaricomPage()),
                        );
                        break;
                      case 'Airtel':
                      //navigate to AirtelPage and replace the current page
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const AirtelPage()),
                        );
                        break;
                      case 'Telkom':
                      //navigate to TelkomPage and replace the current page
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const TelkomPage()),
                        );
                        break;
                    }
                  },
                  //defines the text displayed on the button, incorporating the selected provider
                  child: Text('Proceed to $provider Page'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
