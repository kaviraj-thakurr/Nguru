import 'package:dio/dio.dart';

class Networking {
  final _dio = Dio();
  late Response response;

  final baseUrl= "https://quickschool.niitnguru.com/mobileappservice/Api/";
  final stagingLink = "https://qsstg.niiteducation.com/mobileappservice/Api/";
  //Api fun for post API
  Future<dynamic> networkPost(
      {dynamic data, String? token, required String url,bool isStagingLink=false}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Cookie':
          'ApplicationGatewayAffinity=fd5afd7f96e90b728e72aecaa34c23d8; ApplicationGatewayAffinityCORS=fd5afd7f96e90b728e72aecaa34c23d8'
    };

    try {
      response = await _dio.post(
      isStagingLink ? stagingLink+url :   baseUrl+url,
        data: data,
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      if (e is DioError) {
        throw e.response ?? "Error occured";
      } else {
        throw Exception("Error");
      }
    }
  }

  //function for network get
  Future<dynamic> networkGet(
      {dynamic data,
      String? token,
      required String url,
      dynamic params}) async {
    final headers = {'Authorization': "$token"};
    try {
      response = await _dio.get(
        baseUrl+url,
        queryParameters: params,
        data: data,
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      if (e is DioError) {
        throw e.response ?? "Error occured";
      } else {
        throw Exception("Error");
      }
    }
  }
}
