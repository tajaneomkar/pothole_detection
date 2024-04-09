import 'dart:typed_data';
import 'package:either_dart/either.dart';
import 'package:pothole_detection/modules/user_panel/data/model/get_pot_hole_by_uid_request_model.dart';
import 'package:pothole_detection/modules/user_panel/data/model/register_user_request_model.dart';
import 'package:pothole_detection/modules/user_panel/data/model/user_panel_request_model.dart';
import 'package:pothole_detection/utils/error/failure.dart';

abstract class GetAllPotHoleInformationRepo {
  Future<Either<Failure, dynamic>> getAll({
    required UserPanelRequestModel body,
  });
}

abstract class GetAllPotHoleInformationByUIdRepo {
  Future<Either<Failure, dynamic>> getInformation({
    required GetPotHoleInformationByUIdRequestModel body,
  });
}

abstract class RegisterUserRepo {
  Future<Either<Failure, dynamic>> register({
    required RegisterUserRequestModel body,
  });
}

abstract class UploadImgUserRepo {
  Future<Either<Failure, dynamic>> uploadImg({
    required Uint8List? body,
  });
}
