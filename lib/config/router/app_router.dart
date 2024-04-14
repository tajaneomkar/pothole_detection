import 'package:auto_route/auto_route.dart';
import 'package:pothole_detection/modules/login/presentation/login_page.dart';
import 'package:pothole_detection/modules/splash_screen/splash_screen.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page)
      ];
}
