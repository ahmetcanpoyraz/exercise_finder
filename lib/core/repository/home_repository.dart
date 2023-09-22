import 'dart:async';
import 'package:exercise_finder/core/models/response_model.dart';
import 'package:dartz/dartz.dart';
import '../constants/endpoints.dart';
import '../network/exceptions.dart';
import '../network/network_data_manager.dart';

class HomeRepository {
  HomeRepository._privateConstructor(this.networkDataManager);
  static final HomeRepository instance = HomeRepository._privateConstructor(NetworkDataManager());
  final NetworkDataManager networkDataManager;

  Future<Either<AppException, List<ResponseModel>>> getMuscles(String muscleName) async {
    List<ResponseModel> list = [];
    try {
      final response =
          await networkDataManager.get(Endpoints.baseUrl, queryParameters: {"muscle": muscleName});
      response.data.forEach((e) {
        list.add(ResponseModel.fromJson(e));
      });
      return Right(list);
    } on AppException catch (err) {
      return Left(
        AppException(
          err.message,
        ),
      );
    }
  }

  Future<Either<AppException, List<ResponseModel>>> getTypes(String typeName) async {
    List<ResponseModel> list = [];
    try {
      final response =
          await networkDataManager.get(Endpoints.baseUrl, queryParameters: {"type": typeName});
      response.data.forEach((e) {
        list.add(ResponseModel.fromJson(e));
      });
      return Right(list);
    } on AppException catch (err) {
      return Left(
        AppException(
          err.message,
        ),
      );
    }
  }
}
