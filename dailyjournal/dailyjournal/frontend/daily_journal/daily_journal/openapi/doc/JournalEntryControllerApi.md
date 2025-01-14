# openapi.api.JournalEntryControllerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createJournalEntry**](JournalEntryControllerApi.md#createjournalentry) | **POST** /api/journal | 
[**deleteJournalEntry**](JournalEntryControllerApi.md#deletejournalentry) | **DELETE** /api/journal/{id} | 
[**getAllJournalEntries**](JournalEntryControllerApi.md#getalljournalentries) | **GET** /api/journal | 
[**getJournalEntryById**](JournalEntryControllerApi.md#getjournalentrybyid) | **GET** /api/journal/{id} | 
[**updateJournalEntry**](JournalEntryControllerApi.md#updatejournalentry) | **PUT** /api/journal/{id} | 


# **createJournalEntry**
> JournalEntry createJournalEntry(journalEntry)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getJournalEntryControllerApi();
final JournalEntry journalEntry = ; // JournalEntry | 

try {
    final response = api.createJournalEntry(journalEntry);
    print(response);
} catch on DioException (e) {
    print('Exception when calling JournalEntryControllerApi->createJournalEntry: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **journalEntry** | [**JournalEntry**](JournalEntry.md)|  | 

### Return type

[**JournalEntry**](JournalEntry.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteJournalEntry**
> deleteJournalEntry(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getJournalEntryControllerApi();
final int id = 789; // int | 

try {
    api.deleteJournalEntry(id);
} catch on DioException (e) {
    print('Exception when calling JournalEntryControllerApi->deleteJournalEntry: $e\n');
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

# **getAllJournalEntries**
> BuiltList<JournalEntry> getAllJournalEntries()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getJournalEntryControllerApi();

try {
    final response = api.getAllJournalEntries();
    print(response);
} catch on DioException (e) {
    print('Exception when calling JournalEntryControllerApi->getAllJournalEntries: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;JournalEntry&gt;**](JournalEntry.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getJournalEntryById**
> JournalEntry getJournalEntryById(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getJournalEntryControllerApi();
final int id = 789; // int | 

try {
    final response = api.getJournalEntryById(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling JournalEntryControllerApi->getJournalEntryById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**JournalEntry**](JournalEntry.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateJournalEntry**
> JournalEntry updateJournalEntry(id, journalEntry)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getJournalEntryControllerApi();
final int id = 789; // int | 
final JournalEntry journalEntry = ; // JournalEntry | 

try {
    final response = api.updateJournalEntry(id, journalEntry);
    print(response);
} catch on DioException (e) {
    print('Exception when calling JournalEntryControllerApi->updateJournalEntry: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **journalEntry** | [**JournalEntry**](JournalEntry.md)|  | 

### Return type

[**JournalEntry**](JournalEntry.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

