import 'dart:io';
import 'dart:typed_data';
import 'package:either_dart/either.dart';
import 'package:pothole_detection/modules/user_panel/data/model/get_pot_hole_by_uid_request_model.dart';
import 'package:pothole_detection/modules/user_panel/data/model/register_user_request_model.dart';
import 'package:pothole_detection/modules/user_panel/data/model/user_panel_request_model.dart';
import 'package:pothole_detection/modules/user_panel/domain/repositories/repositories.dart';
import 'package:pothole_detection/services/service_locator.dart';
import 'package:pothole_detection/utils/error/failure.dart';
import 'package:pothole_detection/utils/usecase/use_case.dart';

class UserPanelUseCase
    implements UseCaseOneInput<UserPanelRequestModel, dynamic> {
  @override
  Future<Either<Failure, dynamic>> invoke(body) async {
    return await serviceLocator
        .get<GetAllPotHoleInformationRepo>()
        .getAll(body: body);
  }
}

class GetPotHoleByUIdUseCase
    implements
        UseCaseOneInput<GetPotHoleInformationByUIdRequestModel, dynamic> {
  @override
  Future<Either<Failure, dynamic>> invoke(body) async {
    return await serviceLocator
        .get<GetAllPotHoleInformationByUIdRepo>()
        .getInformation(body: body);
  }
}

class RegisterUserUseCase
    implements UseCaseOneInput<RegisterUserRequestModel, dynamic> {
  @override
  Future<Either<Failure, dynamic>> invoke(body) async {
    return await serviceLocator.get<RegisterUserRepo>().register(body: body);
  }
}

class UploadImageUserUseCase implements UseCaseOneInput<File?, dynamic> {
  @override
  Future<Either<Failure, dynamic>> invoke(body) async {
    return await serviceLocator.get<UploadImgUserRepo>().uploadImg(body: body);
  }
}
