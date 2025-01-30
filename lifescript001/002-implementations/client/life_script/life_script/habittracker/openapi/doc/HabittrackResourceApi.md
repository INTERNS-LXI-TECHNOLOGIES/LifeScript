# openapi.api.HabitTrackResourceApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createHabitTrack**](HabitTrackResourceApi.md#createhabittrack) | **POST** /api/habit-tracks | 
[**deleteHabitTrack**](HabitTrackResourceApi.md#deletehabittrack) | **DELETE** /api/habit-tracks/{id} | 
[**getAllHabitTracks**](HabitTrackResourceApi.md#getallhabittracks) | **GET** /api/habit-tracks | 
[**getHabitTrack**](HabitTrackResourceApi.md#gethabittrack) | **GET** /api/habit-tracks/{id} | 
[**partialUpdateHabitTrack**](HabitTrackResourceApi.md#partialupdatehabittrack) | **PATCH** /api/habit-tracks/{id} | 
[**updateHabitTrack**](HabitTrackResourceApi.md#updatehabittrack) | **PUT** /api/habit-tracks/{id} | 


# **createHabitTrack**
> HabitTrack createHabitTrack(habitTrack)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHabitTrackResourceApi();
final HabitTrack habitTrack = ; // HabitTrack | 

try {
    final response = api.createHabitTrack(habitTrack);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HabitTrackResourceApi->createHabitTrack: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **habitTrack** | [**HabitTrack**](HabitTrack.md)|  | 

### Return type

[**HabitTrack**](HabitTrack.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteHabitTrack**
> deleteHabitTrack(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHabitTrackResourceApi();
final int id = 789; // int | 

try {
    api.deleteHabitTrack(id);
} catch on DioException (e) {
    print('Exception when calling HabitTrackResourceApi->deleteHabitTrack: $e\n');
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

# **getAllHabitTracks**
> BuiltList<HabitTrack> getAllHabitTracks()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHabitTrackResourceApi();

try {
    final response = api.getAllHabitTracks();
    print(response);
} catch on DioException (e) {
    print('Exception when calling HabitTrackResourceApi->getAllHabitTracks: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;HabitTrack&gt;**](HabitTrack.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getHabitTrack**
> HabitTrack getHabitTrack(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHabitTrackResourceApi();
final int id = 789; // int | 

try {
    final response = api.getHabitTrack(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HabitTrackResourceApi->getHabitTrack: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**HabitTrack**](HabitTrack.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **partialUpdateHabitTrack**
> HabitTrack partialUpdateHabitTrack(id, habitTrack)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHabitTrackResourceApi();
final int id = 789; // int | 
final HabitTrack habitTrack = ; // HabitTrack | 

try {
    final response = api.partialUpdateHabitTrack(id, habitTrack);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HabitTrackResourceApi->partialUpdateHabitTrack: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **habitTrack** | [**HabitTrack**](HabitTrack.md)|  | 

### Return type

[**HabitTrack**](HabitTrack.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/merge-patch+json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateHabitTrack**
> HabitTrack updateHabitTrack(id, habitTrack)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHabitTrackResourceApi();
final int id = 789; // int | 
final HabitTrack habitTrack = ; // HabitTrack | 

try {
    final response = api.updateHabitTrack(id, habitTrack);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HabitTrackResourceApi->updateHabitTrack: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **habitTrack** | [**HabitTrack**](HabitTrack.md)|  | 

### Return type

[**HabitTrack**](HabitTrack.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

