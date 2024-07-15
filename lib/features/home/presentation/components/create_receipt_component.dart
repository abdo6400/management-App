import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:baraneq/core/components/default_components/default_appbar.dart';
import 'package:baraneq/features/home/domain/usecases/add_receipt_usecase.dart';
import 'package:baraneq/features/home/presentation/bloc/blocs/receipt_bloc/recepit_bloc.dart';
import 'package:baraneq/features/home/presentation/bloc/cubits/tanks_cubit/tanks_cubit.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';
import '../../../../core/components/default_components/default_button.dart';
import '../../../../core/components/default_components/default_form_field.dart';
import '../../../../core/components/default_components/default_message_card.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';
import '../../../../core/utils/custom_validation.dart';
import '../bloc/blocs/tanks_bloc/tanks_bloc.dart';
import 'dynamic_text_form_field.dart';
import 'name_search_component.dart';

class CreateReceiptComponent extends StatelessWidget {
  CreateReceiptComponent({super.key}) {}

  final TextEditingController name = TextEditingController();
  static final TextEditingController bont = TextEditingController();
  static final TextEditingController quantity = TextEditingController();
  static String type = AppStrings.importer.toUpperCase();
  static String time = AppStrings.am.toUpperCase();
  static final formKey = GlobalKey<FormState>();

  void clear() {
    bont.clear();
    type = AppStrings.importer.toUpperCase();
    time = AppStrings.am.toUpperCase();

    quantity.clear();
  }

  @override
  Widget build(BuildContext context) {
    final tankCubit = context.read<TanksCubit>();
    return SafeArea(
      child: SizedBox(
        width: AppValues.screenWidth,
        height: AppValues.screenHeight,
        child: AlertDialog(
          backgroundColor: AppColors.white,
          alignment: Alignment.center,
          insetPadding: EdgeInsets.symmetric(
              horizontal: AppValues.paddingWidth * 350,
              vertical: AppValues.paddingHeight * 20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppValues.radius * 10)),
          contentPadding: EdgeInsets.symmetric(
              vertical: AppValues.paddingHeight * 10,
              horizontal: AppValues.paddingWidth * 30),
          content: SizedBox(
            width: AppValues.screenWidth,
            child: Scaffold(
              backgroundColor: AppColors.white,
              appBar: DefaultAppBar(
                addLang: false,
                addLeadingButton: true,
                appBarText: AppStrings.addReceipt,
                leading: IconButton(
                    onPressed: () {
                      clear();
                      context.read<TanksCubit>().clear();
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      size: AppValues.font * 20,
                    )),
              ),
              body: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: AppValues.sizeHeight * 20,
                      ),
                      Divider(),
                      SizedBox(
                        height: AppValues.sizeHeight * 20,
                      ),
                      NameSearchComponent(
                        name: name,
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
                        height: AppValues.sizeHeight * 40,
                      ),
                      ListTile(
                        title: Text(
                          AppStrings.receiptType.tr(context),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        leading: const Icon(
                          Icons.receipt,
                          color: AppColors.blueLight,
                        ),
                        trailing: SizedBox(
                          width: AppValues.sizeWidth * 300,
                          child: CustomRadioButton(
                            elevation: 1,
                            absoluteZeroSpacing: false,
                            unSelectedColor: Theme.of(context).canvasColor,
                            horizontal: false,
                            enableShape: true,
                            defaultSelected: type,
                            customShape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    AppValues.radius * 10)),
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
                                textStyle:
                                    Theme.of(context).textTheme.titleMedium!),
                            radioButtonValue: (value) {
                              type = value;
                              context.read<TanksCubit>().changeType(type);
                            },
                            selectedColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppValues.sizeHeight * 20,
                      ),
                      ListTile(
                        title: Text(
                          AppStrings.time.tr(context),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        leading: const Icon(
                          Icons.timelapse,
                          color: AppColors.blueLight,
                        ),
                        trailing: SizedBox(
                          width: AppValues.sizeWidth * 300,
                          child: CustomRadioButton(
                            elevation: 1,
                            absoluteZeroSpacing: false,
                            unSelectedColor: Theme.of(context).canvasColor,
                            horizontal: false,
                            enableShape: true,
                            defaultSelected: time,
                            customShape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    AppValues.radius * 10)),
                            padding: 5,
                            spacing: 0.0,
                            buttonLables: [
                              AppStrings.am.tr(context),
                              AppStrings.pm.tr(context),
                            ],
                            buttonValues: [
                              AppStrings.am.toUpperCase(),
                              AppStrings.pm.toUpperCase(),
                            ],
                            buttonTextStyle: ButtonTextStyle(
                                selectedColor: AppColors.white,
                                unSelectedColor: AppColors.black,
                                textStyle:
                                    Theme.of(context).textTheme.titleMedium!),
                            radioButtonValue: (value) {
                              time = value;
                            },
                            selectedColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppValues.sizeHeight * 20,
                      ),
                      Divider(),
                      SizedBox(
                        height: AppValues.sizeHeight * 20,
                      ),
                      BlocBuilder<TanksInformationBloc, TanksInformationState>(
                        builder: (context, state) {
                          if (state is TanksLoadingState) {
                            return CircularProgressIndicator();
                          } else if (state is TanksErrorState) {
                            return Text(state.message);
                          } else if (state is TanksLoadedState) {
                            if (state.tanks.isEmpty) {
                              return DefaultMessageCard(
                                  sign: "!",
                                  title: AppStrings.noTanksFound,
                                  subTitle: AppStrings.youShouldAddTankFirst);
                            }

                            return DynamicTextFormField(
                                tanks: state.tanks, quantity: quantity);
                          }
                          return CircularProgressIndicator();
                        },
                      ),
                      SizedBox(
                        height: AppValues.sizeHeight * 50,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppValues.paddingWidth * 40),
                        child: Row(
                          children: [
                            Flexible(
                              child: DefaultButton(
                                onPressed: () async {
                                  if (tankCubit.quantityFields.isNotEmpty) {
                                    if (formKey.currentState!.validate() &&
                                        tankCubit.client != null) {
                                      context.read<RecepitBloc>().add(
                                          AddReceiptEvent(
                                              addReceiptParams:
                                                  AddReceiptParams(
                                                      quantities: tankCubit
                                                          .quantityFields,
                                                      type: type,
                                                      time: time,
                                                      bont: double.parse(
                                                          bont.text.toString()),
                                                      clientId: tankCubit
                                                          .client!.id)));
                                      clear();
                                      context.read<TanksCubit>().changeType(
                                          AppStrings.importer.toUpperCase());
                                      Navigator.pop(context, true);
                                    }
                                  } else {
                                    QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.error,
                                        width: AppValues.screenWidth / 4,
                                        autoCloseDuration: Durations.extralong4,
                                        showConfirmBtn: false,
                                        title: AppStrings.youShouldAddTankFirst
                                            .tr(context));
                                  }
                                },
                                text: AppStrings.import,
                                background: AppColors.blueLight,
                              ),
                            ),
                            SizedBox(
                              width: AppValues.sizeWidth * 50,
                            ),
                            Flexible(
                              child: DefaultButton(
                                onPressed: () {
                                  clear();
                                  context.read<TanksCubit>().changeType(
                                      AppStrings.importer.toUpperCase());
                                  context.read<TanksCubit>().clear();
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
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
