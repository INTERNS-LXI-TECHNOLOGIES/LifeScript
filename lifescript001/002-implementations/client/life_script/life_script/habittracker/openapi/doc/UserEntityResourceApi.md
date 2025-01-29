# openapi.api.UserEntityResourceApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createUserEntity**](UserEntityResourceApi.md#createuserentity) | **POST** /api/user-entities | 
[**deleteUserEntity**](UserEntityResourceApi.md#deleteuserentity) | **DELETE** /api/user-entities/{id} | 
[**getAllUserEntitiesAsStream**](UserEntityResourceApi.md#getalluserentitiesasstream) | **GET** /api/user-entities | 
[**getUserEntity**](UserEntityResourceApi.md#getuserentity) | **GET** /api/user-entities/{id} | 
[**partialUpdateUserEntity**](UserEntityResourceApi.md#partialupdateuserentity) | **PATCH** /api/user-entities/{id} | 
[**updateUserEntity**](UserEntityResourceApi.md#updateuserentity) | **PUT** /api/user-entities/{id} | 


# **createUserEntity**
> UserEntity createUserEntity(userEntity)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserEntityResourceApi();
final UserEntity userEntity = ; // UserEntity | 

try {
    final response = api.createUserEntity(userEntity);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserEntityResourceApi->createUserEntity: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userEntity** | [**UserEntity**](UserEntity.md)|  | 

### Return type

[**UserEntity**](UserEntity.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteUserEntity**
> deleteUserEntity(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserEntityResourceApi();
final int id = 789; // int | 

try {
    api.deleteUserEntity(id);
} catch on DioException (e) {
    print('Exception when calling UserEntityResourceApi->deleteUserEntity: $e\n');
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

# **getAllUserEntitiesAsStream**
> BuiltList<UserEntity> getAllUserEntitiesAsStream()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserEntityResourceApi();

try {
    final response = api.getAllUserEntitiesAsStream();
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserEntityResourceApi->getAllUserEntitiesAsStream: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;UserEntity&gt;**](UserEntity.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/x-ndjson, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserEntity**
> UserEntity getUserEntity(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserEntityResourceApi();
final int id = 789; // int | 

try {
    final response = api.getUserEntity(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserEntityResourceApi->getUserEntity: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**UserEntity**](UserEntity.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **partialUpdateUserEntity**
> UserEntity partialUpdateUserEntity(id, userEntity)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserEntityResourceApi();
final int id = 789; // int | 
final UserEntity userEntity = ; // UserEntity | 

try {
    final response = api.partialUpdateUserEntity(id, userEntity);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserEntityResourceApi->partialUpdateUserEntity: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **userEntity** | [**UserEntity**](UserEntity.md)|  | 

### Return type

[**UserEntity**](UserEntity.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/merge-patch+json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateUserEntity**
> UserEntity updateUserEntity(id, userEntity)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserEntityResourceApi();
final int id = 789; // int | 
final UserEntity userEntity = ; // UserEntity | 

try {
    final response = api.updateUserEntity(id, userEntity);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserEntityResourceApi->updateUserEntity: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **userEntity** | [**UserEntity**](UserEntity.md)|  | 

### Return type

[**UserEntity**](UserEntity.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

