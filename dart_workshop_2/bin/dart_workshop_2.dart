void main(List<String> arguments) {
  

final List<Map<String, dynamic>> employees = [
  {
    'empno': 1001,
    'ename': 'Fahad',
    'job': 'Team Lead',
    'mgr': 1005,
    'hiredate': DateTime(2022, 5, 12),
    'sal': 45000,
    'comm': null,
    'deptno': 1
  },
  {
    'empno': 1002,
    'ename': 'Fazil',
    'job': 'Full Stack Developer',
    'mgr': 1001,
    'hiredate': DateTime(2023, 3, 1),
    'sal': 28000,
    'comm': 2000,
    'deptno': 1
  },
  {
    'empno': 1003,
    'ename': 'Afsal',
    'job': 'CTO',
    'mgr': 1006,
    'hiredate': DateTime(2021, 7, 20),
    'sal': 60000,
    'comm': 5000,
    'deptno': 2
  },
  {
    'empno': 1004,
    'ename': 'Arshaf',
    'job': 'CEO',
    'mgr': null, // CEO has no manager
    'hiredate': DateTime(2020, 1, 10),
    'sal': 80000,
    'comm': null,
    'deptno': 3
  },
  {
    'empno': 1005,
    'ename': 'Avinash',
    'job': 'Team Lead',
    'mgr': 1004,
    'hiredate': DateTime(2021, 11, 8),
    'sal': 47000,
    'comm': 3000,
    'deptno': 2
  },
  {
    'empno': 1006,
    'ename': 'Sruthi',
    'job': 'Co-Founder',
    'mgr': 1004,
    'hiredate': DateTime(2020, 1, 10),
    'sal': 75000,
    'comm': null,
    'deptno': 3
  },
  {
    'empno': 1007,
    'ename': 'Sreeja',
    'job': 'Full Stack Developer',
    'mgr': 1001,
    'hiredate': DateTime(2023, 6, 15),
    'sal': 26000,
    'comm': 1500,
    'deptno': 1
  },
  {
    'empno': 1008,
    'ename': 'Arjun',
    'job': 'CTO',
    'mgr': 1004,
    'hiredate': DateTime(2021, 5, 30),
    'sal': 58000,
    'comm': 4500,
    'deptno': 3
  },
  {
    'empno': 1009,
    'ename': 'Anila',
    'job': 'Consultant',
    'mgr': 1005,
    'hiredate': DateTime(2022, 9, 22),
    'sal': 32000,
    'comm': null,
    'deptno': 4
  },
  {
    'empno': 1010,
    'ename': 'Farzeena',
    'job': 'Full Stack Developer',
    'mgr': 1005,
    'hiredate': DateTime(2023, 8, 5),
    'sal': 29000,
    'comm': 1200,
    'deptno': 4
  },
];

final List<Map<String, dynamic>> departments = [
  {'deptno': 1, 'dname': 'Software Development', 'loc': 'Bangalore'},
  {'deptno': 2, 'dname': 'Open Source Software', 'loc': 'Chennai'},
  {'deptno': 3, 'dname': 'Consulting', 'loc': 'Kochi'},
  {'deptno': 4, 'dname': 'Contracting', 'loc': 'Hyderabad'},
];

final List<Map<String, dynamic>> salGrades = [
  {'grade': 1, 'losal': 20000, 'hisal': 30000},
  {'grade': 2, 'losal': 30001, 'hisal': 50000},
  {'grade': 3, 'losal': 50001, 'hisal': 60001},
];

final List<Map<String, dynamic>> bonuses = [
  {'ename': 'Fazil', 'job': 'Full Stack Developer', 'sal': 28000, 'comm': 2000},
  {'ename': 'Afsal', 'job': 'CTO', 'sal': 60000, 'comm': 5000},
  {'ename': 'Avinash', 'job': 'Team Lead', 'sal': 47000, 'comm': 3000},
  {'ename': 'Sreeja', 'job': 'Full Stack Developer', 'sal': 26000, 'comm': 1500},
];


// 1. Get total employees in the organization
int  getTotalEmployeesInEachDepartment()  => employees.length;


// 2. Get total salary expenditure
 double getTotalSalaryExpenditure() => employees.fold(0, (sum, e) => sum + e['sal']);

// 3. Find the highest-paid employee
  Map<String, dynamic> getHighestPaidEmployee() => employees.reduce((a, b) => a['sal'] > b['sal'] ? a : b);

// 4. Get employees sorted by salary
 List<Map<String, dynamic>> getEmployeesSortedBySalary() => employees..sort((a, b) => b['sal'].compareTo(a['sal']));

// 5. Find employees earning more than a threshold
 List<Map<String, dynamic>> getEmployeesEarningAbove(double threshold) => employees.where((e) => e['sal'] > 30000).toList();


// 6. Find departments with at least N employees
List<Map<String, dynamic>> getDepartmentsWithMinEmployees(int minEmployees) => departments.where((d) => employees.where((e) => e['deptno'] == d['deptno']).length >= minEmployees).toList();


// 7. Get average salary per department
List<Map<String, double>> getAverageSalaryPerDepartment() =>  departments.map((d) => {d['dname'] as String: employees.where((e) => e['deptno'] == d['deptno']).map((e) => e['sal'] as int).reduce((a, b) => a + b) / employees.where((e) => e['deptno'] == d['deptno']).length}).toList();

// 8. Get employees by department
List<Map<String, dynamic>> getEmployeesByDepartment() => employees.where((e) => e['deptno'] == 1).toList(); 

// 9. Get department with the highest average salary
Map<String, double>  getDepartmentWithHighestAverageSalary() => departments.map((d) => {d['dname'] as String: employees.where((e) => e['deptno'] == d['deptno']).map((e) => e['sal'] as int).reduce((a, b) => a + b) / employees.where((e) => e['deptno'] == d['deptno']).length}).reduce((a, b) => a.values.first > b.values.first ? a : b);

// 10. Get total number of departments
int getTotalDepartments() =>  departments.length;

// 11. Get top N salaries
 List<int> getTopNSalaries(int n) => employees.map((e) => e['sal'] as int).toList()..sort((a, b) => b.compareTo(a))..take(n).toList();

// 12. Check if an employee is in a department
 bool isEmployeeInDepartment(int empId, int deptId)  => employees.any((e) => e['empno'] == empId && e['deptno'] == deptId);

// 13. Get employees by name
 List<Map<String, dynamic>> getEmployeesWithName(String name) => employees.where((e) => e['name'] == name).toList();

// 14. Get median salary of all employees
 double getMedianSalary() {
   List<int> salaries = employees.map((e) => e['sal'] as int).toList();
   salaries.sort();
   int middle = salaries.length ~/ 2;
   return salaries.length.isOdd ? salaries[middle].toDouble() : (salaries[middle - 1] + salaries[middle]) / 2;
 }

// 15. Get employee count per department
List<Map<String, int>> getEmployeeCountPerDepartment()  =>  departments.map((d) => {d['dname'] as String: employees.where((e) => e['deptno'] == d['deptno']).length}).toList();


// 16. Get employees with salary in a given range
List<Map<String, dynamic>> getEmployeesWithSalaryInRange(double min, double max) =>   employees.where((e) => e['sal'] >= min && e['sal'] <= max).toList();


// 17. Get total salary per department
List<Map<String, dynamic>> getTotalSalaryPerDepartment() =>  departments.map((d) => {d['dname'] as String: employees.where((e) => e['deptno'] == d['deptno']).map((e) => e['sal'] as int).reduce((a, b) => a + b)}).toList();

// 18. Check if a department has at least one employee
 bool hasEmployeeInDepartment(int deptId) => employees.any((e) => e['deptno'] == deptId);

// 19. Get employees whose ID starts with a specific prefix
 List<Map<String, dynamic>> getEmployeesWithIdPrefix(String prefix) => employees.where((e) => e['empno'].toString().startsWith("10")).toList();

// 20. Check if any employee is earning below a given amount
  bool isAnyEmployeeEarningBelow(double threshold) => employees.any((e) => e['sal'] < 25000);

// 21. Get employees with an odd employee ID
List<Map<String, dynamic>> getEmployeesWithOddId() => employees.where((e) => e['empno'] % 2 != 0).toList();

// 22. Get total number of employees earning within a salary range
int  getTotalEmployeesWithSalaryInRange(double min, double max) => employees.where((e) => e['sal'] >= min && e['sal'] <= max).length;

// 23. Get the Nth highest-paid employee
 List<Map<String, dynamic>> getNthHighestPaidEmployee(int n)  => employees.map((e) => e).toList()..sort((a, b) => b['sal'].compareTo(a['sal']));

// 24. Get the average salary of employees
double getAverageSalaryOfEmployees() =>  employees.map((e) => e['sal'] as int).reduce((a, b) => a + b) / employees.length;


// 25. Get employees who are not in a specific department
List<Map<String, dynamic>> getEmployeesNotInDepartment(int deptId)  => employees.where((e) => e['deptno'] != 1).toList(); 

// 26. Get department IDs where total salary exceeds a given amount
List getDepartmentIdsWithSalaryAbove(double threshold) => departments.where((d) => employees.where((e) => e['deptno'] == d['deptno']).map((e) => e['sal'] as int).reduce((a, b) => a + b) > 100000).map((d) => d['deptno']).toList();

// 27. Check if all departments have at least one employee
bool doAllDepartmentsHaveEmployees() => departments.every((d) => employees.any((e) => e['deptno'] == d['deptno']));

// 28. Get departments that have employees earning above a salary threshold
 List<Map<String, dynamic>> getDepartmentsWithEmployeesAboveSalary(double threshold) => departments.where((d) => employees.where((e) => e['deptno'] == d['deptno'] && e['sal'] > 30000).isNotEmpty).toList();

// 29. Get unique employees by name (handling duplicates)
 Set<String> getUniqueEmployeesByName() => employees.map((e) => (e['ename'] ?? '').toString()) .toSet();



// 30. Find employees with the highest commission
 Map<String, dynamic> getEmployeesWithHighestCommission() =>  employees.where((e) => e['comm'] != null).reduce((a, b) => a['comm'] > b['comm'] ? a : b);

   print('1. Total Employees: ${getTotalEmployeesInEachDepartment()}');
  print('2. Total Salary Expenditure: ${getTotalSalaryExpenditure()}');
  print('3. Highest Paid Employee: ${getHighestPaidEmployee()}');
  print('4. Employees Sorted by Salary: ${getEmployeesSortedBySalary()}');
  print('5. Employees Earning Above 30000: ${getEmployeesEarningAbove(30000)}');
  print('6. Departments with at least 2 Employees: ${getDepartmentsWithMinEmployees(2)}');
  print('7. Average Salary Per Department: ${getAverageSalaryPerDepartment()}');
  print('8. Employees in Department 1: ${getEmployeesByDepartment()}');
  print('9. Department with Highest Average Salary: ${getDepartmentWithHighestAverageSalary()}');
  print('10. Total Departments: ${getTotalDepartments()}');
  print('11. Top 3 Salaries: ${getTopNSalaries(3)}'); 
  print('12. Is Employee 1001 in Department 1: ${isEmployeeInDepartment(1001, 1)}');
  print('13. Get employees by name: ${getEmployeesWithName('sreeja')}'); 
  print('14. Median Salary: ${getMedianSalary()}');
  print('15. Employee Count Per Department: ${getEmployeeCountPerDepartment()}');
  print('16. Employees with Salary in Range 25000-50000: ${getEmployeesWithSalaryInRange(25000, 50000)}');
  print('17. Total Salary Per Department: ${getTotalSalaryPerDepartment()}');
  print('18. Does Department 1 have Employees: ${hasEmployeeInDepartment(1)}');
  print('19. Employees with ID Prefix 10: ${getEmployeesWithIdPrefix("10")}');
  print('20. Is Any Employee Earning Below 25000: ${isAnyEmployeeEarningBelow(25000)}');
  print('21. Employees with Odd ID: ${getEmployeesWithOddId()}');
  print('22. Total Employees with Salary in Range 25000-50000: ${getTotalEmployeesWithSalaryInRange(25000, 50000)}');
  print('23. Get the Nth highest-paid employee: ${getNthHighestPaidEmployee(10)}');
  print('24. Average Salary of Employees: ${getAverageSalaryOfEmployees()}');
  print('25. Employees Not in Department 1: ${getEmployeesNotInDepartment(1)}');
  print('26. Department IDs with Total Salary Above 100000: ${getDepartmentIdsWithSalaryAbove(100000)}');
  print('27. Do All Departments Have Employees: ${doAllDepartmentsHaveEmployees()}');
  print('28. Departments with Employees Earning Above 30000: ${getDepartmentsWithEmployeesAboveSalary(  30000)}');
  print('29. Unique Employees by Name: ${getUniqueEmployeesByName()}');
  print('30. Employees with Highest Commission: ${getEmployeesWithHighestCommission()}');


}