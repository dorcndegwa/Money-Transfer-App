//importing the required flutter materials
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

// define a stateful widget for the TelkomPage
class TelkomPage extends StatefulWidget {
 const TelkomPage({super.key, required this.name});
  //the name of the page
 final String name;

  @override
  // create a state for TelkomPage
  // ignore: library_private_types_in_public_api
  _TelkomPageState createState() => _TelkomPageState();
}

class _TelkomPageState extends State<TelkomPage> {
   // bool variable to check whether balance is visible or not
  // bool variable is set to false meaning balance is not visible
  bool _isBalanceVisible = false;
  
  @override
  Widget build(BuildContext context) {
    // basic structure for visual screen
    return Scaffold(
      //structure of the top of the app screen
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'TELKOM T-KASH',
               style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 26, 226, 233),
              ),
              ),
            Icon(Icons.notifications),
          ],
        ),
      ),
      //enables body of the screen to be scrollable
      body: CustomScrollView(
        slivers: [
          //sliverToBoxAdapter allows for non-scrollable widgets within a scrollable area
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, ${widget.name}!',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20), // Add some spacing
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Show Balance:',
                        style: TextStyle(fontSize: 20.0),
                      ),
                  Row(
                    children: [
                      Text(
                        _isBalanceVisible ? 'KES 10,000.00' : '****',
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      IconButton(
                        icon: Icon(
                          _isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                            //toggle the visibility of the balance
                              setState(() {
                              _isBalanceVisible = !_isBalanceVisible;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //sliverPadding adds padding around a sliver
            SliverPadding(
            padding: const EdgeInsets.all(10.0),
            //sliverGrid for a grid layout with a fixed number of columns
            sliver: SliverGrid.count(
              crossAxisCount: 3,
              children: [
                //calling a helper function to build grid items for different actions
                _buildGridItem(context, 'Send Money', Icons.send, const SendMoneyPage()),
                _buildGridItem(context, 'Buy Airtime', Icons.phone_android, const BuyAirtimePage()),
                _buildGridItem(context, 'Fund T-Kash', Icons.payment, const FundTkashPage()),
                 _buildGridItem(context, 'Buy Goods', Icons.phone_android, const BuyGoodsPage()),
                _buildGridItem(context, 'Pay Bills', Icons.receipt, const PayBillsPage()),
                 _buildGridItem(context, 'Withdraw Cash', Icons.money_off, const WithdrawCashPage()),
                _buildGridItem(context, 'Account', Icons.account_circle, const AccountPage()),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Transaction',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
        ],
      ),
      //bottom navigation bar with home and account options
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.white),
            label: 'Account',
          ),
        ],
        onTap: (index) {
          //navigation to different pages based on the selected index
          if (index == 0) {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AccountPage()),
            );
          }
        },
      ),
    );
  }

  //helper function to build grid items
  Widget _buildGridItem(BuildContext context, String title, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () {
         //navigation to the specified page when the grid item is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Card(
        color: Colors.grey[800],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30.0, color:  const Color.fromARGB(255, 26, 226, 233)),
            const SizedBox(height: 10.0),
            Text(
              title,
              style: const TextStyle(fontSize: 16.0, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

//define a page for sending money
class SendMoneyPage extends StatelessWidget {
  const SendMoneyPage({super.key});

 //function to show a confirmation dialog
  void showConfirmationDialog(String itemName, BuildContext context) {
    //text controllers to get input from text fields
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController amountController = TextEditingController();
    final TextEditingController pinController = TextEditingController();

    //dialog contains 3 textfields: phone number, amount and pin
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm $itemName'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: pinController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'PIN', //hide PIN characters
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                //create a Logger instance
                final Logger logger = Logger();

                //access phone number, amount, and pin from controllers
                final String phoneNumber = phoneController.text;
                final double amount = double.tryParse(amountController.text) ?? 0.0;
                final String pin = pinController.text;

                //log or process the data
                logger.i('Phone Number: $phoneNumber');
                logger.i('Amount: $amount');
                logger.i('PIN: $pin');

                //close dialog after processing
                Navigator.pop(context);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
 
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Money'),
      ),
       body: Center(
        child: ElevatedButton(
          onPressed: () {
            //show the confirmation dialog when the button is pressed
            showConfirmationDialog('Send Money', context);
          },
          child: const Text('Send Money'),
        ),
      ),
    );
  }
}

//define a page for withdrawing cash
class WithdrawCashPage extends StatelessWidget {
  const WithdrawCashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Withdraw Cash'),
      ),
      //listView with separated items
     body: ListView.separated(
        itemCount: 2,
        itemBuilder: (context, index) {
          //using switch case condition to list down the items
          final String itemName;
          switch (index) {
            case 0:
              itemName = 'From Agent';
              break;
            case 1:
              itemName = 'From ATM';
              break;
            default:
              itemName = 'Unknown Item';
          }
          return ListTile(
            title: Text(itemName),
            onTap: () {
              showConfirmationDialog(itemName, context);
            },
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }

   //function to show a confirmation dialog
  void showConfirmationDialog(String itemName, BuildContext context) {
    //text controllers to get input from text fields
    final TextEditingController primaryController = TextEditingController();
    final TextEditingController secondaryController = TextEditingController();
    final TextEditingController amountController = TextEditingController();
    final TextEditingController pinController = TextEditingController();

    //using if else statement to specify dialog fields
    List<Widget> fields;
    if (itemName == 'From Agent') {
      fields = [
        TextField(
          controller: primaryController,
          decoration: const InputDecoration(
            labelText: 'Agent Number',
          ),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: secondaryController,
          decoration: const InputDecoration(
            labelText: 'Store Number',
          ),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: amountController,
          decoration: const InputDecoration(
            labelText: 'Amount',
          ),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: pinController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'PIN', //hide PIN characters
          ),
        ),
      ];
    } else if (itemName == 'From ATM') {
      fields = [
        TextField(
          controller: primaryController,
          decoration: const InputDecoration(
            labelText: 'Agent Number',
          ),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: amountController,
          decoration: const InputDecoration(
            labelText: 'Amount',
          ),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: pinController,
          obscureText: true, //hide PIN characters
          decoration: const InputDecoration(
            labelText: 'PIN',
          ),
        ),
      ];
    } else {
      fields = [];
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm $itemName'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: fields,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                //create a Logger instance
                final Logger logger = Logger();
                
                //access phone number, amount, and pin from controllers
                final String primaryData = primaryController.text;
                final String secondaryData = secondaryController.text;
                final double amount = double.tryParse(amountController.text) ?? 0.0;
                final String pin = pinController.text;

                //log or process the data
                logger.i('Primary Data: $primaryData');
                logger.i('Secondary Data: $secondaryData');
                logger.i('Amount: $amount');
                logger.i('PIN: $pin');
                //close dialog after processing
                Navigator.pop(context); 
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}

//define a page for buying airtime
class BuyAirtimePage extends StatelessWidget {
  const BuyAirtimePage({super.key});

  //function to show a confirmation dialog
  void showConfirmationDialog(String itemName, BuildContext context) {
    //text controllers to get input from text fields
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController amountController = TextEditingController();
    final TextEditingController pinController = TextEditingController();

    //contains 3 fields : phone number, amount and password
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm $itemName'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: pinController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'PIN', //hide PIN characters
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                //create a Logger instance
                final Logger logger = Logger();

                //access phone number, amount, and pin from controllers
                final String phoneNumber = phoneController.text;
                final double amount = double.tryParse(amountController.text) ?? 0.0;
                final String pin = pinController.text;

                //log or process the data
                logger.i('Phone Number: $phoneNumber');
                logger.i('Amount: $amount');
                logger.i('PIN: $pin');

                //close dialog after processing
                Navigator.pop(context);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Airtime'),
      ),
       body: Center(
        child: ElevatedButton(
          onPressed: () {
            showConfirmationDialog('Buy Airtime', context);
          },
          child: const Text('Buy Airtime'),
        ),
      ),
    );
  }
}

//define a page for buying goods
class BuyGoodsPage extends StatelessWidget {
  const BuyGoodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Goods'),
      ),
      body: const Center(
        child: Text('Buy Goods Page'),
      ),
    );
  }
}

//define a page for paying bills
class PayBillsPage extends StatelessWidget {
  const PayBillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay Bills'),
      ),
      body: const Center(
        child: Text('Pay Page'),
      ),
    );
  }
}

//define a page for fund tkash
class FundTkashPage extends StatelessWidget {
  const FundTkashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fund T-Kash'),
      ),
      body: const Center(
        child: Text('Fund T-Kash'),
      ),
    );
  }
}

//define a page for account details
class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: const Center(
        child: Text('Account Page'),
      ),
    );
  }
}