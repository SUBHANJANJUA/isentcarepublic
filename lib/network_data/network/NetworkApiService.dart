import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:isentcare/network_data/handle_error.dart';
import 'package:isentcare/network_data/network/token_header.dart';

import '../app_excaptions.dart';
import 'BaseApiServices.dart';
import 'package:http_parser/http_parser.dart';

const secureStorage = FlutterSecureStorage();

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    final token = await secureStorage.read(key: 'accessToken');
    print("Fetching Educations from: $url");
    print("Access Token: $token");
    if (token == null || token.isEmpty) {
      throw Exception("No access token found. Please log in again.");
    }

    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.parse(url),
              headers: APIHeader.createAuthHeaders(token: token))
          .timeout(const Duration(seconds: 30));
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future getGetApiSimple(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(
        Uri.parse(url),
      );

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postApiResponse(String url, dynamic data) async {
    final token = await secureStorage.read(key: 'accessToken');
    print("Access Token: $token");
    log("API URL: $url");
    log("Request Payload: ${jsonEncode(data)}");
    dynamic responseJson;
    try {
      Response response = await post(Uri.parse(url),
              body: jsonEncode(data),
              headers: APIHeader.createAuthHeaders(token: token.toString()))
          .timeout(const Duration(seconds: 30));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    log("API URL: $url");
    log("Request Payload: ${jsonEncode(data)}");

    dynamic responseJson;
    try {
      final headers = {
        "Content-Type": "application/json",
      };

      Response response = await post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headers,
      ).timeout(
        const Duration(seconds: 30),
      );
      // Log response details for debugging
      log("Response Status Code: ${response.statusCode}");
      log("Response Body: ${response.body}");

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      log("Request timed out");
      throw FetchDataException('Request timed out');
    } catch (e) {
      log("Unexpected error: $e");
      throw FetchDataException('Unexpected error occurred: $e');
    }

    return responseJson;
  }

  // @override
  // Future getPostApiResponse(String url, Map<String, dynamic> data) async {
  //   dynamic responseJson;
  //   try {
  //     final token = await WebStorageService().getLocaldata(key: 'token') ?? "";
  //     Response response = await post(Uri.parse(url),
  //             headers: APIHeader.createAuthHeaders(token: token),
  //             body: jsonEncode(data))
  //         .timeout(const Duration(seconds: 60));
  //     responseJson = returnResponse(response);
  //   } on SocketException catch (e) {
  //     log(e.toString());
  //     log(e.message);
  //     log(e.address.toString());

  //     throw FetchDataException('No Internet Connection');
  //   }

  //   return responseJson;
  // }

  // @override
  // Future editProfileMultiPart(data, url) async {
  //   dynamic responseJson;
  //   log("profile image ${data["selfie"]}");

  //   try {
  //     final token = await WebStorageService().getLocaldata(key: 'token') ?? "";
  //     MultipartRequest response = http.MultipartRequest('PUT', Uri.parse(url));

  //     if (data["country"] != null) {
  //       response.fields['country'] = data['country'];
  //     }
  //     if (data["zipcode"] != null) {
  //       response.fields['zipcode'] = data['zipcode'];
  //     }
  //     if (data["city"] != null) {
  //       response.fields['city'] = data['city'];
  //     }

  //     response.headers.addAll(
  //       {"Accept": "application/json", 'auth-token': token},
  //     );

  //     if (data["selfie"] != null && data["selfie"] != "") {
  //       log("profile image ${data["selfie"]}");
  //       await addFileToMultipartRequest(response, "selfie", data["selfie"]);
  //     }

  //     http.Response res = await http.Response.fromStream(await response.send());

  //     responseJson = returnResponse(res);
  //   } on SocketException {
  //     throw FetchDataException('No Internet Connection');
  //   }

  //   return responseJson;
  // }

  dynamic returnResponse(http.Response response) {
    log(response.statusCode.toString());

    switch (response.statusCode) {
      case 200:
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 204:
        return null;
      case 400:
        String errorMessage = '';
        try {
          final responseBody = jsonDecode(response.body);
          log("Backend Response: $responseBody");

          if (responseBody.containsKey('email') &&
              responseBody['email'] is List) {
            errorMessage += responseBody['email'][0] + '\n';
          }
          if (responseBody.containsKey('phone') &&
              responseBody['phone'] is List) {
            errorMessage += responseBody['phone'][0] + '\n';
          }
          if (responseBody.containsKey('job')) {
            errorMessage += responseBody['job'];
          }

          if (responseBody.containsKey('details')) {
            errorMessage += responseBody['details'] + '\n';
          } else if (responseBody.containsKey('message')) {
            errorMessage += responseBody['message'] + '\n';
          }

          errorMessage = errorMessage.trim().isNotEmpty
              ? errorMessage.trim()
              : "Something went wrong.";

          log("Backend errorMessage: $errorMessage");
        } catch (e) {
          errorMessage = "An unexpected error occurred. Please try again.";
          log("Error parsing backend response: $e");
        }
        throw errorMessage;

      case 401:
      case 403:
        throw UnauthorisedException("Unauthorized: ${response.body}");
      case 500:
        throw 'Internal Server Error';
      case 404:
        throw response.body.toString();
      default:
        throw FetchDataException(
            'Error occured while communicating with server '
                    'with status code' +
                response.statusCode.toString());
    }
  }

  @override
  Future deleteApiResponse(String url) async {
    log(url);
    dynamic responseJson;
    try {
      final token = await secureStorage.read(key: 'accessToken');
      print("Delete from: $url");
      print("Access Token: $token");
      Response response = await delete(
        Uri.parse(url),
        headers: APIHeader.createAuthHeaders(token: token.toString()),
      ).timeout(const Duration(seconds: 30));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  // @override
  // Future putApiResponse(String url, data) async {
  //   dynamic responseJson;
  //   try {
  //     final token = await secureStorage.read(key: 'accessToken') ?? '';
  //     log("Access Token: $token");
  //     log("API URL: $url");
  //     // Serialize the data to JSON
  //     final String jsonData = jsonEncode(data);
  //     Response response = await put(Uri.parse(url),
  //             headers: APIHeader.createAuthHeaders(token: token),
  //             body: jsonData)
  //         .timeout(const Duration(seconds: 30));
  //     log("Response Status Code: ${response.statusCode}");
  //     log("Response Body: ${response.body}");
  //     responseJson = returnResponse(response);
  //   } on SocketException {
  //     throw FetchDataException('No Internet Connection');
  //   }

  //   return responseJson;
  // }
  @override
  Future patchApi(String url) async {
    dynamic responseJson;
    try {
      final token = await secureStorage.read(key: 'accessToken') ?? '';
      log("Access Token: $token");
      log("API URL: $url");

      Response response = await patch(Uri.parse(url),
              headers: APIHeader.createAuthHeaders(token: token.toString()))
          .timeout(const Duration(seconds: 30));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future patchApiResponse(String url, data) async {
    log("${data}");
    dynamic responseJson;
    try {
      final token = await secureStorage.read(key: 'accessToken') ?? '';
      log("Access Token: $token");
      log("API URL: $url");
      // Serialize the data to JSON
      final String jsonData = jsonEncode(data);
      Response response = await patch(Uri.parse(url),
              headers: APIHeader.createAuthHeaders(token: token),
              body: jsonData)
          .timeout(const Duration(seconds: 30));
      log("Response Status Code: ${response.statusCode}");
      log("Response Body: ${response.body}");
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  Future<void> addFileToMultipartRequest(
      http.MultipartRequest request, String fieldName, dynamic file) async {
    if (file != null) {
      var fileBytes = await file.readAsBytes();
      var multipartFile = http.MultipartFile.fromBytes(
        fieldName,
        fileBytes,
        filename:
            file.uri.pathSegments.last, // Use the last segment as the filename
        contentType:
            MediaType('image', 'jpeg'), // Adjust based on the image format
      );
      request.files.add(multipartFile);
    }
  }

  @override
  Future multiPartSignUp(url, data) async {
    dynamic responseJson;
    try {
      var uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri);

      // Add all fields as form data
      request.fields.addAll(data.toMap());

      // Add file if it exists (for profile image)
      if (data.dp != null) {
        await addFileToMultipartRequest(
            request,
            'dp', // Your API's file field name
            data.dp // This should be a File
            );
      }

      // Send the request
      var response = await request.send();
      final responseString = await response.stream.bytesToString();
      log('Response Status: ${response.statusCode}');
      log('Response Body: $responseString');

      // Handle the response
      try {
        final httpResponse = http.Response(responseString, response.statusCode);
        responseJson = returnResponse(httpResponse);
      } catch (e) {
        log("Error in SignUp: $e");
        HandleError.handleError(e);
      }
    } catch (e) {
      log('Error: $e');
      throw FetchDataException('An unexpected error occurred');
    }
    return responseJson;
  }

  @override
  Future multiPartLicenseCreate(url, data) async {
    log("data is $data");
    dynamic responseJson;
    try {
      final token = await secureStorage.read(key: 'accessToken') ?? '';

      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields['number'] = data['number']
        ..fields['expiry_date'] = data['expiry_date']
        ..fields['profession'] = data['profession'].toString()
        ..fields['primary_state'] = data['primary_state'].toString();

      if (data['state'] is List) {
        // For multiple states, add each one as a separate 'state' field
        for (var state in data['state']) {
          request.fields.addAll({'state': state.toString()}); // Use addAll here
        }
      } else {
        // Add single state directly
        request.fields['state'] = data['state'].toString();
      }

      log("Request fields: ${request.fields}");
      log("Request token: ${token}");

      request.headers.addAll({
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });

      http.Response res = await http.Response.fromStream(await request.send());

      responseJson = returnResponse(res);
    } catch (e) {
      log('An unexpected error occurred: $e');
      throw FetchDataException('An unexpected error occurred');
    }
    return responseJson;
  }
}
