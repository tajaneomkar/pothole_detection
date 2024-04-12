import 'package:either_dart/either.dart';
import 'package:pothole_detection/modules/admin_panel/data/model/admin_panel_request_model.dart';
import 'package:pothole_detection/modules/admin_panel/data/model/admin_update_status_request_model.dart';
import 'package:pothole_detection/modules/admin_panel/data/model/get_pot_hole_by_admin_uid_request_model.dart';
import 'package:pothole_detection/modules/admin_panel/data/model/verify_pothole_img_request.dart';
import 'package:pothole_detection/modules/admin_panel/domain/repositories/repositories.dart';
import 'package:pothole_detection/services/service_locator.dart';
import 'package:pothole_detection/utils/error/failure.dart';
import 'package:pothole_detection/utils/usecase/use_case.dart';

class AdminPanelUseCase
    implements UseCaseOneInput<AdminPanelRequestModel, dynamic> {
  @override
  Future<Either<Failure, dynamic>> invoke(body) async {
    return await serviceLocator
        .get<GetAllPotHoleInformationAdminRepo>()
        .getAllAdminInfo(body: body);
  }
}

class GetPotHoleByAdminUIdUseCase
    implements
        UseCaseOneInput<GetPotHoleInformationByAdminUIdRequestModel, dynamic> {
  @override
  Future<Either<Failure, dynamic>> invoke(body) async {
    return await serviceLocator
        .get<GetAllPotHoleInformationByAdminUIdRepo>()
        .getAdminInformation(body: body);
  }
}

class AdminUpdateStatusUseCase
    implements UseCaseOneInput<AdminUpdateStatusRequestModel, dynamic> {
  @override
  Future<Either<Failure, dynamic>> invoke(body) async {
    return await serviceLocator
        .get<AdminUpdateStatusRepo>()
        .adminUpdateStatus(body: body);
  }
}

class VerifyImageUseCase
    implements UseCaseOneInput<VerifyPotholeImgRequestModel, dynamic> {
  @override
  Future<Either<Failure, dynamic>> invoke(body) async {
    return await serviceLocator.get<VerifyImageRepo>().verifyImage(body: body);
  }
}
