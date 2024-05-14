import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:baraneq/core/utils/app_colors.dart';
import 'package:baraneq/core/utils/app_strings.dart';
import 'package:baraneq/core/utils/custom_validation.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/components/default_components/default_button.dart';
import '../../../../core/components/default_components/default_form_field.dart';
import '../../../../core/models/client.dart';
import '../../../../core/utils/app_values.dart';
import '../bloc/client_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AddClientScreen extends StatelessWidget {
  const AddClientScreen({super.key});
  void _handleStates(BuildContext context, ClientState state) {
    if (state is ClientLoadingState) {
      context.loaderOverlay.show();
    } else if (state is ClientErrorState) {
      context.loaderOverlay.hide();
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          autoCloseDuration: Durations.extralong4,
          showConfirmBtn: false,
          title: AppStrings.someThingWentWrong.tr(context));
    } else if (state is ClientLoadedState) {
      context.loaderOverlay.hide();
      phoneNumber.clear();
      name.clear();
      QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          showConfirmBtn: false,
          title: AppStrings.newClientAdded.tr(context),
          autoCloseDuration: Durations.extralong4);
    }
  }

  static final TextEditingController name = TextEditingController(),
      phoneNumber = TextEditingController();
  static String type = AppStrings.importer.toUpperCase();
  static final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<ClientBloc, ClientState>(
      listener: _handleStates,
      child: SizedBox(
        height: AppValues.screenHeight,
        width: AppValues.screenWidth,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppValues.paddingWidth * 10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: AppValues.sizeHeight * 50,
                ),
                Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: AppValues.marginWidth * 10),
                    child: ListTile(
                      title: Text(
                        AppStrings.clientType.tr(context),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      leading: const Icon(Icons.import_export),
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
                      borderRadius:
                          BorderRadius.circular(AppValues.radius * 10)),
                  padding: 5,
                  spacing: 0.0,
                  buttonLables: [
                    AppStrings.importer.tr(context),
                    AppStrings.exporter.tr(context),
                  ],
                  buttonValues: [
                    AppStrings.importer.toUpperCase(),
                    AppStrings.exporter.toUpperCase(),
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
                  validate: (value) =>
                      CustomValidationHandler.isValidName(value)
                          .translateWithNullSafetyString(context),
                ),
                SizedBox(
                  height: AppValues.sizeHeight * 20,
                ),
                DefaultTextFormField(
                  controller: phoneNumber,
                  type: TextInputType.phone,
                  label: AppStrings.phoneNumber,
                  prefix: Icons.phone,
                  validate: (value) =>
                      CustomValidationHandler.isValidPhoneNumber(value)
                          .translateWithNullSafetyString(context),
                ),
                SizedBox(
                  height: AppValues.sizeHeight * 20,
                ),
                DefaultButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<ClientBloc>().add(AddClientEvent(
                          client: Client(
                              id: Uuid().v1(),
                              phone: phoneNumber.text,
                              name: name.text,
                              clientType: type)));
                    }
                  },
                  text: AppStrings.add,
                  width: AppValues.screenWidth / 2,
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
