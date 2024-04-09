import 'package:either_dart/either.dart';
import 'package:pothole_detection/modules/login/data/model/login_request_model.dart';
import 'package:pothole_detection/utils/error/failure.dart';

abstract class LoginRepo {
  Future<Either<Failure, dynamic>> login({required LoginRequestModel body});
}
