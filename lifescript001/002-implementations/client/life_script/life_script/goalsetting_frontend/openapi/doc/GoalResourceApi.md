# openapi.api.GoalResourceApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createGoal**](GoalResourceApi.md#creategoal) | **POST** /api/goals | 
[**deleteGoal**](GoalResourceApi.md#deletegoal) | **DELETE** /api/goals/{id} | 
[**getAllGoalsAsStream**](GoalResourceApi.md#getallgoalsasstream) | **GET** /api/goals | 
[**getGoal**](GoalResourceApi.md#getgoal) | **GET** /api/goals/{id} | 
[**partialUpdateGoal**](GoalResourceApi.md#partialupdategoal) | **PATCH** /api/goals/{id} | 
[**updateGoal**](GoalResourceApi.md#updategoal) | **PUT** /api/goals/{id} | 


# **createGoal**
> Goal createGoal(goal)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getGoalResourceApi();
final Goal goal = ; // Goal | 

try {
    final response = api.createGoal(goal);
    print(response);
} catch on DioException (e) {
    print('Exception when calling GoalResourceApi->createGoal: $e\n');
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

final api = Openapi().getGoalResourceApi();
final int id = 789; // int | 

try {
    api.deleteGoal(id);
} catch on DioException (e) {
    print('Exception when calling GoalResourceApi->deleteGoal: $e\n');
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

# **getAllGoalsAsStream**
> BuiltList<Goal> getAllGoalsAsStream()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getGoalResourceApi();

try {
    final response = api.getAllGoalsAsStream();
    print(response);
} catch on DioException (e) {
    print('Exception when calling GoalResourceApi->getAllGoalsAsStream: $e\n');
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
 - **Accept**: application/x-ndjson, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getGoal**
> Goal getGoal(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getGoalResourceApi();
final int id = 789; // int | 

try {
    final response = api.getGoal(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling GoalResourceApi->getGoal: $e\n');
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

# **partialUpdateGoal**
> Goal partialUpdateGoal(id, goal)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getGoalResourceApi();
final int id = 789; // int | 
final Goal goal = ; // Goal | 

try {
    final response = api.partialUpdateGoal(id, goal);
    print(response);
} catch on DioException (e) {
    print('Exception when calling GoalResourceApi->partialUpdateGoal: $e\n');
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

 - **Content-Type**: application/json, application/merge-patch+json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateGoal**
> Goal updateGoal(id, goal)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getGoalResourceApi();
final int id = 789; // int | 
final Goal goal = ; // Goal | 

try {
    final response = api.updateGoal(id, goal);
    print(response);
} catch on DioException (e) {
    print('Exception when calling GoalResourceApi->updateGoal: $e\n');
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

