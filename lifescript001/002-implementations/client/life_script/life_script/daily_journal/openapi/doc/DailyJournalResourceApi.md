# openapi.api.DailyJournalResourceApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://192.168.170.4:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createDailyJournal**](DailyJournalResourceApi.md#createdailyjournal) | **POST** /api/daily-journals | 
[**deleteDailyJournal**](DailyJournalResourceApi.md#deletedailyjournal) | **DELETE** /api/daily-journals/{id} | 
[**getAllDailyJournalsAsStream1**](DailyJournalResourceApi.md#getalldailyjournalsasstream1) | **GET** /api/daily-journals | 
[**getDailyJournal**](DailyJournalResourceApi.md#getdailyjournal) | **GET** /api/daily-journals/{id} | 
[**partialUpdateDailyJournal**](DailyJournalResourceApi.md#partialupdatedailyjournal) | **PATCH** /api/daily-journals/{id} | 
[**updateDailyJournal**](DailyJournalResourceApi.md#updatedailyjournal) | **PUT** /api/daily-journals/{id} | 


# **createDailyJournal**
> DailyJournal createDailyJournal(dailyJournal)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getDailyJournalResourceApi();
final DailyJournal dailyJournal = ; // DailyJournal | 

try {
    final response = api.createDailyJournal(dailyJournal);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DailyJournalResourceApi->createDailyJournal: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **dailyJournal** | [**DailyJournal**](DailyJournal.md)|  | 

### Return type

[**DailyJournal**](DailyJournal.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteDailyJournal**
> deleteDailyJournal(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getDailyJournalResourceApi();
final int id = 789; // int | 

try {
    api.deleteDailyJournal(id);
} catch on DioException (e) {
    print('Exception when calling DailyJournalResourceApi->deleteDailyJournal: $e\n');
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

# **getAllDailyJournalsAsStream1**
> BuiltList<DailyJournal> getAllDailyJournalsAsStream1()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getDailyJournalResourceApi();

try {
    final response = api.getAllDailyJournalsAsStream1();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DailyJournalResourceApi->getAllDailyJournalsAsStream1: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;DailyJournal&gt;**](DailyJournal.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/x-ndjson, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getDailyJournal**
> DailyJournal getDailyJournal(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getDailyJournalResourceApi();
final int id = 789; // int | 

try {
    final response = api.getDailyJournal(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DailyJournalResourceApi->getDailyJournal: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**DailyJournal**](DailyJournal.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **partialUpdateDailyJournal**
> DailyJournal partialUpdateDailyJournal(id, dailyJournal)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getDailyJournalResourceApi();
final int id = 789; // int | 
final DailyJournal dailyJournal = ; // DailyJournal | 

try {
    final response = api.partialUpdateDailyJournal(id, dailyJournal);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DailyJournalResourceApi->partialUpdateDailyJournal: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **dailyJournal** | [**DailyJournal**](DailyJournal.md)|  | 

### Return type

[**DailyJournal**](DailyJournal.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/merge-patch+json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateDailyJournal**
> DailyJournal updateDailyJournal(id, dailyJournal)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getDailyJournalResourceApi();
final int id = 789; // int | 
final DailyJournal dailyJournal = ; // DailyJournal | 

try {
    final response = api.updateDailyJournal(id, dailyJournal);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DailyJournalResourceApi->updateDailyJournal: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **dailyJournal** | [**DailyJournal**](DailyJournal.md)|  | 

### Return type

[**DailyJournal**](DailyJournal.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

