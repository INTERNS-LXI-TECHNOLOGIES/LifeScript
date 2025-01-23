# openapi.api.GoalControllerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createGoal**](GoalControllerApi.md#creategoal) | **POST** /api/goals | 
[**deleteGoal**](GoalControllerApi.md#deletegoal) | **DELETE** /api/goals/{id} | 
[**getAllGoals**](GoalControllerApi.md#getallgoals) | **GET** /api/goals | 
[**getGoalById**](GoalControllerApi.md#getgoalbyid) | **GET** /api/goals/{id} | 
[**updateGoal**](GoalControllerApi.md#updategoal) | **PUT** /api/goals/{id} | 


# **createGoal**
> Goal createGoal(goal)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getGoalControllerApi();
final Goal goal = ; // Goal | 

try {
    final response = api.createGoal(goal);
    print(response);
} catch on DioException (e) {
    print('Exception when calling GoalControllerApi->createGoal: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **goal** | [**Goal**](Goal.md)|  | 

### Return type

[**Goal**](Goal.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteGoal**
> deleteGoal(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getGoalControllerApi();
final int id = 789; // int | 

try {
    api.deleteGoal(id);
} catch on DioException (e) {
    print('Exception when calling GoalControllerApi->deleteGoal: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllGoals**
> BuiltList<Goal> getAllGoals()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getGoalControllerApi();

try {
    final response = api.getAllGoals();
    print(response);
} catch on DioException (e) {
    print('Exception when calling GoalControllerApi->getAllGoals: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;Goal&gt;**](Goal.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getGoalById**
> Goal getGoalById(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getGoalControllerApi();
final int id = 789; // int | 

try {
    final response = api.getGoalById(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling GoalControllerApi->getGoalById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**Goal**](Goal.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateGoal**
> Goal updateGoal(id, goal)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getGoalControllerApi();
final int id = 789; // int | 
final Goal goal = ; // Goal | 

try {
    final response = api.updateGoal(id, goal);
    print(response);
} catch on DioException (e) {
    print('Exception when calling GoalControllerApi->updateGoal: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **goal** | [**Goal**](Goal.md)|  | 

### Return type

[**Goal**](Goal.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

