# openapi.api.MediaContentResourceApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createMediaContent**](MediaContentResourceApi.md#createmediacontent) | **POST** /api/media-contents | 
[**deleteMediaContent**](MediaContentResourceApi.md#deletemediacontent) | **DELETE** /api/media-contents/{id} | 
[**getAllMediaContentsAsStream**](MediaContentResourceApi.md#getallmediacontentsasstream) | **GET** /api/media-contents | 
[**getMediaContent**](MediaContentResourceApi.md#getmediacontent) | **GET** /api/media-contents/{id} | 
[**partialUpdateMediaContent**](MediaContentResourceApi.md#partialupdatemediacontent) | **PATCH** /api/media-contents/{id} | 
[**updateMediaContent**](MediaContentResourceApi.md#updatemediacontent) | **PUT** /api/media-contents/{id} | 


# **createMediaContent**
> MediaContent createMediaContent(mediaContent)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getMediaContentResourceApi();
final MediaContent mediaContent = ; // MediaContent | 

try {
    final response = api.createMediaContent(mediaContent);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MediaContentResourceApi->createMediaContent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **mediaContent** | [**MediaContent**](MediaContent.md)|  | 

### Return type

[**MediaContent**](MediaContent.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteMediaContent**
> deleteMediaContent(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getMediaContentResourceApi();
final int id = 789; // int | 

try {
    api.deleteMediaContent(id);
} catch on DioException (e) {
    print('Exception when calling MediaContentResourceApi->deleteMediaContent: $e\n');
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

# **getAllMediaContentsAsStream**
> BuiltList<MediaContent> getAllMediaContentsAsStream()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getMediaContentResourceApi();

try {
    final response = api.getAllMediaContentsAsStream();
    print(response);
} catch on DioException (e) {
    print('Exception when calling MediaContentResourceApi->getAllMediaContentsAsStream: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;MediaContent&gt;**](MediaContent.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/x-ndjson, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMediaContent**
> MediaContent getMediaContent(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getMediaContentResourceApi();
final int id = 789; // int | 

try {
    final response = api.getMediaContent(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MediaContentResourceApi->getMediaContent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**MediaContent**](MediaContent.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **partialUpdateMediaContent**
> MediaContent partialUpdateMediaContent(id, mediaContent)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getMediaContentResourceApi();
final int id = 789; // int | 
final MediaContent mediaContent = ; // MediaContent | 

try {
    final response = api.partialUpdateMediaContent(id, mediaContent);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MediaContentResourceApi->partialUpdateMediaContent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **mediaContent** | [**MediaContent**](MediaContent.md)|  | 

### Return type

[**MediaContent**](MediaContent.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/merge-patch+json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateMediaContent**
> MediaContent updateMediaContent(id, mediaContent)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getMediaContentResourceApi();
final int id = 789; // int | 
final MediaContent mediaContent = ; // MediaContent | 

try {
    final response = api.updateMediaContent(id, mediaContent);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MediaContentResourceApi->updateMediaContent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **mediaContent** | [**MediaContent**](MediaContent.md)|  | 

### Return type

[**MediaContent**](MediaContent.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

