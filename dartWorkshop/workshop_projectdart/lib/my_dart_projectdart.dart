

// Define Organization, Branch, and Employee models
import 'package:collection/collection.dart';

class Employee {
  final String id;
  final String name;
  final double salary;

  Employee(this.id, this.name, this.salary);
  @override
  String toString() {
    return 'Employee(id: $id, name: $name, salary: $salary)';
  }
}
 
class Branch {
  final String id;
  final String name;
  final List<Employee> employees;

  Branch(this.id, this.name, this.employees);
}

class Organization {
  final String name;
  final List<Branch> branches;

  Organization(this.name, this.branches);

  
  // 1. Get total employees in the organization
  // getTotalEmployees() 
  int getTotalEmployees()=> branches.expand((a)=>a.employees).length;



  // 2. Get total salary expenditure
  // getTotalSalaryExpenditure()
      double getTotalSalaryExpenditure()=> branches.expand((a)=>a.employees)
       .map((emp) => emp.salary)
       .reduce((a, b) => a + b);

  // 3. Find highest-paid employee
  // getHighestPaidEmployee() 
  Employee? getHighestPaidEmployee()=> branches.expand((a)=>a.employees)
         .reduce((a, b) => a.salary > b.salary ? a : b);
       


  // 4. Get employees sorted by salary
  // getEmployeesSortedBySalary()
    List<Employee> getEmployeesSortedBySalary() {
  List<Employee> sortedList = branches.expand((a) => a.employees).toList();
  sortedList.sort((a, b) => a.salary.compareTo(b.salary));
  return sortedList;
}

  // 5. Find employees earning more than a threshold
  //getEmployeesEarningAbove(double threshold) 
   List<Employee> getEmployeesEarningAbove(double threshold) => branches.expand((a) => a.employees)
       .where((emp) => emp.salary > threshold)
       .toList();

  // 6. Find branches with at least N employees
  //getBranchesWithMinEmployees(int minEmployees) 
     List<Employee> getBranchesWithMinEmployees(int minEmployees) {
      return branches
      .expand((a) => a.employees)
      .where((emp) => emp.name == minEmployees)
      .toList();
     }

  // 7. Get average salary per branch
 // getAverageSalaryPerBranch()
    Map<String , double> getAverageSalaryPerBranch() => Map.fromEntries(branches.map((branch)
     => MapEntry(branch.name , branch.employees.map((e) =>
      e.salary).reduce((a,b) =>a+b)/branch.employees.length)));



  // 8. Get employees by branch
 // getEmployeesByBranch() 
 Map<String, List<Employee>> getEmployeesByBranch() {
  return {
    for (var branch in branches) 
    branch.name: branch.employees};
}

  // 9. Get branch with highest average salary
 // getBranchWithHighestAverageSalary() =>
double getBranchWithHighestAverageSalary() => branches.expand((e) => 
e.employees).map((f) => f.salary).reduce((a, b) => a+b) / branches.expand((h) =>
 h.employees).map((g) => g).length;
    
  // 10. Get total number of branches
  // getTotalBranches() 
  int getTotalBranches() => branches.length;


// 11. Get top N salaries
  // getTopNSalaries(int n) 
   List<double> getTopNSalaries(int n) {
     List<double> salaries = branches.expand((e) =>
      e.employees)
     .map((f) => f.salary).toList();
     salaries.sort((a, b) => b.compareTo(a));
     return salaries.take(n).toList();
   }



  // 12 Is employee in branch
  // isEmployeeInBranch(String employeeId, String branchId) 
 bool isEmployeeInBranch(String employeeId, String branchId) => 
 branches.where((branch) => branch.id == branchId).expand((f) =>
  f.employees).any((employee) => employee.id == employeeId);
  
  // 13. Get employees with name
  //getEmployeesWithName(String name)
  List<Employee> getEmployeesWithName(String name) {
  return branches
      .expand((branch) => branch.employees) 
      .where((employee) => employee.name == name)
      .toList(); 
}


  // 14. Get median salary
  
  //double getMedianSalary() 
    
  
  // 15. Get employee count per branch
  //getEmployeeCountPerBranch() 
Map<String, int> getEmployeeCountPerBranch() {
  return {for (var branch in branches) branch.name: branch.employees.length};
}


