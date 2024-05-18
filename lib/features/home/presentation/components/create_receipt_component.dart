import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:baraneq/features/home/domain/usecases/add_receipt_usecase.dart';
import 'package:baraneq/features/home/presentation/bloc/receipt_bloc/recepit_bloc.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/default_components/default_button.dart';
import '../../../../core/components/default_components/default_form_field.dart';
import '../../../../core/entities/client.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';
import '../../../../core/utils/custom_validation.dart';

class CreateReceiptComponent extends StatelessWidget {
  CreateReceiptComponent(
      {super.key, required this.isExporter, required this.client}) {
    name = TextEditingController(text: client.name);
  }
  final bool isExporter;
  final Client client;
  late final TextEditingController name;
  static final TextEditingController quantity = TextEditingController(),
      bont = TextEditingController(),
      tank = TextEditingController();
  static String type = AppStrings.pm.toUpperCase();
  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      width: AppValues.screenWidth,
      height: AppValues.screenHeight,
      child: SingleChildScrollView(
        child: AlertDialog(
          alignment: Alignment.center,
          insetPadding: EdgeInsets.symmetric(
              horizontal: AppValues.paddingWidth * 25,
              vertical: AppValues.paddingHeight * 20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppValues.radius * 10)),
          contentPadding: EdgeInsets.symmetric(
              vertical: AppValues.paddingHeight * 20,
              horizontal: AppValues.paddingWidth * 10),
          content: SizedBox(
            width: AppValues.screenWidth,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppStrings.addReceipt.tr(context),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: AppValues.sizeHeight * 20,
                  ),
                  Divider(),
                  CustomRadioButton(
                    elevation: 0.5,
                    absoluteZeroSpacing: false,
                    unSelectedColor: Theme.of(context).canvasColor,
                    horizontal: false,
                    enableShape: true,
                    defaultSelected: type,
                    customShape: BeveledRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppValues.radius * 10)),
                    padding: 5,
                    spacing: 2,
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
                    readOnly: true,
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
                        CustomValidationHandler.isVaildCode(value)
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
                    validate: (value) =>
                        CustomValidationHandler.isVaildCode(value)
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
                    validate: (value) =>
                        CustomValidationHandler.isVaildCode(value)
                            .translateWithNullSafetyString(context),
                  ),
                  SizedBox(
                    height: AppValues.sizeHeight * 20,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: DefaultButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<RecepitBloc>().add(AddReceiptEvent(
                                  addReceiptParams: AddReceiptParams(
                                      quantityValue: double.parse(
                                          quantity.text.toString()),
                                      type: type,
                                      bont: double.parse(bont.text.toString()),
                                      tankNumber: tank.text,
                                      clientId: client.id)));
                              // dispose();
                              Navigator.pop(context, true);
                            }
                          },
                          text: isExporter
                              ? AppStrings.export
                              : AppStrings.import,
                          background: AppColors.green,
                        ),
                      ),
                      SizedBox(
                        width: AppValues.sizeWidth * 10,
                      ),
                      Flexible(
                        child: DefaultButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          borderColor: AppColors.error,
                          background: Colors.transparent,
                          textColor: AppColors.black,
                          elevation: 0,
                          text: AppStrings.cancel,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
