void main() {
  var emp1 = Employee("E1", "Alice", 50000);
  var emp2 = Employee("E2", "Bob", 60000);
  var emp3 = Employee("E3", "Charlie", 55000);
  var emp4 = Employee("E4", "David", 70000);
  var emp5 = Employee("E5", "Eve", 65000);
  var emp6 = Employee("E6", "Frank", 48000);

  var branch1 = Branch("B1", "Branch 1", [emp1, emp2, emp3]);
  var branch2 = Branch("B2", "Branch 2", [emp4, emp5]);
  var branch3 = Branch("B3", "Branch 3", [emp6]);

  var organization = Organization("MyOrg", [branch1, branch2, branch3]);

  print("1)Total Employees: ${organization.getTotalEmployees()}");
  print(
    "2)Total Salary Expenditure: ${organization.getTotalSalaryExpenditure()}",
  );
  print(
    "3)Highest Paid Employee: ${organization.getHighestPaidEmployee().name}",
  );
  print(
    "4)Employees Sorted by Salary: ${organization.getEmployeesSortedBySalary().map((e) => e.name).toList()}",
  );
  print(
    "5)Employees Earning Above 55000: ${organization.getEmployeesEarningAbove(55000).map((e) => e.name).toList()}",
  );
  print(
    "6)Branches with at least 2 employees: ${organization.getBranchesWithMinEmployees(2).map((b) => b.name).toList()}",
  );
  // print(
  //   "7)Average Salary Per Branch: ${organization.getAverageSalaryPerBranch()}",
  // );
  print("8)Employees by Branch: ${organization.getEmployeesByBranch()}");
  print(
    "9)Branch with Highest Average Salary: ${organization.getBranchWithHighestAverageSalary()}",
  );
  print("10)Total Branches: ${organization.getTotalBranches()}");
  print("11)Top 3 Salaries: ${organization.getTopNSalaries(3)}");

  print(
    "12)Is Employee 'E1' in Branch 'B1'? ${organization.isEmployeeInBranch('E1', 'B1')}",
  );
  print(
    '13) Employees with name: ${organization.getEmployeesWithName("Alice")}',
  );
  print(
    "15)Employee count per branch: ${organization.getEmployeeCountPerBranch()}",
  );
}

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

  // 1. Get total employees

  int getTotalEmployees() => branches.expand((a) => a.employees).length;

  // 2. Get total salary expenditure
  double getTotalSalaryExpenditure() => branches
      .expand((a) => a.employees)
      .map((b) => b.salary)
      .reduce((c, d) => c + d);

  // 3. Find highest-paid employee
  Employee getHighestPaidEmployee() => branches
      .expand((b) => b.employees)
      .reduce((a, b) => a.salary > b.salary ? a : b);

  // 4. Get employees sorted by salary
  List<Employee> getEmployeesSortedBySalary() =>
      branches.expand((b) => b.employees).toList()
        ..sort((a, b) => a.salary.compareTo(b.salary));

  // 5. Find employees earning more than a threshold
  List<Employee> getEmployeesEarningAbove(double threshold) =>
      branches
          .expand((b) => b.employees)
          .where((e) => e.salary > threshold)
          .toList();

  // 6. Find branches with at least N employees
  List<Branch> getBranchesWithMinEmployees(int minEmployees) =>
      branches.where((b) => b.employees.length >= minEmployees).toList();

  // // 7. Get average salary per branch
  // // getAverageSalaryPerBranch()

  // // getAverageSalaryPerBranch()
  // double getAverageSalaryPerBranch() {
  //   List<double> salaries =
  //       branches
  //           .expand((branch) => branch.employees.map((emp) => emp.salary))
  //           .toList();
  //   return salaries.fold(0, (a, b) => a + b) / (salaries.length);
  // }

  // 8. Get employees by branch
  int getEmployeesByBranch() =>
      branches.expand((e) => e.employees).map((e) => e).length;

  // 9. Get branch with highest average salary
  double getBranchWithHighestAverageSalary() =>
      branches
          .expand((e) => e.employees)
          .map((f) => f.salary)
          .reduce((a, b) => a + b) /
      branches.expand((h) => h.employees).map((g) => g).length;

  // 10. Get total number of branches
  int getTotalBranches() => branches.map((e) => e).length;

  // 11. Get top N salaries
  List<double> getTopNSalaries(int n) {
    List<double> salaries =
        branches.expand((e) => e.employees).map((f) => f.salary).toList();
    salaries.sort((a, b) => b.compareTo(a));
    return salaries.take(n).toList();
  }

  // 12 Is employee in branch
  bool isEmployeeInBranch(String employeeId, String branchId) => branches
      .where((branch) => branch.id == branchId)
      .expand((f) => f.employees)
      .any((employee) => employee.id == employeeId);
  // 13. Get employees with name
  List<Employee> getEmployeesWithName(String name) =>
      branches.expand((e) => e.employees).where((f) => f.name == name).toList();
  // 15. Get employee count per branch
  Map<String, int> getEmployeeCountPerBranch() {
    return {for (var branch in branches) branch.name: branch.employees.length};
  }
}
