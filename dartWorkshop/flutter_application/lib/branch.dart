import 'package:flutter_application/employee.dart';

class Branch {
  final String id;
  final String name;
  final List<Employee> employees;

  Branch(this.id, this.name, this.employees);
}
