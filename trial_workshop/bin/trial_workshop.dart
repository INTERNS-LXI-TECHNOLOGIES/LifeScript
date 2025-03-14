import 'dart:math';

void main(List<String> arguments) {
 

List<Organization> organization = [
                                    Organization("LXISOFT", [
                                      Branch("1", "BranchOne", [
                                          Employee("Employee1", "Abi", 90000),
                                          Employee("Employee2", "Benni", 75600),
                                          Employee("Employee3", "joe", 56070),
                                          Employee("Employee4", "hena", 64070),
                                      ]),
                                      Branch("2", "BranchTwo", [
                                          Employee("Employee5", "lisa", 12000),
                                          Employee("Employee6", "manu", 65400),
                                          Employee("Employee7", "aan", 87650),
                                      ]),
                                      Branch("3", "BranchThree", [
                                          Employee("Employee8", "hima", 43200),
                                          Employee("Employee9", "amy", 98710),
                                          Employee("Employee10", "ima", 20000),
                                      ]),
                                    ]),
                                  ];
                                  

print('1) Total employees in the organization: ${organization[0].getTotalEmployees()}');
print('2) Total salary expenditure: ${organization[0].getTotalSalaryExpenditure()}');
print('3) Highest paid employee: ${organization[0].getHighestPaidEmployee().name}');
print('4) Employees sorted by salary: ${organization[0].getEmployeesSortedBySalary()}');
print('5) Employees earning above 50000: ${organization[0].getEmployeesEarningAbove(50000)}');
print('6) Branch with at least 3 employees: ${organization[0].getBranchesWithMinEmployees(3).name}');
print('7) Average salary per branch: ${organization[0].getBranchWithHighestAverageSalary()}');
print('8) Employees by branch: ${organization[0].getEmployeesByBranch()}');
print('9) Branch with highest average salary: ${organization[0].getBranchWithHighestAverageSalary()}');
print('10) Total number of branches: ${organization[0].getTotalBranches()}');
print('13) Employees with name: ${organization[0].getEmployeesWithName("Abi")}');
print('14) Median salary: ${organization[0].getMedianSalary()}');
print('15) Employee count per branch: ${organization[0].getEmployeesByBranch()}');
print('16) Employees with salary in range: ${organization[0].getEmployeesEarningAbove(50000)}');
print('17) Total salary per branch: ${organization[0].getTotalSalaryPerBranch()}');
print('18) Branch has employee: ${organization[0].hasEmployee("Employee1")}');
print('19) Employees with id prefix: ${organization[0].getEmployeesWithIdPrefix("Employee")}');
print('20) Any employee earning below 50000: ${organization[0].isAnyEmployeeEarningBelow(50000)}');
print('21) Employees with odd id: ${organization[0].getEmployeesWithOddId()}');
print('22) Total employees with salary in range: ${organization[0].getEmployeesEarningAbove(50000)}');
print('23) Nth highest paid employee: ${organization[0].getNthHighestPaidEmployee(2)}');
print('24) Average salary of employees: ${organization[0].getAverageSalaryOfEmployees()}');
print('25) Employees not in branch: ${organization[0].getEmployeesNotInBranch("BranchOne")}');
print('26) Branch ids with salary above 50000: ${organization[0].getBranchIdsWithSalaryAbove(50000)}');
print('27) All branches have employees: ${organization[0].doAllBranchesHaveEmployees()}');
print('28) Branches with employees above salary: ${organization[0].getBranchWithHighestAverageSalary()}');
print('29) Unique employees by name: ${organization[0].getEmployeesWithName("Abi")}');


}



