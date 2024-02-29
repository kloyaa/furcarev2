import 'package:dio/dio.dart';
import 'package:furcarev2/consts/api.dart';

class ClientApi {
  Dio dio = Dio();
  ClientApi(String accessToken) {
    dio.options.baseUrl = baseUrl;
    dio.options.headers = {
      'Authorization': 'Bearer $accessToken',
      'nodex-user-origin': 'web',
      'nodex-access-key': 'v7pb6wylg4m0xf0kx5zzoved',
      'nodex-secret-key': 'glrvdwi46mq00fg1oqtdx3rg'
    };
  }

  Future<Response> getMeProfile() async {
    try {
      Response response = await dio.get('/user/v1/profile/me');
      return response;
    } on DioException {
      rethrow;
    }
  }
}
