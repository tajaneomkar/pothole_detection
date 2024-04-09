import 'dart:typed_data';
import 'package:either_dart/either.dart';
import 'package:pothole_detection/config/env_config.dart';
import 'package:pothole_detection/modules/user_panel/data/model/get_pot_hole_by_uid_request_model.dart';
import 'package:pothole_detection/modules/user_panel/data/model/register_user_request_model.dart';
import 'package:pothole_detection/modules/user_panel/data/model/user_panel_request_model.dart';
import 'package:pothole_detection/modules/user_panel/domain/repositories/repositories.dart';
import 'package:pothole_detection/utils/error/failure.dart';
import 'package:pothole_detection/utils/network/api_provider.dart';

class GetAllPotHoleInformationImpl implements GetAllPotHoleInformationRepo {
  final _apiProvider = ApiProvider();

  @override
  Future<Either<Failure, dynamic>> getAll(
      {required UserPanelRequestModel body}) async {
    dynamic response;

    try {
      response = await _apiProvider.getData(
          baseUrl: EnvConfig.POTHOLEBASEURL,
          subUrl: "/api/information/getAllPotholeInformation",
          body: body.toJson());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }

    if (response == null) {
      return Left(ServerFailure(message: 'No response from server'));
    } else {
      return Right(response);
    }
  }
}

class GetAllPotHoleInformationByUIdRepoImpl
    implements GetAllPotHoleInformationByUIdRepo {
  final _apiProvider = ApiProvider();

  @override
  Future<Either<Failure, dynamic>> getInformation(
      {required GetPotHoleInformationByUIdRequestModel body}) async {
    dynamic response;

    try {
      response = await _apiProvider.getData(
          baseUrl: EnvConfig.POTHOLEBASEURL,
          subUrl: "/api/information/getPotholeInformationById",
          body: body.toJson());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }

    if (response == null) {
      return Left(ServerFailure(message: 'No response from server'));
    } else {
      return Right(response);
    }
  }
}

class RegisterUserRepoImpl implements RegisterUserRepo {
  final _apiProvider = ApiProvider();

  @override
  Future<Either<Failure, dynamic>> register(
      {required RegisterUserRequestModel body}) async {
    dynamic response;

    try {
      response = await _apiProvider.getData(
          baseUrl: EnvConfig.POTHOLEBASEURL,
          subUrl: "/api/information/submitInformation",
          body: body.toJson());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }

    if (response == null) {
      return Left(ServerFailure(message: 'No response from server'));
    } else {
      return Right(response);
    }
  }
}

class UploadImageUserRepoImpl implements UploadImgUserRepo {
  final _apiProvider = ApiProvider();

  @override
  Future<Either<Failure, dynamic>> uploadImg({required Uint8List? body}) async {
    dynamic response;

    try {
      response = await _apiProvider.uploadFile(
        baseUrl: EnvConfig.POTHOLEBASEURL,
        subUrl: "/api/information/fileUpload",
        file: body ?? Uint8List(0),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }

    if (response == null) {
      return Left(ServerFailure(message: 'No response from server'));
    } else {
      return Right(response);
    }
  }
}
