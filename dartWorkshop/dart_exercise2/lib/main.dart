void main() {
  List<Map<String, dynamic>> employees = [
    {'empno': 1001, 'ename': 'John', 'sal': 45000, 'deptno': 1},
    {'empno': 1002, 'ename': 'Jane', 'sal': 55000, 'deptno': 1},
    {'empno': 1003, 'ename': 'David', 'sal': 60000, 'deptno': 2},
    {'empno': 1004, 'ename': 'Lucy', 'sal': 30000, 'deptno': 2},
    {'empno': 1005, 'ename': 'Afsal', 'sal': 50000, 'deptno': 3},
    {'empno': 1006, 'ename': 'Michael', 'sal': 70000, 'deptno': 3},
    {'empno': 1007, 'ename': 'Sophia', 'sal': 35000, 'deptno': 1},
    {'empno': 1008, 'ename': 'Afsal', 'sal': 48000, 'deptno': 2},
  ];

  List<Map<String, dynamic>> departments = [
    {'deptno': 1, 'dname': 'HR'},
    {'deptno': 2, 'dname': 'Finance'},
    {'deptno': 3, 'dname': 'IT'},
  ];

  print("1. Total employees in the organization: ${employees.length}");
  print("2. Total salary expenditure: ${getTotalSalaryExpenditure(employees)}");
  print("3. Highest-paid employee: ${getHighestPaidEmployee(employees)}");
  print(
    "4. Employees sorted by salary: ${getEmployeesSortedBySalary(employees)}",
  );
  print(
    "5. Employees earning above 30000: ${getEmployeesEarningAbove(employees, 30000)}",
  );

  print("10. Total number of departments: ${departments.length}");
  print(
    "12. Is employee 1002 in department 1? ${isEmployeeInDepartment(employees, 1002, 1)}",
  );
  print(
    "13. Employees named 'Afsal': ${getEmployeesWithName(employees, 'Afsal')}",
  );

  print(
    "15. Employee count per department: ${getEmployeeCountPerDepartment(employees, departments)}",
  );
  print(
    "16. Employees with salary in range 25000-50000: ${getEmployeesWithSalaryInRange(employees, 25000, 50000)}",
  );
  print(
    "18. Does department 1 have employees? ${hasEmployeeInDepartment(employees, 1)}",
  );
  print(
    "19. Employees with ID prefix '10': ${getEmployeesWithIdPrefix(employees, '10')}",
  );
  print(
    "20. Is any employee earning below 25000? ${isAnyEmployeeEarningBelow(employees, 25000)}",
  );
}

int getTotalSalaryExpenditure(List<Map<String, dynamic>> employees) {
  return employees.fold(0, (sum, e) => sum + (e['sal'] as int));
}

Map<String, dynamic> getHighestPaidEmployee(
  List<Map<String, dynamic>> employees,
) {
  return employees.reduce(
    (a, b) => (a['sal'] as int) > (b['sal'] as int) ? a : b,
  );
}

List<Map<String, dynamic>> getEmployeesSortedBySalary(
  List<Map<String, dynamic>> employees,
) {
  return [...employees]
    ..sort((a, b) => (b['sal'] as int).compareTo(a['sal'] as int));
}

List<Map<String, dynamic>> getEmployeesEarningAbove(
  List<Map<String, dynamic>> employees,
  int threshold,
) {
  return employees.where((e) => (e['sal'] as int) > threshold).toList();
}

bool isEmployeeInDepartment(
  List<Map<String, dynamic>> employees,
  int empId,
  int deptId,
) {
  return employees.any((e) => e['empno'] == empId && e['deptno'] == deptId);
}

List<Map<String, dynamic>> getEmployeesWithName(
  List<Map<String, dynamic>> employees,
  String name,
) {
  return employees.where((e) => e['ename'] == name).toList();
}

Map<int, int> getEmployeeCountPerDepartment(
  List<Map<String, dynamic>> employees,
  List<Map<String, dynamic>> departments,
) {
  return {
    for (var d in departments)
      d['deptno'] as int:
          employees.where((e) => e['deptno'] == d['deptno']).length,
  };
}

List<Map<String, dynamic>> getEmployeesWithSalaryInRange(
  List<Map<String, dynamic>> employees,
  int min,
  int max,
) {
  return employees.where((e) {
    int salary = e['sal'] as int;
    return salary >= min && salary <= max;
  }).toList();
}

bool hasEmployeeInDepartment(List<Map<String, dynamic>> employees, int deptId) {
  return employees.any((e) => e['deptno'] == deptId);
}

List<Map<String, dynamic>> getEmployeesWithIdPrefix(
  List<Map<String, dynamic>> employees,
  String prefix,
) {
  return employees
      .where((e) => e['empno'].toString().startsWith(prefix))
      .toList();
}

bool isAnyEmployeeEarningBelow(
  List<Map<String, dynamic>> employees,
  int threshold,
) {
  return employees.any((e) => (e['sal'] as int) < threshold);
}
