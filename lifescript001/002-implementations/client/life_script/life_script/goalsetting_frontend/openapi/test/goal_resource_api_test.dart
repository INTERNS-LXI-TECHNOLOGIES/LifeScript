import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for GoalResourceApi
void main() {
  final instance = Openapi().getGoalResourceApi();

  group(GoalResourceApi, () {
    //Future<Goal> createGoal(Goal goal) async
    test('test createGoal', () async {
      // TODO
    });

    //Future deleteGoal(int id) async
    test('test deleteGoal', () async {
      // TODO
    });

    //Future<BuiltList<Goal>> getAllGoalsAsStream() async
    test('test getAllGoalsAsStream', () async {
      // TODO
    });

    //Future<Goal> getGoal(int id) async
    test('test getGoal', () async {
      // TODO
    });

    //Future<Goal> partialUpdateGoal(int id, Goal goal) async
    test('test partialUpdateGoal', () async {
      // TODO
    });

    //Future<Goal> updateGoal(int id, Goal goal) async
    test('test updateGoal', () async {
      // TODO
    });

  });
}
