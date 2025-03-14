import 'dart:math';

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

  // 7. Get average salary per branch
  Map<String, double> getAverageSalaryPerBranch() => Map.fromEntries(
    branches.map(
      (branch) => MapEntry(
        branch.name,
        branch.employees.map((e) => e.salary).reduce((a, b) => a + b) /
            branch.employees.length,
      ),
    ),
  );

  // 8. Get employees by branch
  // int getEmployeesByBranch() =>
  //     branches.expand((e) => e.employees).map((e) => e).length;
  Map<String, List<Employee>> getEmployeesByBranch() {
    return {for (var branch in branches) branch.name: branch.employees};
  }

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
  // 14. Get median salary
  double getMedianSalary() {
    List<double> salaries =
        branches.expand((b) => b.employees.map((e) => e.salary)).toList()
          ..sort();
    int mid = salaries.length ~/ 2;
    return salaries.length.isOdd
        ? salaries[mid]
        : (salaries[mid - 1] + salaries[mid]) / 2;
  }

  // 15. Get employee count per branch
  Map<String, int> getEmployeeCountPerBranch() {
    return {for (var branch in branches) branch.name: branch.employees.length};
  }

  // 16. Get employees with salary in range
  List<Employee> getEmployeesWithSalaryInRange(double min, double max) =>
      branches
          .expand((e) => e.employees)
          .where((s) => s.salary >= min && s.salary <= max)
          .toList();

  // 17. Get total salary per branch
  Map<String, double> getTotalSalaryPerBranch() => {
    for (var b in branches)
      b.name: b.employees.map((e) => e.salary).reduce((a, b) => a + b),
  };

  // 18. Branch has employee
  bool hasEmployee(String employeeId) =>
      branches.any((b) => b.employees.any((e) => e.id == employeeId));

  // 19. Get employees with ID prefix
  List<Employee> getEmployeesWithIdPrefix(String prefix) =>
      branches
          .expand((b) => b.employees)
          .where((e) => e.id.startsWith(prefix))
          .toList();

  // 20. Is any employee earning below
  bool isAnyEmployeeEarningBelow(double threshold) =>
      branches.expand((b) => b.employees).any((e) => e.salary < threshold);

  // 21. Get employees with odd ID
  List<Employee> getEmployeesWithOddId() =>
      branches
          .expand((b) => b.employees)
          .where((e) => int.tryParse(e.id) != null && int.parse(e.id) % 2 != 0)
          .toList();

  // 22. Get total employees with salary in range
  int getTotalEmployeesWithSalaryInRange(double min, double max) =>
      getEmployeesWithSalaryInRange(min, max).length;

  // 23. Get Nth highest paid employee
  Employee getNthHighestPaidEmployee(int n) {
    List<Employee> sortedEmployees =
        getEmployeesSortedBySalary().reversed.toList();
    return sortedEmployees[n - 1];
  }

  // 24. Get average salary of employees
  double getAverageSalaryOfEmployees() =>
      getTotalSalaryExpenditure() / getTotalEmployees();

  // 25. Get employees not in a branch
  List<Employee> getEmployeesNotInBranch(String branchId) =>
      branches
          .where((b) => b.id != branchId)
          .expand((b) => b.employees)
          .toList();

  // 26. Get branch IDs with salary above
  List<String> getBranchIdsWithSalaryAbove(double threshold) =>
      branches
          .where((b) => b.employees.any((e) => e.salary > threshold))
          .map((b) => b.id)
          .toList();

  // 27. Do all branches have employees
  bool doAllBranchesHaveEmployees() =>
      branches.every((b) => b.employees.isNotEmpty);

  // 28. Get branches with employees above salary
  List<String> getBranchesWithEmployeesAboveSalary(double threshold) =>
      branches
          .where((b) => b.employees.any((e) => e.salary > threshold))
          .map((b) => b.name)
          .toList();

  // 29. Get unique employees by name
  Set<String> getUniqueEmployeesByName() =>
      branches.expand((b) => b.employees).map((e) => e.name).toSet();
}

