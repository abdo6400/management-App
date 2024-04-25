import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';

class BalanceComponents extends StatelessWidget {
  const BalanceComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppValues.screenWidth,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: AppValues.marginWidth * 10,
            vertical: AppValues.marginHeight * 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppValues.radius * 10),
          color: AppColors.primary,
        ),
        padding: EdgeInsets.symmetric(vertical: AppValues.paddingHeight * 5),
        child: ListTile(
            leading: Image.asset(AppImages.appLogo),
            title: Text(
              AppStrings.balance.tr(context),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: AppColors.white),
            ),
            trailing: RichText(
              text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: AppColors.white),
                  children: [
                    const TextSpan(text: "15000"),
                    const TextSpan(text: " "),
                    TextSpan(text: AppStrings.kilo.tr(context)),
                  ]),
            )),
      ),
    );
  }
}
