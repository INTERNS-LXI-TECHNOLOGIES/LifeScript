# openapi.api.PerfectDayResourceApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://192.168.170.186:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createPerfectDay**](PerfectDayResourceApi.md#createperfectday) | **POST** /api/perfect-days | 
[**deletePerfectDay**](PerfectDayResourceApi.md#deleteperfectday) | **DELETE** /api/perfect-days/{id} | 
[**getAllPerfectDays**](PerfectDayResourceApi.md#getallperfectdays) | **GET** /api/perfect-days | 
[**getPerfectDay**](PerfectDayResourceApi.md#getperfectday) | **GET** /api/perfect-days/{id} | 
[**partialUpdatePerfectDay**](PerfectDayResourceApi.md#partialupdateperfectday) | **PATCH** /api/perfect-days/{id} | 
[**updatePerfectDay**](PerfectDayResourceApi.md#updateperfectday) | **PUT** /api/perfect-days/{id} | 


# **createPerfectDay**
> PerfectDay createPerfectDay(perfectDay)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPerfectDayResourceApi();
final PerfectDay perfectDay = ; // PerfectDay | 

try {
    final response = api.createPerfectDay(perfectDay);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PerfectDayResourceApi->createPerfectDay: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **perfectDay** | [**PerfectDay**](PerfectDay.md)|  | 

### Return type

[**PerfectDay**](PerfectDay.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deletePerfectDay**
> deletePerfectDay(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPerfectDayResourceApi();
final int id = 789; // int | 

try {
    api.deletePerfectDay(id);
} catch on DioException (e) {
    print('Exception when calling PerfectDayResourceApi->deletePerfectDay: $e\n');
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

# **getAllPerfectDays**
> BuiltList<PerfectDay> getAllPerfectDays()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPerfectDayResourceApi();

try {
    final response = api.getAllPerfectDays();
    print(response);
} catch on DioException (e) {
    print('Exception when calling PerfectDayResourceApi->getAllPerfectDays: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;PerfectDay&gt;**](PerfectDay.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPerfectDay**
> PerfectDay getPerfectDay(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPerfectDayResourceApi();
final int id = 789; // int | 

try {
    final response = api.getPerfectDay(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PerfectDayResourceApi->getPerfectDay: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**PerfectDay**](PerfectDay.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **partialUpdatePerfectDay**
> PerfectDay partialUpdatePerfectDay(id, perfectDay)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPerfectDayResourceApi();
final int id = 789; // int | 
final PerfectDay perfectDay = ; // PerfectDay | 

try {
    final response = api.partialUpdatePerfectDay(id, perfectDay);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PerfectDayResourceApi->partialUpdatePerfectDay: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **perfectDay** | [**PerfectDay**](PerfectDay.md)|  | 

### Return type

[**PerfectDay**](PerfectDay.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/merge-patch+json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updatePerfectDay**
> PerfectDay updatePerfectDay(id, perfectDay)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPerfectDayResourceApi();
final int id = 789; // int | 
final PerfectDay perfectDay = ; // PerfectDay | 

try {
    final response = api.updatePerfectDay(id, perfectDay);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PerfectDayResourceApi->updatePerfectDay: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **perfectDay** | [**PerfectDay**](PerfectDay.md)|  | 

### Return type

[**PerfectDay**](PerfectDay.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

