import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../core/components/basic_screens/main_screen.dart';
import '../../core/utils/app_strings.dart';

class Routes {
  //basic routes
  static const String initialRoute = '/';
  static const String mapRoute = '/mapRoute';
  static const String onBoardingRoute = "/onBoardingRoute";
  static const String loginRoute = "/loginRoute";
  static const String registerRoute = "/registerRoute";
  static const String informationRoute = "/informationRoute";
  static const String otpRegisterRoute = "/otpRegisterRoute";
  static const String otpForgetPasswordRoute = "/otpForgetPasswordRoute";
  static const String forgetPasswordRoute = "/forgetPasswordRoute";
  static const String resetPasswordRoute = "/resetPasswordRoute";
  static const String mainRoute = "/mainRoute";

  static const String changePasswordRoute = "/changePasswordRoute";
  static const String editProfileRoute = "/editProfileRoute";

  static const String estateRoute = "/estateRoute";
  static const String topLocationsRoute = "/topLocationsRoute";
  static const String topAgentsRoute = "/topAgentsRoute";
  static const String topAgentDetailsRoute = "/topAgentDetailsRoute";
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return PageTransition(
            child: const MainScreen(),
            type: PageTransitionType.fade,
            settings: routeSettings);


      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
              body: Center(
                child: Text(AppStrings.noRouteFound),
              ),
            )));
  }
}
