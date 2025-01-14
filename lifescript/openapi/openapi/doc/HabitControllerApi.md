# openapi.api.HabitControllerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createHabit**](HabitControllerApi.md#createhabit) | **POST** / | 
[**getAllPersons**](HabitControllerApi.md#getallpersons) | **GET** / | 


# **createHabit**
> HabitEntity createHabit(habitEntity)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHabitControllerApi();
final HabitEntity habitEntity = ; // HabitEntity | 

try {
    final response = api.createHabit(habitEntity);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HabitControllerApi->createHabit: $e\n');
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

# **getAllPersons**
> BuiltList<HabitEntity> getAllPersons()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHabitControllerApi();

try {
    final response = api.getAllPersons();
    print(response);
} catch on DioException (e) {
    print('Exception when calling HabitControllerApi->getAllPersons: $e\n');
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

