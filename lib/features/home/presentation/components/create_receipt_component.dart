import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/default_components/default_form_field.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';
import '../../../../core/utils/custom_validation.dart';

class CreateReceiptComponent extends StatelessWidget {
  const CreateReceiptComponent({super.key});
  static final TextEditingController name = TextEditingController(),
      quantity = TextEditingController(),
      bont = TextEditingController(),
      tank = TextEditingController();
  static String type = AppStrings.importer.toUpperCase();
  static final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
              margin:
                  EdgeInsets.symmetric(horizontal: AppValues.marginWidth * 10),
              child: ListTile(
                title: Text(
                  AppStrings.time.tr(context),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                leading: const Icon(Icons.timelapse),
              )),
          Divider(),
          SizedBox(
            height: AppValues.sizeHeight * 20,
          ),
          CustomRadioButton(
            elevation: 1,
            absoluteZeroSpacing: false,
            unSelectedColor: Theme.of(context).canvasColor,
            horizontal: false,
            enableShape: true,
            defaultSelected: type,
            customShape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(AppValues.radius * 10)),
            padding: 5,
            spacing: 0.0,
            buttonLables: [
              AppStrings.pm.tr(context),
              AppStrings.am.tr(context),
            ],
            buttonValues: [
              AppStrings.pm.toUpperCase(),
              AppStrings.am.toUpperCase(),
            ],
            buttonTextStyle: ButtonTextStyle(
                selectedColor: AppColors.white,
                unSelectedColor: AppColors.black,
                textStyle: Theme.of(context).textTheme.titleMedium!),
            radioButtonValue: (value) {
              type = value;
            },
            selectedColor: Theme.of(context).primaryColor,
          ),
          SizedBox(
            height: AppValues.sizeHeight * 20,
          ),
          DefaultTextFormField(
            controller: name,
            type: TextInputType.name,
            label: AppStrings.name,
            prefix: Icons.person,
            validate: (value) => CustomValidationHandler.isValidName(value)
                .translateWithNullSafetyString(context),
          ),
          SizedBox(
            height: AppValues.sizeHeight * 20,
          ),
          DefaultTextFormField(
            controller: quantity,
            type: TextInputType.phone,
            label: AppStrings.quantity,
            prefix: Icons.add_to_queue_outlined,
            validate: (value) =>
                CustomValidationHandler.isValidPhoneNumber(value)
                    .translateWithNullSafetyString(context),
          ),
          SizedBox(
            height: AppValues.sizeHeight * 20,
          ),
          DefaultTextFormField(
            controller: quantity,
            type: TextInputType.phone,
            label: AppStrings.bont,
            prefix: Icons.bolt,
            validate: (value) => CustomValidationHandler.isVaildCode(value)
                .translateWithNullSafetyString(context),
          ),
          SizedBox(
            height: AppValues.sizeHeight * 20,
          ),
          DefaultTextFormField(
            controller: bont,
            type: TextInputType.phone,
            label: AppStrings.bont,
            prefix: Icons.bolt,
            validate: (value) => CustomValidationHandler.isVaildCode(value)
                .translateWithNullSafetyString(context),
          ),
          SizedBox(
            height: AppValues.sizeHeight * 20,
          ),
          DefaultTextFormField(
            controller: tank,
            type: TextInputType.phone,
            label: AppStrings.tank,
            prefix: Icons.propane_tank,
            validate: (value) => CustomValidationHandler.isVaildCode(value)
                .translateWithNullSafetyString(context),
          ),
          SizedBox(
            height: AppValues.sizeHeight * 20,
          ),
        ],
      ),
    );
  }
}
