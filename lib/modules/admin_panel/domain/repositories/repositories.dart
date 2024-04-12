import 'package:either_dart/either.dart';
import 'package:pothole_detection/modules/admin_panel/data/model/admin_panel_request_model.dart';
import 'package:pothole_detection/modules/admin_panel/data/model/admin_update_status_request_model.dart';
import 'package:pothole_detection/modules/admin_panel/data/model/get_pot_hole_by_admin_uid_request_model.dart';
import 'package:pothole_detection/modules/admin_panel/data/model/verify_pothole_img_request.dart';
import 'package:pothole_detection/utils/error/failure.dart';

abstract class GetAllPotHoleInformationAdminRepo {
  Future<Either<Failure, dynamic>> getAllAdminInfo({
    required AdminPanelRequestModel body,
  });
}

abstract class GetAllPotHoleInformationByAdminUIdRepo {
  Future<Either<Failure, dynamic>> getAdminInformation({
    required GetPotHoleInformationByAdminUIdRequestModel body,
  });
}

abstract class AdminUpdateStatusRepo {
  Future<Either<Failure, dynamic>> adminUpdateStatus({
    required AdminUpdateStatusRequestModel body,
  });
}

abstract class VerifyImageRepo {
  Future<Either<Failure, dynamic>> verifyImage({
    required VerifyPotholeImgRequestModel body,
  });
}
