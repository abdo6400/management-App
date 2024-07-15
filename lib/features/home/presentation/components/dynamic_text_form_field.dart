import 'package:another_flushbar/flushbar.dart';
import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:baraneq/core/components/default_components/default_button.dart';
import 'package:baraneq/features/home/presentation/bloc/cubits/tanks_cubit/tanks_cubit.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercharged/supercharged.dart';
import '../../../../core/components/default_components/default_form_field.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';
import '../../../../core/utils/custom_validation.dart';

class DynamicTextFormField extends StatelessWidget {
  final List<Map<String, dynamic>> tanks;
  final TextEditingController quantity;
  const DynamicTextFormField(
      {super.key, required this.tanks, required this.quantity});
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final tanksWatching = context.watch<TanksCubit>().quantityFields;
    final typeWatching = context.watch<TanksCubit>().type;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 3,
              child: Card(
                color: AppColors.white,
                elevation: 0.5,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<Map<String, dynamic>>(
                    isExpanded: true,
                    hint: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.propane_tank,
                          color: AppColors.blueLight,
                        ),
                        SizedBox(
                          width: AppValues.sizeWidth * 10,
                        ),
                        Expanded(
                          child: Text(
                            context.watch<TanksCubit>().selectedValue != null
                                ? context
                                        .read<TanksCubit>()
                                        .selectedValue!["tankId"]
                                        .toString() +
                                    "\t:\t " +
                                    context
                                        .read<TanksCubit>()
                                        .selectedValue!["tankName"]
                                        .toString() +
                                    "\t=\t " +
                                    context
                                        .read<TanksCubit>()
                                        .selectedValue!["tankCapacity"]
                                        .toString() +
                                    "\t/\t " +
                                    context
                                        .read<TanksCubit>()
                                        .selectedValue!["totalQuantity"]
                                        .toString()
                                : AppStrings.tank.tr(context),
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    onChanged: (value) {},
                    items: tanks
                        .filter((item) => typeWatching.compareTo(
                                    AppStrings.exporter.toUpperCase()) ==
                                0
                            ? 0 !=
                                double.parse(item["totalQuantity"].toString())
                            : double.parse(item["tankCapacity"].toString()) !=
                                double.parse(item["totalQuantity"].toString()))
                        .map((item) {
                      return DropdownMenuItem(
                        value: item,
                        enabled: true,
                        onTap: () =>
                            context.read<TanksCubit>().ChangeTank(item),
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                            item["tankId"].toString() +
                                "\t:\t " +
                                item["tankName"].toString() +
                                "\t=\t " +
                                item["tankCapacity"].toString() +
                                "\t/\t " +
                                item["totalQuantity"].toString(),
                            style: Theme.of(context).textTheme.bodyLarge,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }).toList(),
                    buttonStyleData: ButtonStyleData(
                        padding: EdgeInsets.symmetric(
                            vertical: AppValues.paddingHeight * 10,
                            horizontal: AppValues.paddingWidth * 10),
                        height: AppValues.sizeHeight * 50,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppValues.radius * 10),
                        )),
                    menuItemStyleData: MenuItemStyleData(
                      height: AppValues.sizeHeight * 50,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: AppValues.sizeWidth * 20,
            ),
            Flexible(
              flex: 2,
              child: Form(
                key: formKey,
                child: DefaultTextFormField(
                  controller: quantity,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  type: TextInputType.phone,
                  label: AppStrings.quantity,
                  prefix: Icons.propane_tank_outlined,
                  validate: (value) =>
                      CustomValidationHandler.isVaildCode(value)
                          .translateWithNullSafetyString(context),
                ),
              ),
            ),
            SizedBox(
              width: AppValues.sizeWidth * 20,
            ),
            Flexible(
              child: DefaultButton(
                onPressed: () {
                  if (context.read<TanksCubit>().selectedValue != null) {
                    if (formKey.currentState!.validate()) {
                      if ((context.read<TanksCubit>().type.compareTo(
                                      AppStrings.importer.toUpperCase()) ==
                                  0 &&
                              double.parse(context
                                      .read<TanksCubit>()
                                      .selectedValue!["tankCapacity"]
                                      .toString()) >=
                                  double.parse(quantity.text) +
                                      double.parse(context
                                          .read<TanksCubit>()
                                          .selectedValue!["totalQuantity"]
                                          .toString())) ||
                          (context.read<TanksCubit>().type.compareTo(
                                      AppStrings.exporter.toUpperCase()) ==
                                  0 &&
                              double.parse(quantity.text) <=
                                  double.parse(context
                                      .read<TanksCubit>()
                                      .selectedValue!["totalQuantity"]
                                      .toString()))) {
                        context.read<TanksCubit>().addQunatity(quantity.text);
                      } else {
                        Flushbar(
                          message: AppStrings.notEnoughQuantity.tr(context),
                          backgroundColor: AppColors.error,
                          margin: EdgeInsets.symmetric(
                              horizontal: AppValues.paddingWidth * 400),
                          duration: Durations.extralong4,
                          flushbarPosition: FlushbarPosition.TOP,
                          boxShadows: [
                            BoxShadow(
                              color: AppColors.error,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 3.0,
                            )
                          ],
                        )..show(context);
                      }
                    }
                  } else {
                    Flushbar(
                      message: AppStrings.chooseTank.tr(context),
                      backgroundColor: AppColors.error,
                      flushbarPosition: FlushbarPosition.TOP,
                      margin: EdgeInsets.symmetric(
                          horizontal: AppValues.paddingWidth * 400),
                      duration: Durations.extralong4,
                      boxShadows: [
                        BoxShadow(
                          color: AppColors.error,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 3.0,
                        )
                      ],
                    )..show(context);
                  }
                },
                text: AppStrings.add,
              ),
            )
          ],
        ),
        SizedBox(
          height: AppValues.sizeHeight * 20,
        ),
        SizedBox(
          width: AppValues.screenWidth,
          child: Wrap(
            spacing: AppValues.paddingWidth * 20,
            children: [
              for (int i = 0; i < tanksWatching.length; i++)
                Chip(
                  deleteIconColor: AppColors.error,
                  backgroundColor: AppColors.nearlyWhite,
                  onDeleted: () => context.read<TanksCubit>().removeQunatity(
                      tanksWatching.keys.elementAt(i).toString()),
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(tanksWatching.keys.elementAt(i).toString()),
                      Text(" : "),
                      Text(tanksWatching.values.elementAt(i).toString()),
                    ],
                  ),
                )
            ],
          ),
        )
      ],
    );
  }
}
