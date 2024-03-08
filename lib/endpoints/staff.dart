import 'package:dio/dio.dart';
import 'package:furcarev2/consts/api.dart';

class StaffApi {
  Dio dio = Dio();
  StaffApi(String accessToken) {
    dio.options.baseUrl = baseUrl;
    dio.options.headers = {
      'Authorization': 'Bearer $accessToken',
      'nodex-user-origin': 'web',
      'nodex-access-key': 'v7pb6wylg4m0xf0kx5zzoved',
      'nodex-secret-key': 'glrvdwi46mq00fg1oqtdx3rg'
    };
  }

  Future<Response> getBookingsByAccessToken(String status) async {
    try {
      Response response = await dio.get(
        '/staff/v1/booking',
        queryParameters: {
          'status': status,
        },
      );
      return response;
    } on DioException {
      rethrow;
    }
  }
}
