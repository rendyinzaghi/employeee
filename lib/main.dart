import 'package:flutter/material.dart';
import 'firebase_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final database = FirebaseDatabase.instance;
  List<Map<String, dynamic>> _employees = [];

  @override
  void initState() {
    super.initState();
    _loadEmployees();
  }

  void _loadEmployees() {
    final employeesRef = database.reference().child('employees');
    employeesRef.onValue.listen((event) {
      final employees = event.snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        _employees = employees.entries.map((entry) {
          return {
            'id': entry.key,
            'name': entry.value['name'],
            'position': entry.value['position'],
          };
        }).toList();
      });
    });
  }

  void _addEmployee(String name, String position) {
    final employeesRef = database.reference().child