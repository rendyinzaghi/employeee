import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:employee/add_employee_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: EmployeeListScreen(),
    );
  }
}

class EmployeeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
      ),
      body: EmployeeList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to screen to add new employee
          // Implement this based on your navigation setup
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class EmployeeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('employees').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final List<DocumentSnapshot> documents = snapshot.data.docs;
        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final employee = documents[index].data();
            return ListTile(
              title: Text(employee['name']),
              subtitle: Text(employee['position']),
            );
          },
        );
      },
    );
  }
}
