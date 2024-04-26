import 'package:flutter/material.dart';
import 'package:employee/home_screen.dart';

class AddEmployeeScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();

  void _addEmployee(BuildContext context) {
    String name = _nameController.text;
    String position = _positionController.text;

    // Check if both name and position are not empty
    if (name.isNotEmpty && position.isNotEmpty) {
      FirebaseFirestore.instance.collection('employees').add({
        'name': name,
        'position': position,
      }).then((_) {
        // After adding data, navigate back to home screen
        Navigator.pop(context);
      }).catchError((error) {
        // Handle error
        print('Failed to add employee: $error');
        // You can show an error message to the user if needed
      });
    } else {
      // Show a message to the user to fill in both fields
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in both name and position fields.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _positionController,
              decoration: InputDecoration(labelText: 'Position'),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () => _addEmployee(context),
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
