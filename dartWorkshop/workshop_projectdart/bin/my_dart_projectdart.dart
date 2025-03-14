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
print('Q5: ${organizations.first.getHighestPaidEmployee()}');
print('Q6: ${organizations.first.getTotalEmployees()}');
print('Q7: ${organizations.first.getTotalSalaryExpenditure()}');
print('Q8: ${organizations.first.getEmployeesSortedBySalary()}');
print('Q9: ${organizations.first.getEmployeesEarningAbove(6000)}');
print('Q10: ${organizations.first.getTotalBranches()}');
print('Q11: ${organizations.first.getTopNSalaries(10000)}');

print('Q13: ${organizations.first.getEmployeesWithName("Abi")}');

print('Q15: ${organizations.first.getEmployeesByBranch()}');
print('Q16: ${organizations.first.getEmployeesEarningAbove(50000)}');
print('Q17: ${organizations.first.getTotalSalaryPerBranch()}');
print('Q18: ${organizations.first.hasEmployee("Employee1")}');
print('Q19: ${organizations.first.getHighestPaidEmployee()}');
print('Q20: ${organizations.first.isAnyEmployeeEarningBelow(50000)}');
print('Q21: ${organizations.first.getEmployeesWithOddId()}');
print('Q22: ${organizations.first.getEmployeesEarningAbove(50000)}');
print('Q23: ${organizations.first.getNthHighestPaidEmployee(2)}');
print('Q24: ${organizations.first.getAverageSalaryOfEmployees()}');
print('Q25: ${organizations.first.getEmployeesNotInBranch("BranchOne")}');
print('Q26: ${organizations.first.getBranchIdsWithSalaryAbove(50000)}');
print('Q27: ${organizations.first.doAllBranchesHaveEmployees()}');
print('Q28: ${organizations.first.getBranchWithHighestAverageSalary()}');
print('Q29: ${organizations.first.getEmployeesWithName("Abi")}');




}
