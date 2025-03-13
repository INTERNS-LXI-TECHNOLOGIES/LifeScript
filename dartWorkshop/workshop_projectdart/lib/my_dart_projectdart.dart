

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
    double getAverageSalaryPerBranch() {
  List<double> salaries = branches
      .expand((branch) => branch.employees
      .map((emp) => emp.salary)).toList();

  return salaries.fold(0, (a, b) => a + b) / (salaries.length);
}



  // 8. Get employees by branch
 // getEmployeesByBranch() 
 Map<String, List<Employee>> getEmployeesByBranch() {
  return {
    for (var branch in branches) 
    branch.name: branch.employees};
}

  // 9. Get branch with highest average salary
 // getBranchWithHighestAverageSalary() =>
Map<String,List<Employee>> getBranchWithHighestAverageSalary() =>branches.expand((b)=>b.employees)
.reduce(a,b)=>(a+b);
    
  // 10. Get total number of branches
  // getTotalBranches() 
  int getTotalBranches() => branches.length;


// 11. Get top N salaries
  // getTopNSalaries(int n) 
  List<double> getTopNSalaries(int n) {
  return branches
      .expand((branch) => branch.employees) 
      .map((e) => e.salary)                
      .toList()                              
      ..sort((a, b) => b.compareTo(a))       
      .take(n)                               
      .toList();                             
}



  // 12 Is employee in branch
  // isEmployeeInBranch(String employeeId, String branchId) 
  
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
  

  // 16. Get employees with salary in range
  //getEmployeesWithSalaryInRange(double min, double max)
  

  // 17. Get total salary per branch
  //getTotalSalaryPerBranch() 
  
  // 18. Branch has employee
  //hasEmployee(String employeeId)
  
  

  //19. Get employees with id prefix
  //getEmployeesWithIdPrefix(String prefix)
  

  
  // 20. Is any employee earning below
  //isAnyEmployeeEarningBelow(double threshold)
  
  // 21. Get employees with odd id
  //getEmployeesWithOddId()
  
  // 22. Get total employees with salary in range
  //getTotalEmployeesWithSalaryInRange(double min, double max) 
  
  // 23. Get Nth highest paid employee
  //getNthHighestPaidEmployee(int n) 
  

  // 24. Get average salary of employees
  //getAverageSalaryOfEmployees()
  
 // 25. Get employees not in branch
  //getEmployeesNotInBranch(String branchId) 
  
  // 26. Get branch ids with salary above
  //getBranchIdsWithSalaryAbove(double threshold)
  
  // 27. Do all branches have employees
  //doAllBranchesHaveEmployees()
  
  // 28. Get branches with employees above salary
  //getBranchesWithEmployeesAboveSalary(double threshold)
  
  // 29. Get unique employees by name
  //getUniqueEmployeesByName()

}
 
