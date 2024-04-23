import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:baraneq/core/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';
import '../../../app/service_locator.dart';
import '../../../config/database/cache/cache_consumer.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_enums.dart';
import '../default_components/default_appbar.dart';

import '../../../../config/routes/app_routes.dart';
class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  final List<IntroItem> introItems = const [
    IntroItem(
      image: AppImages.onBoardingBackground1,
      title: AppStrings.onboarding1,
      subtitle: AppStrings.onboardingSub1,
    ),
    IntroItem(
      image: AppImages.onBoardingBackground2,
      title: AppStrings.onboarding2,
      subtitle: AppStrings.onboardingSub2,
    ),
    IntroItem(
      image: AppImages.onBoardingBackground3,
      title: AppStrings.onboarding3,
      subtitle: AppStrings.onboardingSub3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: DefaultAppBar(
            addLang: true,
            addLeadingButton: true,
            leading: Image.asset(
              AppImages.appLogo,
              height: AppValues.sizeHeight * 200,
              fit: BoxFit.cover,
            ),
          ),
          body: IntroductionScreen(
            bodyPadding: EdgeInsets.symmetric(
                vertical: AppValues.paddingHeight * 12,
                horizontal: AppValues.paddingWidth * 12),
            pages: introItems
                .map((e) => PageViewModel(
                      titleWidget: Text(
                        e.title!.tr(context),
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: AppColors.white),
                      ),
                      image: Image.asset(
                        e.image!,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fill,
                      ),
                      decoration:
                          const PageDecoration(imageFlex: 4, fullScreen: true),
                      bodyWidget: Text(
                        e.subtitle!.tr(context),
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: AppColors.white),
                      ),
                    ))
                .toList(),
            showSkipButton: false,
            next: Text(
              AppStrings.next.tr(context),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            done: Text(
              AppStrings.getStarted.tr(context),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            dotsDecorator: const DotsDecorator(activeColor: AppColors.primary),
            onDone: () {
              sl<CacheConsumer>().saveData(
                  key: MySharedKeys.onBoarding.name,
                  value: MySharedKeys.onBoarding.name);
              context.navigateAndFinish(screenRoute: Routes.loginRoute);
            },
            baseBtnStyle: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(AppColors.greySoft1)),
            nextStyle: TextButton.styleFrom(foregroundColor: AppColors.primary),
          )),
    );
  }
}

class IntroItem {
  final String? title;
  final String? subtitle;
  final String? image;

  const IntroItem({this.title, this.subtitle, this.image});
}

/**
 *  context.navigateAndFinish(
                                screenRoute: Routes.loginRoute);
 */
