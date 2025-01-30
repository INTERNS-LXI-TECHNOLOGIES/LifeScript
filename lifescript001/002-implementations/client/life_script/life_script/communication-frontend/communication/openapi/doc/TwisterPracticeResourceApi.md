# openapi.api.TwisterPracticeResourceApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createTwisterPractice**](TwisterPracticeResourceApi.md#createtwisterpractice) | **POST** /api/twister-practices | 
[**deleteTwisterPractice**](TwisterPracticeResourceApi.md#deletetwisterpractice) | **DELETE** /api/twister-practices/{id} | 
[**getAllTwisterPracticesAsStream**](TwisterPracticeResourceApi.md#getalltwisterpracticesasstream) | **GET** /api/twister-practices | 
[**getTwisterPractice**](TwisterPracticeResourceApi.md#gettwisterpractice) | **GET** /api/twister-practices/{id} | 
[**partialUpdateTwisterPractice**](TwisterPracticeResourceApi.md#partialupdatetwisterpractice) | **PATCH** /api/twister-practices/{id} | 
[**updateTwisterPractice**](TwisterPracticeResourceApi.md#updatetwisterpractice) | **PUT** /api/twister-practices/{id} | 


# **createTwisterPractice**
> TwisterPractice createTwisterPractice(twisterPractice)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getTwisterPracticeResourceApi();
final TwisterPractice twisterPractice = ; // TwisterPractice | 

try {
    final response = api.createTwisterPractice(twisterPractice);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TwisterPracticeResourceApi->createTwisterPractice: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **twisterPractice** | [**TwisterPractice**](TwisterPractice.md)|  | 

### Return type

[**TwisterPractice**](TwisterPractice.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteTwisterPractice**
> deleteTwisterPractice(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getTwisterPracticeResourceApi();
final int id = 789; // int | 

try {
    api.deleteTwisterPractice(id);
} catch on DioException (e) {
    print('Exception when calling TwisterPracticeResourceApi->deleteTwisterPractice: $e\n');
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

# **getAllTwisterPracticesAsStream**
> BuiltList<TwisterPractice> getAllTwisterPracticesAsStream()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getTwisterPracticeResourceApi();

try {
    final response = api.getAllTwisterPracticesAsStream();
    print(response);
} catch on DioException (e) {
    print('Exception when calling TwisterPracticeResourceApi->getAllTwisterPracticesAsStream: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;TwisterPractice&gt;**](TwisterPractice.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/x-ndjson, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTwisterPractice**
> TwisterPractice getTwisterPractice(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getTwisterPracticeResourceApi();
final int id = 789; // int | 

try {
    final response = api.getTwisterPractice(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TwisterPracticeResourceApi->getTwisterPractice: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**TwisterPractice**](TwisterPractice.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **partialUpdateTwisterPractice**
> TwisterPractice partialUpdateTwisterPractice(id, twisterPractice)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getTwisterPracticeResourceApi();
final int id = 789; // int | 
final TwisterPractice twisterPractice = ; // TwisterPractice | 

try {
    final response = api.partialUpdateTwisterPractice(id, twisterPractice);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TwisterPracticeResourceApi->partialUpdateTwisterPractice: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **twisterPractice** | [**TwisterPractice**](TwisterPractice.md)|  | 

### Return type

[**TwisterPractice**](TwisterPractice.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/merge-patch+json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateTwisterPractice**
> TwisterPractice updateTwisterPractice(id, twisterPractice)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getTwisterPracticeResourceApi();
final int id = 789; // int | 
final TwisterPractice twisterPractice = ; // TwisterPractice | 

try {
    final response = api.updateTwisterPractice(id, twisterPractice);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TwisterPracticeResourceApi->updateTwisterPractice: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **twisterPractice** | [**TwisterPractice**](TwisterPractice.md)|  | 

### Return type

[**TwisterPractice**](TwisterPractice.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

