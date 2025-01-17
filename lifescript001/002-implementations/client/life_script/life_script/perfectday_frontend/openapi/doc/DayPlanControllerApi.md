# openapi.api.DayPlanControllerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createDayPlan**](DayPlanControllerApi.md#createdayplan) | **POST** /api/dayplans | 
[**deleteDayPlan**](DayPlanControllerApi.md#deletedayplan) | **DELETE** /api/dayplans/{id} | 
[**getAllDayPlans**](DayPlanControllerApi.md#getalldayplans) | **GET** /api/dayplans | 
[**getDayPlanById**](DayPlanControllerApi.md#getdayplanbyid) | **GET** /api/dayplans/{id} | 
[**updateDayPlan**](DayPlanControllerApi.md#updatedayplan) | **PUT** /api/dayplans/{id} | 


# **createDayPlan**
> DayPlan createDayPlan(dayPlan)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getDayPlanControllerApi();
final DayPlan dayPlan = ; // DayPlan | 

try {
    final response = api.createDayPlan(dayPlan);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DayPlanControllerApi->createDayPlan: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **dayPlan** | [**DayPlan**](DayPlan.md)|  | 

### Return type

[**DayPlan**](DayPlan.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteDayPlan**
> deleteDayPlan(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getDayPlanControllerApi();
final int id = 789; // int | 

try {
    api.deleteDayPlan(id);
} catch on DioException (e) {
    print('Exception when calling DayPlanControllerApi->deleteDayPlan: $e\n');
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

# **getAllDayPlans**
> BuiltList<DayPlan> getAllDayPlans()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getDayPlanControllerApi();

try {
    final response = api.getAllDayPlans();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DayPlanControllerApi->getAllDayPlans: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;DayPlan&gt;**](DayPlan.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getDayPlanById**
> DayPlan getDayPlanById(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getDayPlanControllerApi();
final int id = 789; // int | 

try {
    final response = api.getDayPlanById(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DayPlanControllerApi->getDayPlanById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**DayPlan**](DayPlan.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateDayPlan**
> DayPlan updateDayPlan(id, dayPlan)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getDayPlanControllerApi();
final int id = 789; // int | 
final DayPlan dayPlan = ; // DayPlan | 

try {
    final response = api.updateDayPlan(id, dayPlan);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DayPlanControllerApi->updateDayPlan: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **dayPlan** | [**DayPlan**](DayPlan.md)|  | 

### Return type

[**DayPlan**](DayPlan.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

