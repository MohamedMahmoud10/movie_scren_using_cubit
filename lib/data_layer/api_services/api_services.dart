import 'package:blok_project/constans/strings.dart';
import 'package:dio/dio.dart';

class ApiServices {
  late Dio _dio;

  ApiServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 60 * 1000,
      receiveTimeout: 60 * 1000,
    );
    _dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharactersData() async {
    try {
      final Response res = await _dio.get('characters');
      print(res.data.toString());
      return res.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getCharactersQuote(String charName) async {
    try {
      final res = await _dio.get(
        'quote',
        queryParameters: {'author': charName},
      );
      print(res.data.toString());
      return res.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
