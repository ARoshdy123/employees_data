import 'package:flutter/material.dart';

import '../model/employee_model.dart';
import '../services/employee_service.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  final EmployeeService _employeeService = EmployeeService();
  List<Employee> employees = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getEmployees();
  }
  Future<void> getEmployees() async {
    setState(() {
      isLoading = true;
    });
// using employee service to get the data and handle any expicted errors
    try {
      final getEmployees = await _employeeService.getEmployees();
      setState(() {
        employees = getEmployees;
      });
    } catch (e) {
      print('Error fetching employees: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Employee List')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : employees.isEmpty
          ? const Center(child: Text('No employees found'))
          : ListView.builder(
        itemCount: employees.length,
        itemBuilder: (context, index) {
          final employee = employees[index]; // get the employee to view the data
          return ListTile(
            trailing: Icon(Icons.person),
            leading: Text("${employee.id}"),
            title: Text(employee.name),
            subtitle: Text(employee.email),
          );
        },
      ),
    );
  }
}