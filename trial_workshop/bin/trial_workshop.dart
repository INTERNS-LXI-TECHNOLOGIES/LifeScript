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
//print('4) Employees sorted by salary: ${organization[0].getEmployeesSortedBySalary()}');
print('5) Employees earning above 50000: ${organization[0].getEmployeesEarningAbove(50000)}');
print('6) Branch with at least 3 employees: ${organization[0].getBranchesWithMinEmployees(3).name}');
print('7) Average salary per branch: ${organization[0].getBranchWithHighestAverageSalary()}');
print('8) Employees by branch: ${organization[0].getEmployeesByBranch()}');
print('9) Branch with highest average salary: ${organization[0].getBranchWithHighestAverageSalary()}');
print('10) Total number of branches: ${organization[0].getTotalBranches()}');
print('13) Employees with name: ${organization[0].getEmployeesWithName("Abi")}');
print('14) Median salary: ${organization[0].getMedianSalary()}');


}



// Define Organization, Branch, and Employee models
class Employee {
  final String id;
  final String name;
  final double salary;

  Employee(this.id, this.name, this.salary);
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
     

  // // 4. Get employees sorted by salary
 // List<Employee> getEmployeesSortedBySalary() => branches.expand((e) => e.employees).toList()..sort((a,b) => a.salary.compareTo(b.salary));
                
      
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
 

   
      

  
 
