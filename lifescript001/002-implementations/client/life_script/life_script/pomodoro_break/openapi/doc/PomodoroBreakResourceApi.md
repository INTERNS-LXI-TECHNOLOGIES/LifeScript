# openapi.api.PomodoroBreakResourceApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createPomodoroBreak**](PomodoroBreakResourceApi.md#createpomodorobreak) | **POST** /api/pomodoro-breaks | 
[**deletePomodoroBreak**](PomodoroBreakResourceApi.md#deletepomodorobreak) | **DELETE** /api/pomodoro-breaks/{id} | 
[**getAllPomodoroBreaksAsStream**](PomodoroBreakResourceApi.md#getallpomodorobreaksasstream) | **GET** /api/pomodoro-breaks | 
[**getPomodoroBreak**](PomodoroBreakResourceApi.md#getpomodorobreak) | **GET** /api/pomodoro-breaks/{id} | 
[**partialUpdatePomodoroBreak**](PomodoroBreakResourceApi.md#partialupdatepomodorobreak) | **PATCH** /api/pomodoro-breaks/{id} | 
[**updatePomodoroBreak**](PomodoroBreakResourceApi.md#updatepomodorobreak) | **PUT** /api/pomodoro-breaks/{id} | 


# **createPomodoroBreak**
> PomodoroBreak createPomodoroBreak(pomodoroBreak)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPomodoroBreakResourceApi();
final PomodoroBreak pomodoroBreak = ; // PomodoroBreak | 

try {
    final response = api.createPomodoroBreak(pomodoroBreak);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PomodoroBreakResourceApi->createPomodoroBreak: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pomodoroBreak** | [**PomodoroBreak**](PomodoroBreak.md)|  | 

### Return type

[**PomodoroBreak**](PomodoroBreak.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deletePomodoroBreak**
> deletePomodoroBreak(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPomodoroBreakResourceApi();
final int id = 789; // int | 

try {
    api.deletePomodoroBreak(id);
} catch on DioException (e) {
    print('Exception when calling PomodoroBreakResourceApi->deletePomodoroBreak: $e\n');
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

# **getAllPomodoroBreaksAsStream**
> BuiltList<PomodoroBreak> getAllPomodoroBreaksAsStream()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPomodoroBreakResourceApi();

try {
    final response = api.getAllPomodoroBreaksAsStream();
    print(response);
} catch on DioException (e) {
    print('Exception when calling PomodoroBreakResourceApi->getAllPomodoroBreaksAsStream: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;PomodoroBreak&gt;**](PomodoroBreak.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/x-ndjson, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPomodoroBreak**
> PomodoroBreak getPomodoroBreak(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPomodoroBreakResourceApi();
final int id = 789; // int | 

try {
    final response = api.getPomodoroBreak(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PomodoroBreakResourceApi->getPomodoroBreak: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**PomodoroBreak**](PomodoroBreak.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **partialUpdatePomodoroBreak**
> PomodoroBreak partialUpdatePomodoroBreak(id, pomodoroBreak)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPomodoroBreakResourceApi();
final int id = 789; // int | 
final PomodoroBreak pomodoroBreak = ; // PomodoroBreak | 

try {
    final response = api.partialUpdatePomodoroBreak(id, pomodoroBreak);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PomodoroBreakResourceApi->partialUpdatePomodoroBreak: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **pomodoroBreak** | [**PomodoroBreak**](PomodoroBreak.md)|  | 

### Return type

[**PomodoroBreak**](PomodoroBreak.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/merge-patch+json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updatePomodoroBreak**
> PomodoroBreak updatePomodoroBreak(id, pomodoroBreak)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPomodoroBreakResourceApi();
final int id = 789; // int | 
final PomodoroBreak pomodoroBreak = ; // PomodoroBreak | 

try {
    final response = api.updatePomodoroBreak(id, pomodoroBreak);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PomodoroBreakResourceApi->updatePomodoroBreak: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **pomodoroBreak** | [**PomodoroBreak**](PomodoroBreak.md)|  | 

### Return type

[**PomodoroBreak**](PomodoroBreak.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

