# openapi.api.AuthorityResourceApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://172.20.10.11:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createAuthority**](AuthorityResourceApi.md#createauthority) | **POST** /api/authorities | 
[**deleteAuthority**](AuthorityResourceApi.md#deleteauthority) | **DELETE** /api/authorities/{id} | 
[**getAllAuthoritiesAsStream**](AuthorityResourceApi.md#getallauthoritiesasstream) | **GET** /api/authorities | 
[**getAuthority**](AuthorityResourceApi.md#getauthority) | **GET** /api/authorities/{id} | 


# **createAuthority**
> Authority createAuthority(authority)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthorityResourceApi();
final Authority authority = ; // Authority | 

try {
    final response = api.createAuthority(authority);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthorityResourceApi->createAuthority: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authority** | [**Authority**](Authority.md)|  | 

### Return type

[**Authority**](Authority.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteAuthority**
> deleteAuthority(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthorityResourceApi();
final String id = id_example; // String | 

try {
    api.deleteAuthority(id);
} catch on DioException (e) {
    print('Exception when calling AuthorityResourceApi->deleteAuthority: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllAuthoritiesAsStream**
> BuiltList<Authority> getAllAuthoritiesAsStream()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthorityResourceApi();

try {
    final response = api.getAllAuthoritiesAsStream();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthorityResourceApi->getAllAuthoritiesAsStream: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;Authority&gt;**](Authority.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/x-ndjson, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAuthority**
> Authority getAuthority(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthorityResourceApi();
final String id = id_example; // String | 

try {
    final response = api.getAuthority(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthorityResourceApi->getAuthority: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**Authority**](Authority.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

