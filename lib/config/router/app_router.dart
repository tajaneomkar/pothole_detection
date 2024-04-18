import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: UserPanelRoute.page),
        AutoRoute(page: AdminPanelRoute.page),
        AutoRoute(page: UserPanelDetailView.page),
        AutoRoute(page: UserPanelRegisterComplaint.page),
        AutoRoute(page: AdminPanelDetailView.page),
      ];
}
