import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart' as http;
import 'package:parker_mobile_framework/Network/ApiResponse.dart';
import 'package:parker_mobile_framework/Network/AppException.dart';
import 'package:parker_mobile_framework/Utility/MyConstants.dart';

class ApiBase {

   ApiBase({this.url});

  final String url;
  

 

  Future<dynamic> get() async {
    try {
     final http.Response response =
          await http.get(Base_server_URL, headers: <String, String>{
        'Ocp-Apim-Subscription-Key': OcpApimSubscriptionKey,
        'Content-Type': 'application/json'
      });
      print(Base_server_URL);
      print(response.statusCode);
      print(response.body);
      var responseJson = _proceesRequest(response);
      return responseJson;
    } on SocketException {
      FetchDataException('No Internet connections');
    } catch (error) {
      ApiResponse<dynamic>.error(error.toString());
    }
  }

  dynamic _proceesRequest(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

//   static var queryParams = {
//     'sleep': '30',
//     'maxon': '120',
//   };
//   String queryString = Uri(queryParameters: queryParams).query;
//   Future<HeaterModel> putheater(String body, BuildContext context) async {
//     final response = await http.put(Base_server_URL + '?' + queryString,
//         headers: <String, String>{
//           'Ocp-Apim-Subscription-Key': OcpApimSubscriptionKey,
//           'Content-Type': 'application/json',
//         },
//         body: body);

//     if (response.statusCode == 202) {
//       print(response.body);
//       return HeaterModel.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to load Header');
//     }
//   }
 }

// class ServiceManager extends ApiBase {
//   ServiceManager(serviceUrl) : super(url: Base_server_URL + serviceUrl);
// }
