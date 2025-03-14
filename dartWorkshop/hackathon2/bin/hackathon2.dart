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


void main(){
// 1. Get total employees in the organization
// getTotalEmployeesInEachDepartment() 
int getTotalEmployeesInEachDepartment() => employees.length;
print('Q1: ${getTotalEmployeesInEachDepartment()}');


// 2. Get total salary expenditure
// getTotalSalaryExpenditure()
double getTotalSalaryExpenditure() => employees.fold(0, (prev, e) => prev + e['sal']);
print('Q2: ${getTotalSalaryExpenditure()}');

// 3. Find the highest-paid employee
// getHighestPaidEmployee() 



// 4. Get employees sorted by salary
// getEmployeesSortedBySalary()


// 5. Find employees earning more than a threshold
// getEmployeesEarningAbove(double threshold) 
List<Map<String, dynamic>> getEmployeesEarningAbove(double threshold)=> employees.where((a)=> a['sal']>threshold).toList();
print('Q5: ${getEmployeesEarningAbove(30000)}');


// 6. Find departments with at least N employees
// getDepartmentsWithMinEmployees(int minEmployees) 

List<Map<String, dynamic>> getDepartmentsWithMinEmployees(int minEmployees) {
  Map<int, int> deptCount = {};
  for (var emp in employees) {
    deptCount[emp['deptno']] = (deptCount[emp['deptno']] ?? 0) + 1;
  }
  return departments.where((dept) => (deptCount[dept['deptno']] ?? 0) >= minEmployees).toList();
}
print('Q6: ${getDepartmentsWithMinEmployees(3)}');

// 7. Get average salary per department
// getAverageSalaryPerDepartment()

// 8. Get employees by department
// getEmployeesByDepartment() 


// 9. Get department with the highest average salary
// getDepartmentWithHighestAverageSalary()

// 10. Get total number of departments
// getTotalDepartments() 
int getTotalDepartments() => departments.length;
print("Q10: ${getTotalDepartments()}");

// 11. Get top N salaries
// getTopNSalaries(int n) 
List<Map<String, dynamic>> getTopNSalaries(int n) {
  List<Map<String, dynamic>>emp= List.from(employees);
  emp.sort((a, b) => b['sal'].compareTo(a['sal']));
  return emp.take(n).toList();
}
print('Q11: ${getTopNSalaries(3)}');

// 12. Check if an employee is in a department
// isEmployeeInDepartment(int empId, int deptId) 

// 13. Get employees by name
// getEmployeesWithName(String name)

// 14. Get median salary of all employees
// double getMedianSalary() 

// 15. Get employee count per department
// getEmployeeCountPerDepartment() 

// 16. Get employees with salary in a given range
// getEmployeesWithSalaryInRange(double min, double max)

// 17. Get total salary per department
// getTotalSalaryPerDepartment() 

// 18. Check if a department has at least one employee
// hasEmployeeInDepartment(int deptId) 

// 19. Get employees whose ID starts with a specific prefix
// getEmployeesWithIdPrefix(String prefix)

// 20. Check if any employee is earning below a given amount
// isAnyEmployeeEarningBelow(double threshold)

// 21. Get employees with an odd employee ID
// getEmployeesWithOddId()

// 22. Get total number of employees earning within a salary range
// getTotalEmployeesWithSalaryInRange(double min, double max) 

// 23. Get the Nth highest-paid employee
// getNthHighestPaidEmployee(int n) 

// 24. Get the average salary of employees
// getAverageSalaryOfEmployees()

// 25. Get employees who are not in a specific department
// getEmployeesNotInDepartment(int deptId) 

// 26. Get department IDs where total salary exceeds a given amount
// getDepartmentIdsWithSalaryAbove(double threshold)

// 27. Check if all departments have at least one employee
// doAllDepartmentsHaveEmployees()

// 28. Get departments that have employees earning above a salary threshold
// getDepartmentsWithEmployeesAboveSalary(double threshold)

// 29. Get unique employees by name (handling duplicates)
// getUniqueEmployeesByName()

// 30. Find employees with the highest commission
// getEmployeesWithHighestCommission()
}