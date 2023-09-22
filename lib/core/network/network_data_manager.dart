import 'package:dio/dio.dart';
import 'package:exercise_finder/core/constants/dio_constants.dart';
import 'dio_exceptions.dart';

class NetworkDataManager {
  Dio dio = Dio();

  Future<Response> get(String path, {queryParameters}) async {
    try {
      final response = await dio.get(path,
          queryParameters: queryParameters,
          options: Options(headers: {
            "X-RapidAPI-Key": DioConstants.apiKey,
            "X-RapidAPI-Host": DioConstants.apiHost,
          }));
      return response;
    } on DioException catch (err) {
      throw handleException(err);
    }
  }
}
