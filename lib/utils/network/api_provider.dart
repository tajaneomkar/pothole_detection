import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:pothole_detection/services/service_locator.dart';
import 'package:pothole_detection/services/shared_preference_service.dart';
import 'package:pothole_detection/utils/network/custom_exception.dart';
import 'package:pothole_detection/utils/network/log.dart';

class ApiProvider {
  Future<dynamic> uploadFile({
    required String subUrl,
    required String baseUrl,
    required Uint8List file,
    Map<String, String>? body,
  }) async {
    var headers = <String, String>{};
    headers["Content-Type"] = "multipart/form-data";
    headers["Authorization"] =
        "Bearer ${serviceLocator<SharedPreferencesService>().authToken}";

    try {
      dynamic responseJson;

      final request = http.MultipartRequest(
        'POST',
        Uri.parse("$baseUrl$subUrl"),
      );

      request.headers.addAll(headers);

      if (body != null) {
        request.fields.addAll(body);
      }

      request.files.add(http.MultipartFile.fromBytes(
        "file",
        file,
        filename: "file ${file.toString()}",
      ));

      final response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        responseJson = await response.stream.bytesToString();

        if (responseJson == null) return null;
        return responseJson;
      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      Log.error("ApiProvider get  failed with timeout");
      return null;
    } catch (e) {
      Log.error("ApiProvider get failed with error $e");
      return null;
    }
  }

  Future<dynamic> getData({
    required String subUrl,
    required String baseUrl,
    Map<String, dynamic>? body,
  }) async {
    var headers = <String, String>{};
    headers["Content-Type"] = "application/json";
    headers["Authorization"] =
        "Bearer ${serviceLocator<SharedPreferencesService>().authToken}";

    try {
      dynamic responseJson;

      final response = await http.post(
        Uri.parse("$baseUrl$subUrl"),
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        responseJson = _response(response);

        if (responseJson == null) return null;
        return responseJson;
      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      Log.error("ApiProvider get  failed with timeout");
      return null;
    } catch (e) {
      Log.error("ApiProvider get failed with error $e");
      return null;
    }
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        Log.error(response.body.toString());
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        Log.error(response.body.toString());
        throw UnauthorizedException(response.body.toString());
      case 500:
      default:
        Log.error(response.body.toString());
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
