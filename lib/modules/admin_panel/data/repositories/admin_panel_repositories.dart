import 'package:either_dart/either.dart';
import 'package:pothole_detection/config/env_config.dart';
import 'package:pothole_detection/modules/admin_panel/data/model/admin_panel_request_model.dart';
import 'package:pothole_detection/modules/admin_panel/data/model/admin_update_status_request_model.dart';
import 'package:pothole_detection/modules/admin_panel/data/model/get_pot_hole_by_admin_uid_request_model.dart';
import 'package:pothole_detection/modules/admin_panel/data/model/verify_pothole_img_request.dart';
import 'package:pothole_detection/modules/admin_panel/domain/repositories/repositories.dart';

import 'package:pothole_detection/utils/error/failure.dart';
import 'package:pothole_detection/utils/network/api_provider.dart';

class GetAllPotHoleInformationAdminImpl
    implements GetAllPotHoleInformationAdminRepo {
  final _apiProvider = ApiProvider();

  @override
  Future<Either<Failure, dynamic>> getAllAdminInfo(
      {required AdminPanelRequestModel body}) async {
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

class GetAllPotHoleInformationByAdminUIdRepoImpl
    implements GetAllPotHoleInformationByAdminUIdRepo {
  final _apiProvider = ApiProvider();

  @override
  Future<Either<Failure, dynamic>> getAdminInformation(
      {required GetPotHoleInformationByAdminUIdRequestModel body}) async {
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

class AdminUpdateStatusRepoImpl implements AdminUpdateStatusRepo {
  final _apiProvider = ApiProvider();

  @override
  Future<Either<Failure, dynamic>> adminUpdateStatus(
      {required AdminUpdateStatusRequestModel body}) async {
    dynamic response;

    try {
      response = await _apiProvider.putData(
          baseUrl: EnvConfig.POTHOLEBASEURL,
          subUrl: "/api/information/updateInformation",
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

class VerifyImageRepoImpl implements VerifyImageRepo {
  final _apiProvider = ApiProvider();

  @override
  Future<Either<Failure, dynamic>> verifyImage(
      {required VerifyPotholeImgRequestModel body}) async {
    dynamic response;

    try {
      response = await _apiProvider.getData(
          baseUrl: EnvConfig.POTHOLEBASEURL,
          subUrl: "/api/information/verifyPothole",
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
