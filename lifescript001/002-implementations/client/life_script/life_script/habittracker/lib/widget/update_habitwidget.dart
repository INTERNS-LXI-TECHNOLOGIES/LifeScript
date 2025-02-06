import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habittracker/bloc/homepage/habit_track_bloc.dart'; // Ensure you import flutter_bloc

class UpdateHabitWidget extends StatelessWidget {
  final Function(String id, String habitName, String description) onUpdate;
  final Function(String id) onSearch;

  const UpdateHabitWidget({
    required this.onUpdate,
    required this.onSearch,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _idController = TextEditingController();
    final _habitNameController = TextEditingController();
    final _descriptionController = TextEditingController();

    bool _isSearching = false;
    bool _isFound = false;

    return BlocProvider(
      create: (context) => HabitTrackBloc(),
      child: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5), // Glassmorphism background
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Update Habit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _idController,
                    decoration: InputDecoration(
                      labelText: 'Enter Habit ID',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (_idController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please enter an ID to search.')),
                        );
                        return;
                      }

                      setState(() {
                        _isSearching = true;
                      });

                      final details = await onSearch(_idController.text);

                      if (details != null) {
                        _habitNameController.text = details['habitName'];
                        _descriptionController.text = details['description'];
                        setState(() {
                          _isFound = true;
                        });
                      } else {
                        setState(() {
                          _isFound = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Sorry, no details found for the given ID.')),
                        );
                      }

                      setState(() {
                        _isSearching = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isSearching
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Search',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                  SizedBox(height: 16),
                  if (_isFound) ...[
                    TextFormField(
                      controller: _habitNameController,
                      decoration: InputDecoration(
                        labelText: 'Habit Name',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_habitNameController.text.isEmpty || _descriptionController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please fill in all fields.')),
                          );
                          return;
                        }

                        onUpdate(
                          _idController.text,
                          _habitNameController.text,
                          _descriptionController.text,
                        );
                        Navigator.pop(context); // Close the pop-up
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void setState(Null Function() param0) {}
}