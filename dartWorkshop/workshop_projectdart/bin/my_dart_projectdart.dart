//import 'package:my_dart_projectdart/my_dart_projectdart.dart' as my_dart_projectdart;
import 'package:my_dart_projectdart/my_dart_projectdart.dart';
import 'package:collection/collection.dart';

void main(List<String> arguments) {
  List<Organization> organizations = [
    Organization("TechCorp Ltd.", [
      Branch("A", "Headquarters", [
        Employee("E101", "Alice", 50000),
        Employee("E103", "Charlie", 55000),
        Employee("E107", "Grace", 52000),
        Employee("E110", "Jack", 63000),
      ]),
      Branch("B", "Regional Office", [
        Employee("E102", "Bob", 60000),
        Employee("E106", "Frank", 48000),
        Employee("E109", "Ian", 47000),
      ]),
      Branch("C", "City Branch", [
        Employee("E104", "David", 70000),
        Employee("E105", "Eve", 72000),
        Employee("E108", "Hannah", 68000),
      ]),
    ]),
  ];

print('Q1: ${organizations.first.getTotalEmployees()}');
print('Q2: ${organizations.first.getTotalSalaryExpenditure()}');
print('Q3: ${organizations.first.getHighestPaidEmployee()}');
print('Q4: ${organizations.first.getEmployeesSortedBySalary()}');
//print('Q2: ${organizations.first.getHighestPaidEmployee()}');
//print('Q2: ${organizations.first.getHighestPaidEmployee()}');
// print('Q2: ${organizations.first.getHighestPaidEmployee()}');
// print('Q2: ${organizations.first.getHighestPaidEmployee()}');
// print('Q2: ${organizations.first.getHighestPaidEmployee()}');
// print('Q2: ${organizations.first.getHighestPaidEmployee()}');
// print('Q2: ${organizations.first.getHighestPaidEmployee()}');
// print('Q2: ${organizations.first.getHighestPaidEmployee()}');
// print('Q2: ${organizations.first.getHighestPaidEmployee()}');
// print('Q2: ${organizations.first.getHighestPaidEmployee()}');
// print('Q2: ${organizations.first.getHighestPaidEmployee()}');
// print('Q2: ${organizations.first.getHighestPaidEmployee()}');
// print('Q2: ${organizations.first.getHighestPaidEmployee()}');
// print('Q2: ${organizations.first.getHighestPaidEmployee()}');
// print('Q2: ${organizations.first.getHighestPaidEmployee()}');
// print('Q2: ${organizations.first.getHighestPaidEmployee()}');
// print('Q2: ${organizations.first.getHighestPaidEmployee()}');





}
