# openapi.api.HabittrackResourceApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://172.20.10.11:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createHabittrack**](HabittrackResourceApi.md#createhabittrack) | **POST** /api/habittracks | 
[**deleteHabittrack**](HabittrackResourceApi.md#deletehabittrack) | **DELETE** /api/habittracks/{id} | 
[**getAllHabittracksAsStream**](HabittrackResourceApi.md#getallhabittracksasstream) | **GET** /api/habittracks | 
[**getHabittrack**](HabittrackResourceApi.md#gethabittrack) | **GET** /api/habittracks/{id} | 
[**partialUpdateHabittrack**](HabittrackResourceApi.md#partialupdatehabittrack) | **PATCH** /api/habittracks/{id} | 
[**updateHabittrack**](HabittrackResourceApi.md#updatehabittrack) | **PUT** /api/habittracks/{id} | 


# **createHabittrack**
> Habittrack createHabittrack(habittrack)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHabittrackResourceApi();
final Habittrack habittrack = ; // Habittrack | 

try {
    final response = api.createHabittrack(habittrack);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HabittrackResourceApi->createHabittrack: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **habittrack** | [**Habittrack**](Habittrack.md)|  | 

### Return type

[**Habittrack**](Habittrack.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteHabittrack**
> deleteHabittrack(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHabittrackResourceApi();
final int id = 789; // int | 

try {
    api.deleteHabittrack(id);
} catch on DioException (e) {
    print('Exception when calling HabittrackResourceApi->deleteHabittrack: $e\n');
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

# **getAllHabittracksAsStream**
> BuiltList<Habittrack> getAllHabittracksAsStream()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHabittrackResourceApi();

try {
    final response = api.getAllHabittracksAsStream();
    print(response);
} catch on DioException (e) {
    print('Exception when calling HabittrackResourceApi->getAllHabittracksAsStream: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;Habittrack&gt;**](Habittrack.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/x-ndjson, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getHabittrack**
> Habittrack getHabittrack(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHabittrackResourceApi();
final int id = 789; // int | 

try {
    final response = api.getHabittrack(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HabittrackResourceApi->getHabittrack: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**Habittrack**](Habittrack.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **partialUpdateHabittrack**
> Habittrack partialUpdateHabittrack(id, habittrack)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHabittrackResourceApi();
final int id = 789; // int | 
final Habittrack habittrack = ; // Habittrack | 

try {
    final response = api.partialUpdateHabittrack(id, habittrack);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HabittrackResourceApi->partialUpdateHabittrack: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **habittrack** | [**Habittrack**](Habittrack.md)|  | 

### Return type

[**Habittrack**](Habittrack.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/merge-patch+json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateHabittrack**
> Habittrack updateHabittrack(id, habittrack)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHabittrackResourceApi();
final int id = 789; // int | 
final Habittrack habittrack = ; // Habittrack | 

try {
    final response = api.updateHabittrack(id, habittrack);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HabittrackResourceApi->updateHabittrack: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **habittrack** | [**Habittrack**](Habittrack.md)|  | 

### Return type

[**Habittrack**](Habittrack.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

