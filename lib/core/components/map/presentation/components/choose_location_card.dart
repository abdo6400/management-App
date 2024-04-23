import 'package:avatar_glow/avatar_glow.dart';
import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_values.dart';

class ChooseLocationCard extends StatelessWidget {
  final Function function;
  final double? height;
  const ChooseLocationCard({
    super.key,
    required this.function,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? AppValues.screenHeight,
      width: AppValues.screenWidth,
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
                Icons.location_pin,
                size: AppValues.font * 40,
                color: AppColors.error,
              ),
            ),
          ),
          Text(
            AppStrings.deliverTo.tr(context),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(
            height: AppValues.sizeHeight * 5,
          ),
          Text(
            AppStrings.selectAreaForbetterPerformance.tr(context),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
