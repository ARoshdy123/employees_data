import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:employees_data/model/employee_model.dart';

class EmployeeService {
  String endpoint ="https://jsonplaceholder.typicode.com/users";

// function using Http to get the json response into list
  Future<List<Employee>> getEmployees() async {
    List<Employee> employee = [];
    try {
      final response = await http.get(Uri.parse(endpoint));
      var data= jsonDecode(response.body);
      data.forEach((json) {
        Employee user = Employee.fromJson(json);
        employee.add(user);
      });
      print(response.toString());
    } catch (e) {
      print(e.toString());
    }
    return employee;
  }
}
