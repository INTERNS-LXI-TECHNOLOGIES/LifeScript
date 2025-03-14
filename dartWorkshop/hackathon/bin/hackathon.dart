import 'package:hackathon/hackathon.dart' as hackathon;

void main(){
  var org = hackathon.Organization('Tech Corp', [
    hackathon.Branch('B001', 'Development', [
      hackathon.Employee('E001', 'Alice', 75000),
      hackathon.Employee('E002', 'Bob', 65000),
      hackathon.Employee('E003', 'Charlie', 70000),
    ]),
    hackathon.Branch('B002', 'Marketing', [
      hackathon.Employee('E004', 'David', 60000),
      hackathon.Employee('E005', 'Eve', 55000),
    ]),
    hackathon.Branch('B003', 'HR', [
      hackathon.Employee('E006', 'Frank', 50000),
      hackathon.Employee('E007', 'Eve', 52000),
    ]),
  ]);

print('Q1: ${org.getTotalEmployees()}');
print('Q2: ${org.getTotalSalaryExpenditure()}');
print('Q3: ${org.getEmployeesByBranch()}');
print('Q4: ${org.getEmployeesSortedBySalary()}');
print('Q5: ${org.getEmployeesEarningAbove(50000)}');
print('Q6: ${org.getBranchesWithMinEmployees(2)}');
print('Q7: ${org.getAverageSalaryPerBranch()}');
print('Q8: ${org.getHighestPaidEmployee()}');
print('Q9: ${org.getBranchWithHighestAverageSalary()}');
print('Q10: ${org.getTotalBranches()}');
print('Q11: ${org.getTopNSalaries(6)}');
print('Q12: ${org.isEmployeeInBranch("E002", "B001")}');
print('Q13: ${org.getEmployeesWithName("Frank")}');
print('Q14: ${org.getMedianSalary()}');
print('Q15: ${org.getEmployeeCountPerBranch()}');
print('Q16: ${org.getEmployeesWithSalaryInRange(60000, 70000)}');
print('Q17: ${org.getTotalSalaryPerBranch()}');
print('Q18: ${org.hasEmployee("E007")}');
print('Q19: ${org.getEmployeesWithIdPrefix("E")}');
print('Q20: ${org.isAnyEmployeeEarningBelow(60000)}');
print('Q21: ${org.getEmployeesWithOddId("E006")}');
print('Q22: ${org.getTotalEmployeesWithSalaryInRange(70000, 80000)}');
print('Q23: ${org.getNthHighestPaidEmployee(70000)}');
print('Q24: ${org.getAverageSalaryOfEmployees()}');
print('Q25: ${org.getEmployeesNotInBranch("E007")}');
print('Q26: ${org.getBranchIdsWithSalaryAbove(55000)}');
print('Q27: ${org.doAllBranchesHaveEmployees()}');
print('Q28: ${org.getBranchesWithEmployeesAboveSalary(70000)}');
print('Q29: ${org.getUniqueEmployeesByName()}');



  print('----------------------------------------');

}