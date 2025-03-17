//import 'dart:math';

import 'dart:math';

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
List<Map<String,dynamic>>getDepartmentWithHighestAverageSalary(){
  Map<int,double> totalSalaryPerDept= {};
  Map<int,int>empCountPerDept={};
  for (var e in employees){
    totalSalaryPerDept[e['deptno']]=(totalSalaryPerDept[e['deptno']]??0)+e['sal'];
    empCountPerDept[e['deptno']]= (empCountPerDept[e['deptno']]??0)+1;
  }
  num highestAvg =0;
  num highestDept =0;
  for(var dep in empCountPerDept.keys){
    double avg = totalSalaryPerDept[dep]!/empCountPerDept[dep]!;
    if (avg>highestAvg){
      highestAvg =avg;
      highestDept=dep;
    }
  }
  return departments.where((a)=>a['deptno']==highestDept).toList();


}
 print('Q9: ${getDepartmentWithHighestAverageSalary()}');
// List <Map<String ,dynamic>>getDepartmentWithHighestAverageSalary(){
//   Map<int, double> totalSalaryPerDept = {};
//   Map<int, int> empCountPerDept = {};
//   for (var e in employees) {
//     totalSalaryPerDept[e['deptno']] = (totalSalaryPerDept[e['deptno']] ?? 0) + e['sal'];
//     empCountPerDept[e['deptno']] = (empCountPerDept[e['deptno']] ?? 0) + 1;
//   }
//   double highestAvg = 0;
//   int highestDept = 0;
//   for (var dept in empCountPerDept.keys) {
//     double avg = totalSalaryPerDept[dept]! / empCountPerDept[dept]!;
//     if (avg > highestAvg) {
//       highestAvg = avg;
//       highestDept = dept;
//     }
//   }
//   return departments.where((dept) => dept['deptno'] == highestDept).toList();
// }

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
bool isEmployeeInDepartment(int empId, int deptId) => employees.any((a)=> a['empno']==empId && a['deptno']==deptId);
print('Q12: ${isEmployeeInDepartment(1001, 1)}');

// 13. Get employees by name
// getEmployeesWithName(String name)
List<Map<String,dynamic>>getEmployeesWithName(String name)=> employees.where((a)=>a['ename']==name).toList();
print('Q13: ${getEmployeesWithName('Arjun')}');


// 14. Get median salary of all employees
// double getMedianSalary() 
double getMedianSalary() {
  List<dynamic> sal = employees.map((e) => e['sal']).toList();
  sal.sort();
  int n = sal.length;
  if (n % 2 == 0) {
    return (sal[n ~/ 2] + sal[n ~/ 2 - 1]) / 2;
  } else {
    return sal[n ~/ 2].toDouble();
  }
}
print('Q14: ${getMedianSalary()}');

// 15. Get employee count per department
// getEmployeeCountPerDepartment() 


// 16. Get employees with salary in a given range
// getEmployeesWithSalaryInRange(double min, double max)
List<Map<String,dynamic>> getEmployeesWithSalaryInRange(double min, double max) => employees.where((a)=> a['sal']>=min&& a['sal']<=max).toList();
print('Q16: ${getEmployeesWithSalaryInRange(30000, 50000)}');

// 17. Get total salary per department
// getTotalSalaryPerDepartment() 
Map<int, double> getTotalSalaryPerDepartment() => employees.fold({}, (prev, e) {
  prev[e['deptno']] = (prev[e['deptno']] ?? 0) + e['sal'];
  return prev;
});
print('Q17: ${getTotalSalaryPerDepartment()}');

// 18. Check if a department has at least one employee
// hasEmployeeInDepartment(int deptId) 
bool hasEmployeeInDepartment(int deptId)=> employees.any((a)=> a['deptno']==deptId);
print('Q18: ${hasEmployeeInDepartment(1)}');

// 19. Get employees whose ID starts with a specific prefix
// getEmployeesWithIdPrefix(String prefix)
List<Map<String ,dynamic>>getEmployeesWithIdPrefix(String prefix)=>employees.where((a)=> a['ename'].toString().startsWith(prefix)).toList();
print('Q19: ${getEmployeesWithIdPrefix('F')}');

// 20. Check if any employee is earning below a given amount
// isAnyEmployeeEarningBelow(double threshold)
bool isAnyEmployeeEarningBelow(double threshold) =>employees.any((a)=> a['sal']<threshold);
print('Q20: ${isAnyEmployeeEarningBelow(20000)}');

// 21. Get employees with an odd employee ID
// getEmployeesWithOddId()


// 22. Get total number of employees earning within a salary range
// getTotalEmployeesWithSalaryInRange(double min, double max) 

int getTotalEmployeesWithSalaryInRange(double min, double max)=> employees.where((a)=> a['sal']>=min&& a['sal']<=max).length;
print('Q22: ${getTotalEmployeesWithSalaryInRange(30000, 50000)}');


// 23. Get the Nth highest-paid employee
// getNthHighestPaidEmployee(int n) 


// 24. Get the average salary of employees
// getAverageSalaryOfEmployees()
double getAverageSalaryOfEmployees(){
  int totalemp =employees.length;
  int totalsal = employees.fold(0, (add, e)=> add +(e['sal'] as int));
  return totalsal / totalemp;
}
print('Q24: ${getAverageSalaryOfEmployees()}');

// 25. Get employees who are not in a specific department
// getEmployeesNotInDepartment(int deptId) 
List<Map<String,dynamic>>getEmployeesNotInDepartment(int deptId)=> employees.where((a)=> a['deptno']!=deptId).toList();
print('Q25: ${getEmployeesNotInDepartment(2)}');

// 26. Get department IDs where total salary exceeds a given amount
// getDepartmentIdsWithSalaryAbove(double threshold)
List<int> getDepartmentIdsWithSalaryAbove(double threshold) {
   Map<int, double> totalSalaryPerDept={};
   for (var e in employees) {
    totalSalaryPerDept[e['deptno']]= (totalSalaryPerDept[e['deptno']] ?? 0) + e['sal'];
  }
  return totalSalaryPerDept.keys.where((d) => totalSalaryPerDept[d]!> threshold).toList();
}
print('Q26: ${getDepartmentIdsWithSalaryAbove(100000)}');

// 27. Check if all departments have at least one employee
// doAllDepartmentsHaveEmployees()
bool doAllDepartmentsHaveEmployees()=> employees.every((a)=>a.isNotEmpty);
print('Q27: ${doAllDepartmentsHaveEmployees()}');

// 28. Get departments that have employees earning above a salary threshold
// getDepartmentsWithEmployeesAboveSalary(double threshold)

List<dynamic> getDepartmentsWithEmployeesAboveSalary(double threshold) =>
    employees.where((a) => a['sal'] > threshold).map((d) => d['deptno']).toSet() .toList();
  print('Q28: ${getDepartmentsWithEmployeesAboveSalary(50000)}');

// 29. Get unique employees by name (handling duplicates)
// getUniqueEmployeesByName()
List<Map<String, dynamic>> getUniqueEmployeesByName() => employees.toSet().toList();
print('Q29: ${getUniqueEmployeesByName()}');

// 30. Find employees with the highest commission
// getEmployeesWithHighestCommission()
List<Map<String,dynamic>>getEmployeesWithHighestCommission(){
  double? highest = employees.where((a) => a['comm'] != null)
  .map((b)=> (b['comm'] as num).toDouble())
  .fold<double>(0, (prev, e) => e>prev ?e:prev);
  return employees.where((a)=> a['comm']==highest).toList();
}
print('Q30: ${getEmployeesWithHighestCommission()}');


}