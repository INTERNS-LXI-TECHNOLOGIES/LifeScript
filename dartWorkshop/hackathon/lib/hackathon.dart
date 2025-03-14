// Define Organization, Branch, and Employee models
class Employee {
  final String id;
  final String name;
  final double salary;

  Employee(this.id, this.name, this.salary);
  String toString() => 'Employee(id: $id, name: $name, salary: $salary)';
}

class Branch {
  final String id;
  final String name;
  final List<Employee> employees;

  Branch(this.id, this.name, this.employees);
  String toString() =>
      'Branch(id: $id, name: $name, employees: ${employees.length})';
}

class Organization {
  final String name;
  final List<Branch> branches;

  Organization(this.name, this.branches);

  String toString() =>
      'Organization(name: $name, branches: ${branches.length})';

 

  // 1. Get total employees in the organization
  // getTotalEmployees() 
  int getTotalEmployees() => branches.expand((n) => n.employees).length;

  // 2. Get total salary expenditure
  // getTotalSalaryExpenditure()
  double getTotalSalaryExpenditure() =>branches.expand((a)=> a.employees).map((a)=>a.salary).reduce((a,b)=> a+b);


  // 3. Find highest-paid employee
  // getHighestPaidEmployee() 
  Employee? getHighestPaidEmployee() => branches.expand((n) => n.employees).reduce((a, b) => a.salary > b.salary ? a : b);

  // 4. Get employees sorted by salary
  // getEmployeesSortedBySalary()

  List <Employee> getEmployeesSortedBySalary() {
    List<Employee> employees = branches.expand((n) => n.employees).toList();
    employees.sort((a, b) => a.salary.compareTo(b.salary));
    return employees;
  }

  // 5. Find employees earning more than a threshold
  //getEmployeesEarningAbove(double threshold) 
  List<bool> getEmployeesEarningAbove(double threshold){
    var allAmployee = branches.expand((a)=>a.employees).toList();
    return allAmployee.map((a)=>a.salary>threshold).toList();
  }

  // 6. Find branches with at least N employees
  //getBranchesWithMinEmployees(int minEmployees) 
List<Branch> getBranchesWithMinEmployees(int minEmployees) => branches.where((a)=> a.employees.length>=minEmployees).toList();

  // 7. Get average salary per branch
 // getAverageSalaryPerBranch()
Map<String,double> getAverageSalaryPerBranch()=> {for(var bName in branches) bName.name: bName.employees.map((n)=>n.salary).reduce((a,b)=>a+b)/bName.employees.length};


  // 8. Get employees by branch
 // getEmployeesByBranch() 
 Map<String, List<Employee>> getEmployeesByBranch() => {for (var b in branches) b.name: b.employees};

  // 9. Get branch with highest average salary
 // getBranchWithHighestAverageSalary()

  Branch  getBranchWithHighestAverageSalary(){
    double avg(Branch b) => b.employees.map((e) => e.salary).reduce((a, b) => a + b) / b.employees.length;
    return branches.reduce((a, b) => avg(a) > avg(b) ? a : b);
  }

    
  // 10. Get total number of branches
  // getTotalBranches() 
  int getTotalBranches() => branches.length;

// 11. Get top N salaries
  // getTopNSalaries(int n) 

  List <double> getTopNSalaries(int n) {
    var allEmployees = branches.expand((n)=> n.employees).toList();
    allEmployees.sort((a,b)=>b.salary.compareTo(a.salary));
    return allEmployees.take(n).map((s)=>s.salary).toList();
  }
  // 12 Is employee in branch
  // isEmployeeInBranch(String employeeId, String branchId) 

  bool isEmployeeInBranch(String employeeId, String branchId) =>branches.any((a)=>a.id==branchId && a.employees.any((a)=>a.id==employeeId));

  
  // 13. Get employees with name
  //getEmployeesWithName(String name)
List <Employee> getEmployeesWithName(String name)=>branches.expand((a)=> a.employees).where((a)=> a.name==name).toList();

