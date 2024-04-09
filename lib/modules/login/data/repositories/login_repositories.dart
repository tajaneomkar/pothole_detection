import 'package:either_dart/either.dart';
import 'package:pothole_detection/config/env_config.dart';
import 'package:pothole_detection/modules/login/data/model/login_request_model.dart';
import 'package:pothole_detection/modules/login/domain/repositories/repositories.dart';
import 'package:pothole_detection/utils/error/failure.dart';
import 'package:pothole_detection/utils/network/api_provider.dart';

class LoginRepoImpl implements LoginRepo {
  final _apiProvider = ApiProvider();

  @override
  Future<Either<Failure, dynamic>> login(
      {required LoginRequestModel body}) async {
    dynamic response;

    try {
      response = await _apiProvider.getData(
          baseUrl: EnvConfig.POTHOLEBASEURL,
          subUrl: "/api/user/userLogin",
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
