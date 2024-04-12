import 'package:get_it/get_it.dart';
import 'package:pothole_detection/modules/admin_panel/data/repositories/admin_panel_repositories.dart';
import 'package:pothole_detection/modules/admin_panel/domain/repositories/repositories.dart';
import 'package:pothole_detection/modules/admin_panel/domain/usecases/admin_panel_usecases.dart';
import 'package:pothole_detection/modules/admin_panel/presentation/bloc/admin_detail_view_bloc/admin_detail_view_bloc.dart';
import 'package:pothole_detection/modules/admin_panel/presentation/bloc/admin_panel_bloc/admin_panel_bloc.dart';
import 'package:pothole_detection/modules/login/data/repositories/login_repositories.dart';
import 'package:pothole_detection/modules/login/domain/repositories/repositories.dart';
import 'package:pothole_detection/modules/login/domain/usecases/login_usecases.dart';
import 'package:pothole_detection/modules/login/presentation/bloc/login_bloc.dart';
import 'package:pothole_detection/modules/user_panel/data/repositories/user_panel_repositories.dart';
import 'package:pothole_detection/modules/user_panel/domain/repositories/repositories.dart';
import 'package:pothole_detection/modules/user_panel/domain/usecases/user_panel_usecases.dart';
import 'package:pothole_detection/modules/user_panel/presentation/user_panel_details_bloc/user_panel_details_bloc.dart';
import 'package:pothole_detection/modules/user_panel/presentation/user_panel_page_bloc/user_panel_bloc.dart';
import 'package:pothole_detection/modules/user_panel/presentation/user_panel_register_bloc/user_panel_register_bloc.dart';
import 'package:pothole_detection/services/shared_preference_service.dart';

final serviceLocator = GetIt.instance;

void initializeDependencies() async {
  serviceLocator
      .registerSingleton<SharedPreferencesService>(SharedPreferencesService());

  // Login Page
  serviceLocator.registerFactory<LoginBloc>(() => LoginBloc());
  serviceLocator.registerLazySingleton<LoginUseCase>(() => LoginUseCase());
  serviceLocator.registerLazySingleton<LoginRepo>(() => LoginRepoImpl());
// UserPanel
  serviceLocator.registerFactory<UserPanelBloc>(() => UserPanelBloc());
  serviceLocator
      .registerLazySingleton<UserPanelUseCase>(() => UserPanelUseCase());
  serviceLocator.registerLazySingleton<GetAllPotHoleInformationRepo>(
      () => GetAllPotHoleInformationImpl());
// AdminPanel
  serviceLocator.registerFactory<AdminPanelBloc>(() => AdminPanelBloc());
  serviceLocator
      .registerLazySingleton<AdminPanelUseCase>(() => AdminPanelUseCase());
  serviceLocator.registerLazySingleton<GetAllPotHoleInformationAdminRepo>(
      () => GetAllPotHoleInformationAdminImpl());
// UserPanelDetail
  serviceLocator
      .registerFactory<UserPanelDetailsBloc>(() => UserPanelDetailsBloc());
  serviceLocator.registerLazySingleton<GetPotHoleByUIdUseCase>(
      () => GetPotHoleByUIdUseCase());
  serviceLocator.registerLazySingleton<GetAllPotHoleInformationByUIdRepo>(
      () => GetAllPotHoleInformationByUIdRepoImpl());
// AdminPanelDetail
  serviceLocator
      .registerFactory<AdminDetailViewBloc>(() => AdminDetailViewBloc());
  serviceLocator.registerLazySingleton<GetPotHoleByAdminUIdUseCase>(
      () => GetPotHoleByAdminUIdUseCase());
  serviceLocator.registerLazySingleton<GetAllPotHoleInformationByAdminUIdRepo>(
      () => GetAllPotHoleInformationByAdminUIdRepoImpl());
// UserComplaintRegister
  serviceLocator
      .registerFactory<UserPanelRegisterBloc>(() => UserPanelRegisterBloc());
  serviceLocator
      .registerLazySingleton<RegisterUserUseCase>(() => RegisterUserUseCase());
  serviceLocator
      .registerLazySingleton<RegisterUserRepo>(() => RegisterUserRepoImpl());
// Admin Status Update

  serviceLocator.registerLazySingleton<AdminUpdateStatusUseCase>(
      () => AdminUpdateStatusUseCase());
  serviceLocator.registerLazySingleton<AdminUpdateStatusRepo>(
      () => AdminUpdateStatusRepoImpl());

  // Verify Image
  serviceLocator
      .registerLazySingleton<VerifyImageUseCase>(() => VerifyImageUseCase());
  serviceLocator
      .registerLazySingleton<VerifyImageRepo>(() => VerifyImageRepoImpl());

  serviceLocator.registerLazySingleton<UploadImageUserUseCase>(
      () => UploadImageUserUseCase());
  serviceLocator.registerLazySingleton<UploadImgUserRepo>(
      () => UploadImageUserRepoImpl());
}
