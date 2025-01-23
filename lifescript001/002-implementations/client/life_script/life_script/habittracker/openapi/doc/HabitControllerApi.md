# openapi.api.HabitControllerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getTaskForAllHabits**](HabitControllerApi.md#gettaskforallhabits) | **GET** /read | 
[**markTaskCompleted**](HabitControllerApi.md#marktaskcompleted) | **POST** /delete | 
[**readAllHabits**](HabitControllerApi.md#readallhabits) | **GET** / | 
[**saveHabit**](HabitControllerApi.md#savehabit) | **POST** / | 


# **getTaskForAllHabits**
> BuiltList<Task> getTaskForAllHabits()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHabitControllerApi();

try {
    final response = api.getTaskForAllHabits();
    print(response);
} catch on DioException (e) {
    print('Exception when calling HabitControllerApi->getTaskForAllHabits: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;Task&gt;**](Task.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **markTaskCompleted**
> BuiltList<Task> markTaskCompleted(taskId)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHabitControllerApi();
final int taskId = 789; // int | 

try {
    final response = api.markTaskCompleted(taskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HabitControllerApi->markTaskCompleted: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskId** | **int**|  | 

### Return type

[**BuiltList&lt;Task&gt;**](Task.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **readAllHabits**
> BuiltList<HabitEntity> readAllHabits()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHabitControllerApi();

try {
    final response = api.readAllHabits();
    print(response);
} catch on DioException (e) {
    print('Exception when calling HabitControllerApi->readAllHabits: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;HabitEntity&gt;**](HabitEntity.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **saveHabit**
> HabitEntity saveHabit(habitEntity)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHabitControllerApi();
final HabitEntity habitEntity = ; // HabitEntity | 

try {
    final response = api.saveHabit(habitEntity);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HabitControllerApi->saveHabit: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **habitEntity** | [**HabitEntity**](HabitEntity.md)|  | 

### Return type

[**HabitEntity**](HabitEntity.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

