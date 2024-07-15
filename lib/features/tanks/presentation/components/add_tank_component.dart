import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:baraneq/features/tanks/domain/usecases/add_tank_usecase.dart';
import 'package:baraneq/features/tanks/presentation/bloc/tank_crud_bloc/tank_crud_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/default_components/default_appbar.dart';
import '../../../../core/components/default_components/default_button.dart';
import '../../../../core/components/default_components/default_form_field.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';
import '../../../../core/utils/custom_validation.dart';

class AddTankComponent extends StatelessWidget {
  const AddTankComponent({super.key});
  static final TextEditingController capacity = TextEditingController();
  static final TextEditingController name = TextEditingController();
  static final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AlertDialog(
        alignment: Alignment.center,
        backgroundColor: AppColors.white,
        insetPadding: EdgeInsets.symmetric(
            vertical: AppValues.paddingHeight * 100,
            horizontal: AppValues.paddingWidth * 450),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppValues.radius * 10)),
        contentPadding: EdgeInsets.symmetric(
            vertical: AppValues.paddingHeight * 10,
            horizontal: AppValues.paddingWidth * 10),
        content: SizedBox(
          width: AppValues.screenWidth,
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: DefaultAppBar(
              addLang: false,
              addLeadingButton: true,
              appBarText: AppStrings.addNewTank,
              leading: IconButton(
                  onPressed: () {
                    capacity.clear();
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    size: AppValues.font * 20,
                  )),
            ),
            body: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                  vertical: AppValues.paddingHeight * 20,
                  horizontal: AppValues.paddingWidth * 20),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.propane_tank_outlined,
                      size: AppValues.font * 70,
                      color: AppColors.secondery,
                    ),
                    SizedBox(
                      height: AppValues.sizeHeight * 50,
                    ),
                    DefaultTextFormField(
                      controller: name,
                      type: TextInputType.text,
                      label: AppStrings.name,
                      prefix: Icons.person,
                      validate: (value) =>
                          CustomValidationHandler.isValidName(value)
                              .translateWithNullSafetyString(context),
                    ),
                    SizedBox(
                      height: AppValues.sizeHeight * 50,
                    ),
                    DefaultTextFormField(
                      controller: capacity,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      type: TextInputType.number,
                      label: AppStrings.capacity,
                      prefix: Icons.propane_tank_outlined,
                      validate: (value) =>
                          CustomValidationHandler.isVaildCode(value)
                              .translateWithNullSafetyString(context),
                    ),
                    SizedBox(
                      height: AppValues.sizeHeight * 50,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: DefaultButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<TankCrudBloc>().add(
                                    AddNewTankEvent(
                                        tank: AddTankParams(
                                            capacity:
                                                double.parse(capacity.text),
                                            name: name.text)));
                                capacity.clear();
                                Navigator.of(context).pop();
                              }
                            },
                            text: AppStrings.add,
                            width: AppValues.screenWidth / 5,
                          ),
                        ),
                        SizedBox(
                          width: AppValues.sizeWidth * 50,
                        ),
                        Flexible(
                          child: DefaultButton(
                            onPressed: () {
                              capacity.clear();
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
      ),
    );
  }
}
