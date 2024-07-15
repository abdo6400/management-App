import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/default_components/default_appbar.dart';
import '../../../../core/components/default_components/default_button.dart';
import '../../../../core/components/default_components/default_form_field.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';
import '../../../../core/utils/custom_validation.dart';
import '../../domain/usecases/add_client_usecase.dart';
import '../bloc/client_crud_bloc/client_crud_bloc.dart';

class AddClientComponent extends StatelessWidget {
  const AddClientComponent({super.key});
  static final TextEditingController name = TextEditingController(),
      phoneNumber = TextEditingController();
  static final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AlertDialog(
        alignment: Alignment.center,
        backgroundColor: AppColors.white,
        insetPadding: EdgeInsets.symmetric(
            vertical: AppValues.paddingHeight * 100,
            horizontal: AppValues.paddingWidth * 400),
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
              appBarText: AppStrings.addNewClient,
              leading: IconButton(
                  onPressed: () {
                    phoneNumber.clear();
                    name.clear();
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
                  vertical: AppValues.paddingHeight * 10,
                  horizontal: AppValues.paddingWidth * 20),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.appLogo,
                      height: AppValues.sizeHeight * 120,
                      width: AppValues.sizeWidth * 120,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      height: AppValues.sizeHeight * 30,
                    ),
                    DefaultTextFormField(
                      controller: name,
                      type: TextInputType.name,
                      label: AppStrings.name,
                      prefix: Icons.person,
                      validate: (value) =>
                          CustomValidationHandler.isValidName(value)
                              .translateWithNullSafetyString(context),
                    ),
                    SizedBox(
                      height: AppValues.sizeHeight * 30,
                    ),
                    DefaultTextFormField(
                      controller: phoneNumber,
                      type: TextInputType.phone,
                      label: AppStrings.phoneNumber,
                      prefix: Icons.phone,
                    ),
                    SizedBox(
                      height: AppValues.sizeHeight * 30,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: DefaultButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<ClientCrudBloc>().add(
                                    AddNewClientEvent(
                                        client: AddClientParams(
                                            phone: phoneNumber.text,
                                            name: name.text)));
                                phoneNumber.clear();
                                name.clear();
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
                              phoneNumber.clear();
                              name.clear();
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
