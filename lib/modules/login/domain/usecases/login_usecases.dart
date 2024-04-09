import 'package:either_dart/either.dart';
import 'package:pothole_detection/modules/login/domain/repositories/repositories.dart';
import 'package:pothole_detection/services/service_locator.dart';
import 'package:pothole_detection/utils/error/failure.dart';
import 'package:pothole_detection/utils/usecase/use_case.dart';

class LoginUseCase implements UseCaseOneInput {
  @override
  Future<Either<Failure, dynamic>> invoke(body) async {
    return await serviceLocator.get<LoginRepo>().login(body: body);
  }
}
