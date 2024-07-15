import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:baraneq/config/routes/app_routes.dart';
import 'package:baraneq/core/utils/app_values.dart';
import 'package:baraneq/core/utils/commons.dart';
import 'package:baraneq/core/utils/custom_validation.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import '../../../../core/components/default_components/default_button.dart';
import '../../../../core/components/default_components/default_form_field.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_strings.dart';

class InputCard extends StatelessWidget {
  InputCard({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppValues.screenHeight / 2,
      width: AppValues.screenWidth / 4,
      child: Card(
        elevation: 0,
        color: AppColors.white.withOpacity(0.2),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppValues.radius * 40)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppValues.paddingWidth * 36,
              vertical: AppValues.paddingHeight * 12),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.white,
                  radius: AppValues.radius * 45,
                  child: CircleAvatar(
                    radius: AppValues.radius * 40,
                    backgroundImage: AssetImage(
                      AppImages.appLogo,
                    ),
                  ),
                ),
                DefaultTextFormField(
                    prefix: Icons.person,
                    controller: emailController,
                    textColor: AppColors.white,
                    type: TextInputType.emailAddress,
                    validate: (p0) => CustomValidationHandler.isValidName(p0)
                        .translateWithNullSafetyString(context),
                    hint: AppStrings.name),
                DefaultTextFormField(
                    prefix: Icons.lock_outline,
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    textColor: AppColors.white,
                    validate: (p0) => CustomValidationHandler.isVaildCode(p0)
                        .translateWithNullSafetyString(context),
                    suffixPressed: () {},
                    hint: AppStrings.password),
                DefaultButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (passwordController.text == "1" &&
                          emailController.text == "1") {
                        context.navigateAndFinish(
                            screenRoute: Routes.mainRoute);
                      } else {
                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.error,
                            autoCloseDuration: Durations.extralong4,
                            showConfirmBtn: false,
                            width: AppValues.screenWidth / 5,
                            title: AppStrings.someThingWentWrong.tr(context));
                      }
                    }
                  },
                  text: AppStrings.login,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
