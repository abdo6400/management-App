import 'package:avatar_glow/avatar_glow.dart';
import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_values.dart';

class CustomInternetConnectionChecker extends StatefulWidget {
  final Widget? child;
  const CustomInternetConnectionChecker({super.key, this.child});
  @override
  State<CustomInternetConnectionChecker> createState() =>
      _CustomInternetConnectionCheckerState();
}

class _CustomInternetConnectionCheckerState
    extends State<CustomInternetConnectionChecker> {
  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        if (connectivity == ConnectivityResult.none) {
          return const _NoInternet();
        } else {
          return child;
        }
      },
      builder: (BuildContext context) {
        return widget.child!;
      },
    );
  }
}

class _NoInternet extends StatelessWidget {
  const _NoInternet();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight,
      width: ScreenUtil().screenHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: AppValues.radius * 60,
            backgroundColor: AppColors.white,
            child: AvatarGlow(
              animate: true,
              glowColor: AppColors.grey,
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 2000),
              repeat: true,
              child: Icon(
                Icons.wifi_off_outlined,
                size: AppValues.font * 40,
                color: AppColors.primary,
              ),
            ),
          ),
          Text(
            AppStrings.noInternetConnection.tr(context),
            style: Theme.of(context).textTheme.titleLarge,
          )
        ],
      ),
    );
  }
}
