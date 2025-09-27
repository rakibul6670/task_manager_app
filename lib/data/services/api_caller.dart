import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:task_manager_app/ui/controllers/auth_controllers.dart';

class ApiCaller {
  static final Logger logger = Logger();

  //===================== GET Request =========================================
  static Future<ApiResponse> getRequest({required String url}) async {
    try {
      final uri = Uri.parse(url);

      //----------- logger request ----------
      _logRequest(url);

    

      final http.Response response = await http.get(
        uri,
        headers: {"token": AuthControllers.accessToken ?? " "},
      );
      _logResponse(url, response);

      final statusCode = response.statusCode;

      if (statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: true,
          statusCode: statusCode,
          responseBody: decodeData,
        );
      } else {
        //--------FAILED----------------
        final decodeData = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: false,
          statusCode: statusCode,
          responseBody: decodeData,
        );
      }
    } on Exception catch (e) {
      return ApiResponse(
        isSuccess: false,
        statusCode: -1,
        responseBody: null,
        errorMessage: e.toString(),
      );
    }
  }


  //===================== POST Request =========================================
  static Future<ApiResponse> postRequest({
    required String url,
    required Map<String, dynamic> requestBody,
  }) async {
    try {
      final uri = Uri.parse(url);

      //----------- logger request ----------
      _logRequest(url);

      logger.i("Token : ${AuthControllers.accessToken}");
     

      final http.Response response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "token": AuthControllers.accessToken ?? "",
        },
        body: jsonEncode(requestBody),
      );
      _logResponse(url, response);

      final statusCode = response.statusCode;

      if (statusCode == 200 || statusCode == 201) {
        final decodeData = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: true,
          statusCode: statusCode,
          responseBody: decodeData,
        );
      } else {
        //--------FAILED----------------
        final decodeData = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: false,
          statusCode: statusCode,
          responseBody: decodeData["data"],
        );
      }
    } on Exception catch (e) {
      return ApiResponse(
        isSuccess: false,
        statusCode: -1,
        responseBody: null,
        errorMessage: e.toString(),
      );
    }
  }

  //--------------Logger Request ---------------
  static void _logRequest(String url, {dynamic requestBody}) {
    logger.i(
      "Request Url: $url \n"
      "RequestBody : $requestBody",
    );
  }

  //--------------Logger Response ---------------
  static void _logResponse(String url, http.Response response) {
    logger.i(
      "Request Url: $url \n "
      "StatusCode: ${response.statusCode} \n"
      "RequestBody : ${response.body} \n",
    );
  }
}

//====================this class handle response and error ==========================
class ApiResponse {
  final bool isSuccess;
  final int statusCode;
  final dynamic responseBody;
  final String? errorMessage;

  //--------------ApiResponse Constructor ------------------
  ApiResponse({
    required this.isSuccess,
    required this.statusCode,
    required this.responseBody,
    this.errorMessage,
  });

  //-----------------ApiResponse factory Constructor-----------------
  factory ApiResponse.fromJson(Map<String, dynamic> response) {
    return ApiResponse(
      isSuccess: response["isSuccess"],
      statusCode: response["statusCode"],
      responseBody: response["responseBody"],
      errorMessage: response["errorMessage"] ?? "Something went wrong!",
    );
  }
}
