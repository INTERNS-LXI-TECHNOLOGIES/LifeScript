# openapi.api.PomodoroControllerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getPomodoro**](PomodoroControllerApi.md#getpomodoro) | **GET** /api/pomodoro/{id} | 
[**setPomodoro**](PomodoroControllerApi.md#setpomodoro) | **POST** /api/pomodoro/set | 


# **getPomodoro**
> Pomodoro getPomodoro(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPomodoroControllerApi();
final int id = 789; // int | 

try {
    final response = api.getPomodoro(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PomodoroControllerApi->getPomodoro: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**Pomodoro**](Pomodoro.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **setPomodoro**
> Pomodoro setPomodoro(workDuration, breakDuration)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPomodoroControllerApi();
final int workDuration = 56; // int | 
final int breakDuration = 56; // int | 

try {
    final response = api.setPomodoro(workDuration, breakDuration);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PomodoroControllerApi->setPomodoro: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **workDuration** | **int**|  | 
 **breakDuration** | **int**|  | 

### Return type

[**Pomodoro**](Pomodoro.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

