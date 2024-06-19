// Importing necessary flutter materials and specific provider screens
import 'package:flutter/material.dart';
import 'package:money_transfer_app/screens/signup_screen.dart';

//running the app
void main() {
  runApp(const MyApp());
}

// defining the main MyApp widget which extends StatelessWidget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //setting overall structure of the application
    return MaterialApp(
      title: 'MONEY APP',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(), //setting the home page of the app
      theme: ThemeData(
        //setting the theme brightnes to dark
        brightness: Brightness.dark, 
        appBarTheme: const AppBarTheme( 
          //setting appbar background to black
          backgroundColor: Colors.black,
        ),
        textTheme: const TextTheme(
          //setting text color to white
          bodyLarge: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

//defining home page widget which is stateless widget
class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

//list of telecom providers
  final List<String> providers = [
    'Safaricom',
    'Airtel',
    'Telkom',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //setting the appbar background to black
        backgroundColor: Colors.black,
        //removing the shadow from the appbar
        elevation: 0,
        //setting the title of the appbar
        title: const Text('MONEY APP'),
      ),
      body: Center(
        child: Column(
          // centering the content vertically
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'SELECT TELECOM PROVIDER',
              //setting the text style to white
              style: TextStyle(fontSize: 24.0, color: Colors.white),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                //number of items in the lists
                itemCount: providers.length,
                itemBuilder: (context, index) {
                  //building each item provider
                  return _buildProviderItem(context, providers[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //helper method to build each provider item
  Widget _buildProviderItem(BuildContext context, String provider) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            //navigating to the sign up page of the selected provider
            builder: (context) => SignUpPage(provider: provider),
          ),
        );
      },
      child: Container(
        //adding padding inside the container
        padding: const EdgeInsets.all(20.0),
        //adding margin outside the container
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: BoxDecoration(
          //setting the background color of the container
          color: Colors.grey[800],
          //rounding the corners of the container
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          provider,
          //setting the text style to white
          style: const TextStyle(fontSize: 18.0, color: Colors.white),
        ),
      ),
    );
  }
}
