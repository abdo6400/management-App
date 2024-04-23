import 'package:avatar_glow/avatar_glow.dart';

import 'package:flutter/material.dart';

import '../../../config/locale/app_localizations.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_values.dart';
import 'default_button.dart';

class DefaultErrorCard extends StatelessWidget {
  final String erroMessage;
  final String title;
  final Function function;
  final double? height;
  const DefaultErrorCard(
      {super.key,
      required this.erroMessage,
      required this.function,
      this.height,
      required this.title});

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
                Icons.error_outline,
                size: AppValues.font * 40,
                color: AppColors.error,
              ),
            ),
          ),
          Text(
            AppLocalizations.of(context)!.translate(title) ?? title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(
            height: AppValues.sizeHeight * 5,
          ),
          const Divider(
            thickness: 2,
          ),
          SizedBox(
            height: AppValues.sizeHeight * 20,
          ),
          Text(
            AppLocalizations.of(context)!.translate(erroMessage) ?? erroMessage,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: AppValues.sizeHeight * 20,
          ),
          DefaultButton(
            elevation: 0,
            width: AppValues.screenWidth * 0.4,
            onPressed: () => function(),
            text: AppStrings.tryAgain,
          )
        ],
      ),
    );
  }
}