// Define Organization, Branch, and Employee models
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
  
   int getTotalEmployees() => branches.expand((e) => e.employees).map((f) => f).length;

   
                       

  // 2. Get total salary expenditure

  double getTotalSalaryExpenditure() => branches.expand((e)=>e.employees).map((f)=> f.salary).reduce((a,b) => a+b);

  

  // 3. Find highest-paid employee

  Employee getHighestPaidEmployee() => branches.expand((e) =>e.employees).map((f) => f).reduce((a , b) => a.salary > b.salary ? a:b );
     

 // 4. Get employees sorted by salary

 List<Employee> getEmployeesSortedBySalary() => branches.expand((e) => e.employees).toList()..sort((a,b) => a.salary.compareTo(b.salary));
                
      
  // 5. Find employees earning more than a threshold

  int getEmployeesEarningAbove(double threshold)  => branches.expand((e) => e.employees).where((e) => e.salary > threshold).length;


  // 6. Find branches with at least N employees

  Branch getBranchesWithMinEmployees(int minEmployees) => branches.firstWhere((e) => e.employees.length >= minEmployees);


  // 7. Get average salary per branch 

  Map<String , double> getAverageSalaryPerBranch() => Map.fromEntries(branches.map((branch) => MapEntry(branch.name , branch.employees.map((e) => e.salary).reduce((a,b) =>a+b)/branch.employees.length)));


  // 8. Get employees by branch

  int getEmployeesByBranch() => branches.expand((e) => e.employees).map((e) => e).length;



  // 9. Get branch with highest average salary

  double getBranchWithHighestAverageSalary() => branches.expand((e) => e.employees).map((f) => f.salary).reduce((a, b) => a+b) / branches.expand((h) => h.employees).map((g) => g).length;
    

  // 10. Get total number of branches

  int getTotalBranches() => branches.map((e) => e).length;


  // 11. Get top N salaries

  List<double> getTopNSalaries(int n) {
     List<double> salaries = branches.expand((e) => e.employees).map((f) => f.salary).toList();
     salaries.sort((a, b) => b.compareTo(a));
     return salaries.take(n).toList();
   }


  // 12 Is employee in branch

  bool isEmployeeInBranch(String employeeId, String branchId) => branches.where((branch) => branch.id == branchId).expand((f) => f.employees).any((employee) => employee.id == employeeId);
  


  // 13. Get employees with name

  List<Employee> getEmployeesWithName(String name) => branches.expand((e) => e.employees).where((f) => f.name == name).toList();



  // 14. Get median salary
  
  double getMedianSalary() {
    List<double> salaries = branches.expand((e) => e.employees).map((f) => f.salary).toList();
    salaries.sort();
    int middle = salaries.length ~/ 2;
    if (salaries.length % 2 == 1) {
      return salaries[middle];
    } else {
      return (salaries[middle - 1] + salaries[middle]) / 2.0;
    }
  }
    
  
  // 15. Get employee count per branch

  Map<String, int> getEmployeeCountPerBranch() {
    return Map.fromEntries(branches.map((e) => MapEntry(e.name, e.employees.length)));
  }
  


  // 16. Get employees with salary in range


  List<Employee> getEmployeesWithSalaryInRange(double min, double max) => branches.expand((e) => e.employees).where((emp) => emp.salary >= min && emp.salary <= max).toList();
  

  // 17. Get total salary per branch


  Map<String , double> getTotalSalaryPerBranch() => Map.fromEntries(branches.map((branch) => MapEntry(branch.name, branch.employees.map((e) => e.salary).reduce((a, b) => a + b))));


  
  // 18. Branch has employee


  bool hasEmployee(String employeeId) => branches.expand((e) => e.employees).any((e) => e.id == employeeId);  
  

  //19. Get employees with id prefix


  List<Employee> getEmployeesWithIdPrefix(String prefix) => branches.expand((e) => e.employees).where((e) =>e.id.startsWith(prefix)).toList();
  

  
  // 20. Is any employee earning below


  bool isAnyEmployeeEarningBelow(double threshold) => branches.expand((e) => e.employees).any((e) => e.salary < threshold);
  


  // 21. Get employees with odd id


  List<Employee> getEmployeesWithOddId() => branches.expand((e) => e.employees).where((e) => int.tryParse(e.id.replaceAll(RegExp(r'[^0-9]'), ''))! % 2 != 0).toList();
  


  // 22. Get total employees with salary in range


  int getTotalEmployeesWithSalaryInRange(double min, double max)  => branches.expand((e) => e.employees).where((employe) => employe.salary >= min && employe.salary <= max).length;
  

  // 23. Get Nth highest paid employee


  List<Employee> getNthHighestPaidEmployee(int n) {
  
  List<Employee> employees = branches.expand((e) => e.employees).toList();
    employees.sort((a, b) => b.salary.compareTo(a.salary));
    return employees.take(n).toList();
  }
  


  // 24. Get average salary of employees


  double getAverageSalaryOfEmployees() => branches.expand((e) => e.employees).map((e) => e.salary).reduce((a, b) => a + b) / branches.expand((e) => e.employees).map((e) => e).length;
  

 // 25. Get employees not in branch


  List<Employee> getEmployeesNotInBranch(String branchId) => branches.where((e)=>e.id != branchId).expand((f) => f.employees).toList();
  


  // 26. Get branch ids with salary above


 List<String> getBranchIdsWithSalaryAbove(double threshold) => branches.where((b) => b.employees.any((e) => e.salary > threshold)).map((c) => c.id).toList();

  

  // 27. Do all branches have employees


  bool doAllBranchesHaveEmployees() => branches.every((e) => e.employees.isNotEmpty);
  


  // 28. Get branches with employees above salary


  List<Branch> getBranchesWithEmployeesAboveSalary(double threshold) => branches.where((e) => e.employees.any((f) => f.salary > threshold)).toList();
  

  // 29. Get unique employees by name

  List<Employee> getUniqueEmployeesByName() {

    var emp = <String>{};
    return branches.expand((e) => e.employees).where((employee) => emp.add(employee.name)).toList();

  }

}
 

   
      

  
 
