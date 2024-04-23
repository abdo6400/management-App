import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/locale/app_localizations.dart';
import '../../bloc/global_cubit/locale_cubit.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_values.dart';
import '/core/utils/app_colors.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? appBarText;
  final List<Widget>? widgets;
  final Widget? leading;
  final bool addLang;
  final bool addLeadingButton;
  final double elevation;
  final Color? backgroundColor;
  const DefaultAppBar({
    super.key,
    this.appBarText,
    this.widgets,
    this.leading,
    required this.addLang,
    required this.addLeadingButton,
    this.elevation = 0.0,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      leading: addLeadingButton
          ? Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppValues.paddingWidth * 10,
                vertical: AppValues.paddingHeight * 10,
              ),
              child: leading ??
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: CircleAvatar(
                      backgroundColor: AppColors.nearlyWhite,
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.black,
                        size: AppValues.font * 25,
                      ),
                    ),
                  ),
            )
          : null,
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: elevation,
      actions: addLang
          ? [
              GestureDetector(
                onTap: () => (AppLocalizations.of(context)!.isEnLocale
                    ? context.read<LocaleCubit>().toArabic()
                    : context.read<LocaleCubit>().toEnglish()),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppValues.paddingWidth * 15,
                    vertical: AppValues.paddingHeight * 15,
                  ),
                  child: CircleAvatar(
                    backgroundColor: AppColors.blueDarK,
                    child: Text(
                      (AppLocalizations.of(context)!.isEnLocale
                          ? AppStrings.arabicCode
                          : AppStrings.englishCode).toUpperCase(),
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w900,
                          color: AppColors.white),
                    ),
                  ),
                ),
              )
            ]
          : widgets,
      title: appBarText != null
          ? Text(
              appBarText!.translateWithNullSafetyString(context)!,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: AppValues.font * 24,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
