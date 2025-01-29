# openapi.api.UserProfileResourceApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createUserProfile**](UserProfileResourceApi.md#createuserprofile) | **POST** /api/user-profiles | 
[**deleteUserProfile**](UserProfileResourceApi.md#deleteuserprofile) | **DELETE** /api/user-profiles/{id} | 
[**getAllUserProfilesAsStream**](UserProfileResourceApi.md#getalluserprofilesasstream) | **GET** /api/user-profiles | 
[**getUserProfile**](UserProfileResourceApi.md#getuserprofile) | **GET** /api/user-profiles/{id} | 
[**partialUpdateUserProfile**](UserProfileResourceApi.md#partialupdateuserprofile) | **PATCH** /api/user-profiles/{id} | 
[**updateUserProfile**](UserProfileResourceApi.md#updateuserprofile) | **PUT** /api/user-profiles/{id} | 


# **createUserProfile**
> UserProfile createUserProfile(userProfile)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserProfileResourceApi();
final UserProfile userProfile = ; // UserProfile | 

try {
    final response = api.createUserProfile(userProfile);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserProfileResourceApi->createUserProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userProfile** | [**UserProfile**](UserProfile.md)|  | 

### Return type

[**UserProfile**](UserProfile.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteUserProfile**
> deleteUserProfile(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserProfileResourceApi();
final int id = 789; // int | 

try {
    api.deleteUserProfile(id);
} catch on DioException (e) {
    print('Exception when calling UserProfileResourceApi->deleteUserProfile: $e\n');
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

# **getAllUserProfilesAsStream**
> BuiltList<UserProfile> getAllUserProfilesAsStream(eagerload)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserProfileResourceApi();
final bool eagerload = true; // bool | 

try {
    final response = api.getAllUserProfilesAsStream(eagerload);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserProfileResourceApi->getAllUserProfilesAsStream: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **eagerload** | **bool**|  | [optional] [default to true]

### Return type

[**BuiltList&lt;UserProfile&gt;**](UserProfile.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/x-ndjson, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserProfile**
> UserProfile getUserProfile(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserProfileResourceApi();
final int id = 789; // int | 

try {
    final response = api.getUserProfile(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserProfileResourceApi->getUserProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**UserProfile**](UserProfile.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **partialUpdateUserProfile**
> UserProfile partialUpdateUserProfile(id, userProfile)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserProfileResourceApi();
final int id = 789; // int | 
final UserProfile userProfile = ; // UserProfile | 

try {
    final response = api.partialUpdateUserProfile(id, userProfile);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserProfileResourceApi->partialUpdateUserProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **userProfile** | [**UserProfile**](UserProfile.md)|  | 

### Return type

[**UserProfile**](UserProfile.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/merge-patch+json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateUserProfile**
> UserProfile updateUserProfile(id, userProfile)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserProfileResourceApi();
final int id = 789; // int | 
final UserProfile userProfile = ; // UserProfile | 

try {
    final response = api.updateUserProfile(id, userProfile);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserProfileResourceApi->updateUserProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **userProfile** | [**UserProfile**](UserProfile.md)|  | 

### Return type

[**UserProfile**](UserProfile.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

