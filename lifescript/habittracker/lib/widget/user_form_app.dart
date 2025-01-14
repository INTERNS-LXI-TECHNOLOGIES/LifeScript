import 'package:flutter/material.dart';


class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController habitsController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void saveData() {
    if (_formKey.currentState?.validate() ?? false) {
      String id = idController.text;
      String name = nameController.text;
      String habits = habitsController.text;
      String description = descriptionController.text;

      // Here you can add your save logic (e.g., storing data in a database)
      print('ID: $id, Name: $name, Habits: $habits, Description: $description');
      
      // Clear fields after saving
      idController.clear();
      nameController.clear();
      habitsController.clear();
      descriptionController.clear();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data saved!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: idController,
                decoration: InputDecoration(labelText: 'User ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: habitsController,
                decoration: InputDecoration(labelText: 'Habits'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your habits';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveData,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
