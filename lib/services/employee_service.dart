import 'package:dio/dio.dart';
import 'package:employees_data/model/employee_model.dart';

class EmployeeService {
  String endpoint =
    "https://jsonplaceholder.typicode.com/users";
  final dio = Dio();
// function to parse the json response into list
  Future<List<Employee>> getEmployees() async {
    List<Employee> employee = [];
    try {
      final response = await dio.get(endpoint);
      var data= response.data;
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