  // 14. Get median salary
  //double getMedianSalary() 
    double getMedianSalary() {
    var sorted = getEmployeesSortedBySalary();
    int mid = sorted.length ~/ 2;
    return sorted.length.isOdd ? sorted[mid].salary : (sorted[mid - 1].salary + sorted[mid].salary) / 2;
  }
    
  
  // 15. Get employee count per branch
  //getEmployeeCountPerBranch() 
  Map<String, int> getEmployeeCountPerBranch()=> {for(var bName in branches)bName.name: bName.employees.length};
  

  // 16. Get employees with salary in range
  //getEmployeesWithSalaryInRange(double min, double max)
  List<Employee> getEmployeesWithSalaryInRange(double min, double max) => branches.expand((a) => a.employees).where((a)=>a.salary<=max && a.salary>=min).toList();
  
  

  // 17. Get total salary per branch
  //getTotalSalaryPerBranch() 

  Map<String,double>getTotalSalaryPerBranch() =>{for(var bName in branches) bName.name:bName.employees.map((n)=>n.salary).reduce((a,b)=>a+b)};
  
  // 18. Branch has employee
  //hasEmployee(String employeeId)
  
bool hasEmployee(String employeeId)=> branches.expand((a)=> a.employees).any((a)=>a.id==employeeId);
  

  //19. Get employees with id prefix
  //getEmployeesWithIdPrefix(String prefix)
  
  List<Employee> getEmployeesWithIdPrefix(String prefix)=> branches.expand((n)=>n.employees).where((e)=>e.id.startsWith(prefix)).toList();
  
  // 20. Is any employee earning below
  //isAnyEmployeeEarningBelow(double threshold)
  List<Employee> isAnyEmployeeEarningBelow(double threshold)=> branches.expand((a)=>a.employees).where((a)=>a.salary<threshold).toList();
  
  // 21. Get employees with odd id
  //getEmployeesWithOddId()
  List<Employee> getEmployeesWithOddId(String id) =>
      branches.expand((b) => b.employees).where((e) => int.tryParse(e.id)?.isOdd ?? false).toList();
  
  // 22. Get total employees with salary in range
  //getTotalEmployeesWithSalaryInRange(double min, double max) 
  List<Employee> getTotalEmployeesWithSalaryInRange(double min, double max) => branches.expand((a) => a.employees).where((a)=>a.salary<=max && a.salary>=min).toList();
  
  // 23. Get Nth highest paid employee
  //getNthHighestPaidEmployee(int n) 
  
  List<Employee> getNthHighestPaidEmployee(int n) {
    var nthEmployees = branches.expand((a)=>a.employees).toList();
    nthEmployees.sort((a,b)=> b.salary.compareTo(a.salary));
    return nthEmployees.take(n).toList();
  }
  
  // 24. Get average salary of employees
  //getAverageSalaryOfEmployees()

  double getAverageSalaryOfEmployees() =>branches.expand((a)=>a.employees).map((a)=>a.salary).reduce((a,b)=>a+b)/getTotalEmployees();

 // 25. Get employees not in branch
  //getEmployeesNotInBranch(String branchId) 
  List<Employee>  getEmployeesNotInBranch(String branchId) =>branches.expand((a)=>a.employees).where((a)=> a.id==branchId).toList();
  
  // 26. Get branch ids with salary above
  //getBranchIdsWithSalaryAbove(double threshold)
 List<String>getBranchIdsWithSalaryAbove(double threshold)=> branches.expand((a)=> a.employees).where((a)=>a.salary>threshold).map((a)=>a.id).toList();

  
  // 27. Do all branches have employees
  //doAllBranchesHaveEmployees()
  bool doAllBranchesHaveEmployees() =>branches.every((a)=>a.employees.isNotEmpty);   
  
  // 28. Get branches with employees above salary
  //getBranchesWithEmployeesAboveSalary(double threshold)
  List<bool> getBranchesWithEmployeesAboveSalary(double threshold)=> branches.expand((a)=> a.employees).map((a)=> a.salary>threshold).toList();
  
  // 29. Get unique employees by name
  //getUniqueEmployeesByName()
// 29. Get unique employees by name
Set<String> getUniqueEmployeesByName()=>branches.expand((a)=> a.employees.map((e)=> e.name)).toSet();

}