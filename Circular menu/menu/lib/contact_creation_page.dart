import 'package:flutter/material.dart';
import 'circular_menu.dart'; // Import the updated CircularMenu class

class ContactCreationPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Contact'),
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {
                    final String name = nameController.text;
                    final String phone = phoneController.text;
                    final String email = emailController.text;

                    if (name.isEmpty || phone.isEmpty || email.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please fill out all fields'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Contact Saved: $name'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  child: Text('Save Contact'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    backgroundColor: Colors.teal,
                  ),
                ),
              ],
            ),
          ),
          CircularMenu(
            menuButtons: [
              MenuButton(
                icon: Icons.home,
                tooltip: 'Home',
                offset: Offset(0, -100),
                onPressed: () {
                  print('Home button pressed');
                },
                color: Colors.red, // Specify the color
              ),
              MenuButton(
                icon: Icons.settings,
                tooltip: 'Settings',
                offset: Offset(100, 0),
                onPressed: () {
                  print('Settings button pressed');
                },
                color: Colors.green, // Specify the color
              ),
              MenuButton(
                icon: Icons.info,
                tooltip: 'Info',
                offset: Offset(-100, 0),
                onPressed: () {
                  print('Info button pressed');
                },
                color: Colors.purple, // Specify the color
              ),
            ],
          ),
        ],
      ),
    );
  }
}
