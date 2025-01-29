# openapi.api.HabitTrackerResourceApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://192.168.170.55:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createHabitTracker**](HabitTrackerResourceApi.md#createhabittracker) | **POST** /api/habit-trackers | 
[**deleteHabitTracker**](HabitTrackerResourceApi.md#deletehabittracker) | **DELETE** /api/habit-trackers/{id} | 
[**getAllHabitTrackersAsStream**](HabitTrackerResourceApi.md#getallhabittrackersasstream) | **GET** /api/habit-trackers | 
[**getHabitTracker**](HabitTrackerResourceApi.md#gethabittracker) | **GET** /api/habit-trackers/{id} | 
[**partialUpdateHabitTracker**](HabitTrackerResourceApi.md#partialupdatehabittracker) | **PATCH** /api/habit-trackers/{id} | 
[**updateHabitTracker**](HabitTrackerResourceApi.md#updatehabittracker) | **PUT** /api/habit-trackers/{id} | 


# **createHabitTracker**
> HabitTracker createHabitTracker(habitTracker)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHabitTrackerResourceApi();
final HabitTracker habitTracker = ; // HabitTracker | 

try {
    final response = api.createHabitTracker(habitTracker);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HabitTrackerResourceApi->createHabitTracker: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **habitTracker** | [**HabitTracker**](HabitTracker.md)|  | 

### Return type

[**HabitTracker**](HabitTracker.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteHabitTracker**
> deleteHabitTracker(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHabitTrackerResourceApi();
final int id = 789; // int | 

try {
    api.deleteHabitTracker(id);
} catch on DioException (e) {
    print('Exception when calling HabitTrackerResourceApi->deleteHabitTracker: $e\n');
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

# **getAllHabitTrackersAsStream**
> BuiltList<HabitTracker> getAllHabitTrackersAsStream()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHabitTrackerResourceApi();

try {
    final response = api.getAllHabitTrackersAsStream();
    print(response);
} catch on DioException (e) {
    print('Exception when calling HabitTrackerResourceApi->getAllHabitTrackersAsStream: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;HabitTracker&gt;**](HabitTracker.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/x-ndjson, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getHabitTracker**
> HabitTracker getHabitTracker(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHabitTrackerResourceApi();
final int id = 789; // int | 

try {
    final response = api.getHabitTracker(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HabitTrackerResourceApi->getHabitTracker: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**HabitTracker**](HabitTracker.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **partialUpdateHabitTracker**
> HabitTracker partialUpdateHabitTracker(id, habitTracker)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHabitTrackerResourceApi();
final int id = 789; // int | 
final HabitTracker habitTracker = ; // HabitTracker | 

try {
    final response = api.partialUpdateHabitTracker(id, habitTracker);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HabitTrackerResourceApi->partialUpdateHabitTracker: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **habitTracker** | [**HabitTracker**](HabitTracker.md)|  | 

### Return type

[**HabitTracker**](HabitTracker.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/merge-patch+json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateHabitTracker**
> HabitTracker updateHabitTracker(id, habitTracker)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHabitTrackerResourceApi();
final int id = 789; // int | 
final HabitTracker habitTracker = ; // HabitTracker | 

try {
    final response = api.updateHabitTracker(id, habitTracker);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HabitTrackerResourceApi->updateHabitTracker: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **habitTracker** | [**HabitTracker**](HabitTracker.md)|  | 

### Return type

[**HabitTracker**](HabitTracker.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