void main() {
  var employees1 = [
    Employee("1", "Alice", 50000),
    Employee("2", "Bob", 60000),
    Employee("3", "Charlie", 55000),
  ];

  var employees2 = [Employee("4", "David", 70000), Employee("5", "Eve", 65000)];

  var employees3 = [Employee("6", "Frank", 48000)];

  var branches = [
    Branch("B1", "Branch 1", employees1),
    Branch("B2", "Branch 2", employees2),
    Branch("B3", "Branch 3", employees3),
  ];

  var org = Organization("Tech Corp", branches);

  print("1)Total Employees: ${org.getTotalEmployees()}");
  print("2)Total Salary Expenditure: ${org.getTotalSalaryExpenditure()}");
  print("3)Highest Paid Employee: ${org.getHighestPaidEmployee().name}");
  print(
    "4)Employees Sorted by Salary: ${org.getEmployeesSortedBySalary().map((e) => e.name).toList()}",
  );
  print(
    "5)Employees Earning Above 5000: ${org.getEmployeesEarningAbove(5000).map((e) => e.name).toList()}",
  );
  print(
    "6)Branches with min employees (2): ${org.getBranchesWithMinEmployees(2).map((b) => b.name).toList()}",
  );
  print("7)Average Salary Per Branch: ${org.getAverageSalaryPerBranch()}");
  print("8)Employees By Branch: ${org.getEmployeesByBranch()}");
  print(
    "9)Branch with highest avg salary: ${org.getBranchWithHighestAverageSalary()}",
  );
  print("10)Total Branches: ${org.getTotalBranches()}");
  print("11)Top 3 Salaries: ${org.getTopNSalaries(3)}");
  print("12)Is Employee in Branch: ${org.isEmployeeInBranch('1', 'B1')}");
  print(
    "13)Employees with Name 'Alice': ${org.getEmployeesWithName('Alice').map((e) => e.name).toList()}",
  );
  print("14)Median Salary: ${org.getMedianSalary()}");
  print("15)Employee Count Per Branch: ${org.getEmployeeCountPerBranch()}");
  print(
    "16)Employees with Salary in Range (4000-7000): ${org.getEmployeesWithSalaryInRange(4000, 7000).map((e) => e.name).toList()}",
  );
  print("17)Total Salary Per Branch: ${org.getTotalSalaryPerBranch()}");
  print("18)Has Employee with ID '3': ${org.hasEmployee('3')}");
  print(
    "19)Employees with ID Prefix '1': ${org.getEmployeesWithIdPrefix('1').map((e) => e.name).toList()}",
  );
  print(
    "20)Is Any Employee Earning Below 3000: ${org.isAnyEmployeeEarningBelow(3000)}",
  );
  print(
    "21)Employees with Odd ID: ${org.getEmployeesWithOddId().map((e) => e.name).toList()}",
  );
  print(
    "22)Total Employees in Salary Range (4000-8000): ${org.getTotalEmployeesWithSalaryInRange(4000, 8000)}",
  );
  print(
    "23)3rd Highest Paid Employee: ${org.getNthHighestPaidEmployee(3).name}",
  );
  print("24)Average Salary of Employees: ${org.getAverageSalaryOfEmployees()}");
  print(
    "25)Employees Not in Branch 'B1': ${org.getEmployeesNotInBranch('B1').map((e) => e.name).toList()}",
  );
  print(
    "26)Branch IDs with Salary Above 6000: ${org.getBranchIdsWithSalaryAbove(6000)}",
  );
  print(
    "27)Do All Branches Have Employees: ${org.doAllBranchesHaveEmployees()}",
  );
  print(
    "28)Branches with Employees Earning Above 7000: ${org.getBranchesWithEmployeesAboveSalary(7000)}",
  );
  print("29)Unique Employee Names: ${org.getUniqueEmployeesByName()}");
}