  // 16. Get employees with salary in range
  //getEmployeesWithSalaryInRange(double min, double max)
  List<Employee> getEmployeesWithSalaryInRange(double min, double max) {
  return branches
      .expand((branch) => branch.employees) 
      .where((employee) => employee.salary >= min && employee.salary <= max) 
      .toList(); 
}

  

  // 17. Get total salary per branch
  //getTotalSalaryPerBranch() 

  Map<String, double> getTotalSalaryPerBranch() {
  return {
    for (var branch in branches)
      branch.name: branch.employees.fold(0, (sum, employee) => sum + employee.salary)
  };
}

  
  // 18. Branch has employee
  //hasEmployee(String employeeId)
  
  bool hasEmployee(String employeeId) {
  return branches
      .expand((branch) => branch.employees) 
      .any((employee) => employee.id == employeeId); 
}


  //19. Get employees with id prefix
  //getEmployeesWithIdPrefix(String prefix)
  List<Employee> getEmployeesWithIdPrefix(String prefix) {
  return branches
      .expand((branch) => branch.employees)
      .where((employee) => employee.id.startsWith(prefix)) 
      .toList(); 
}


  
  // 20. Is any employee earning below
  //isAnyEmployeeEarningBelow(double threshold)

  bool isAnyEmployeeEarningBelow(double threshold) {
  return branches
      .expand((branch) => branch.employees) 
      .any((employee) => employee.salary < threshold); 
}

  
  // 21. Get employees with odd id
  //getEmployeesWithOddId()

    List<Employee> getEmployeesWithOddId() => branches.expand((e) =>
     e.employees).where((e) => int.tryParse(e.id.replaceAll(RegExp(r'[^0-9]'), ''))! % 2 != 0).toList();
  
  
  // 22. Get total employees with salary in range
  //getTotalEmployeesWithSalaryInRange(double min, double max) 
  int getTotalEmployeesWithSalaryInRange(double min, double max) {
  return branches
      .expand((branch) => branch.employees) 
      .where((employee) => employee.salary >= min && employee.salary <= max) 
      .length; 
}

  
  // 23. Get Nth highest paid employee
  //getNthHighestPaidEmployee(int n) 
   List<Employee> getNthHighestPaidEmployee(int n) {
  
  List<Employee> employees = branches.expand((e) => e.employees).toList();
    employees.sort((a, b) => b.salary.compareTo(a.salary));
    return employees.take(n).toList();
  }

  // 24. Get average salary of employees
  //getAverageSalaryOfEmployees()

    double getAverageSalaryOfEmployees() => branches.expand((e) => 
    e.employees).map((e) => e.salary).reduce((a, b) => a + b) / branches.expand((e) => 
    e.employees).map((e) => e).length;
  
 // 25. Get employees not in branch
  //getEmployeesNotInBranch(String branchId) 

  List<Employee> getEmployeesNotInBranch(String branchId) {
  return branches
      .where((branch) => branch.id != branchId)
      .expand((branch) => branch.employees) 
      .toList();
}
  
  // 26. Get branch ids with salary above
  //getBranchIdsWithSalaryAbove(double threshold)
   List<String> getBranchIdsWithSalaryAbove(double threshold) => branches
   .where((b) => b.employees.any((e) => 
   e.salary > threshold)).map((c) => c.id).toList();

  
  // 27. Do all branches have employees
  //doAllBranchesHaveEmployees()
   bool doAllBranchesHaveEmployees() => branches.every((e) => e.employees.isNotEmpty);

  
  // 28. Get branches with employees above salary
  //getBranchesWithEmployeesAboveSalary(double threshold)

    List<Branch> getBranchesWithEmployeesAboveSalary(double threshold) => branches
    .where((e) => e.employees.any((f) => 
    f.salary > threshold)).toList();

  
  // 29. Get unique employees by name
  //getUniqueEmployeesByName()
  List<Employee> getUniqueEmployeesByName() {
     var emp = <String>{};
    return branches.expand((e) => e.employees).where((employee) => emp.add(employee.name)).toList();

}
 
}