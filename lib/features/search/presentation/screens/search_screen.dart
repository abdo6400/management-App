import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:baraneq/core/components/default_components/default_button.dart';
import 'package:baraneq/core/components/default_components/default_form_field.dart';
import 'package:baraneq/core/utils/app_strings.dart';
import 'package:baraneq/core/utils/custom_validation.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchfield/searchfield.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_values.dart';
import '../../../../core/entities/search_client.dart';
import '../bloc/client_search_bloc/client_search_bloc.dart';
import '../bloc/search_bloc.dart';
import '../components/receipts_searched_table_component.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  static DateTime? fromDate;
  static DateTime? toDate;
  static final TextEditingController name = TextEditingController();
  static final TextEditingController price = TextEditingController();
  static SearchClient? client;
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static String type = AppStrings.importer.toUpperCase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: AppValues.screenHeight,
      width: AppValues.screenWidth,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: AppValues.sizeHeight * 20,
            ),
            Expanded(
              flex: 5,
              child: Card(
                elevation: 0.1,
                margin:
                    EdgeInsets.symmetric(horizontal: AppValues.marginWidth * 5),
                color: AppColors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppValues.paddingWidth * 30,
                      vertical: AppValues.paddingHeight * 10),
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: BlocBuilder<ClientSearchBloc,
                                  ClientSearchState>(
                                builder: (context, state) {
                                  return SearchField<SearchClient>(
                                    controller: name,
                                    suggestionDirection:
                                        SuggestionDirection.flex,
                                    onSearchTextChanged: (p0) {
                                      context.read<ClientSearchBloc>().add(
                                              SearchClientEvent(filters: {
                                            "name": p0,
                                            "limit": 10
                                          }));
                                      return;
                                    },
                                    validator: (p0) {
                                      if (state is ClientSearchLoadedState) {
                                        try {
                                          client = state.clients.firstWhere(
                                              (element) => element.name == p0);
                                          return null;
                                        } catch (e) {
                                          return AppStrings.youChooseClientFirst
                                              .tr(context);
                                        }
                                      }
                                      return AppStrings.youChooseClientFirst
                                          .tr(context);
                                    },
                                    enabled: true,
                                    suggestions: (state
                                                is ClientSearchLoadedState
                                            ? state.clients
                                            : [])
                                        .map((e) => SearchFieldListItem<
                                                SearchClient>(e.name,
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        AppValues.paddingWidth *
                                                            10),
                                                child: Text(
                                                  e.name,
                                                ),
                                              ),
                                            )))
                                        .toList(),
                                    searchInputDecoration: InputDecoration(
                                      labelText: AppStrings.name.tr(context),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: AppColors.blueLight,
                                      ),
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              color: AppColors.hintColor
                                                  .withOpacity(0.7)),
                                      prefixIconColor: AppColors.black,
                                      enabledBorder: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            AppValues.radius * 5),
                                        borderSide: BorderSide(
                                            color: AppColors.lightGrey),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical:
                                              AppValues.paddingHeight * 6),
                                      errorBorder: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            AppValues.radius * 5),
                                        borderSide:
                                            BorderSide(color: AppColors.error),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            AppValues.radius * 5),
                                        borderSide: BorderSide(
                                            color: AppColors.primary),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            AppValues.radius * 5),
                                        borderSide: BorderSide(
                                            color: AppColors.lightGrey),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: AppValues.sizeWidth * 30,
                            ),
                            Flexible(
                              child: DefaultTextFormField(
                                label: AppStrings.enterKiloPrice,
                                controller: price,
                                type: TextInputType.phone,
                                prefix: Icons.money,
                                validate: (p0) =>
                                    CustomValidationHandler.isVaildCode(p0)
                                        .translateWithNullSafetyString(context),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Flexible(
                                child: ListTile(
                                  title: Text(
                                    AppStrings.receiptType.tr(context),
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
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
                                      unSelectedColor:
                                          Theme.of(context).canvasColor,
                                      
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
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .titleMedium!),
                                      radioButtonValue: (value) {
                                        type = value;
                                      },
                                      selectedColor:
                                          AppColors.blueLight,
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: DateTimeFormField(
                                        decoration: InputDecoration(
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                    color: AppColors.hintColor
                                                        .withOpacity(0.7)),
                                            prefixIconColor: AppColors.black,
                                            enabledBorder: UnderlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppValues.radius * 5),
                                              borderSide: BorderSide(
                                                  color: AppColors.lightGrey),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: AppValues
                                                            .paddingHeight *
                                                        6,
                                                    horizontal:
                                                        AppValues.paddingWidth *
                                                            30),
                                            errorBorder: UnderlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppValues.radius * 5),
                                              borderSide: BorderSide(
                                                  color: AppColors.error),
                                            ),
                                            disabledBorder: InputBorder.none,
                                            focusedBorder: UnderlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppValues.radius * 5),
                                              borderSide: BorderSide(
                                                  color: AppColors.primary),
                                            ),
                                            border: UnderlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppValues.radius * 5),
                                              borderSide: BorderSide(
                                                  color: AppColors.lightGrey),
                                            ),
                                            labelText:
                                                AppStrings.fromDate.tr(context),
                                            suffixIconColor:
                                                AppColors.blueLight),
                                        validator: (DateTime? value) {
                                          if (value == null) {
                                            return AppStrings.fromDate
                                                .tr(context);
                                          }
                                          return null;
                                        },
                                        mode: DateTimeFieldPickerMode.date,
                                        initialPickerDateTime: DateTime.now(),
                                        onChanged: (DateTime? value) {
                                          fromDate = value;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: AppValues.sizeWidth * 30,
                                    ),
                                    Flexible(
                                      child: DateTimeFormField(
                                        decoration: InputDecoration(
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                    color: AppColors.hintColor
                                                        .withOpacity(0.7)),
                                            prefixIconColor: AppColors.black,
                                            enabledBorder: UnderlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppValues.radius * 5),
                                              borderSide: BorderSide(
                                                  color: AppColors.lightGrey),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: AppValues
                                                            .paddingHeight *
                                                        6,
                                                    horizontal: AppValues
                                                            .paddingWidth *
                                                        30),
                                            errorBorder: UnderlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppValues.radius * 5),
                                              borderSide: BorderSide(
                                                  color: AppColors.error),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppValues.radius * 5),
                                              borderSide: BorderSide(
                                                  color: AppColors.primary),
                                            ),
                                            border: UnderlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppValues.radius * 5),
                                              borderSide: BorderSide(
                                                  color: AppColors.lightGrey),
                                            ),
                                            labelText:
                                                AppStrings.toDate.tr(context),
                                            suffixIconColor:
                                                AppColors.blueLight),
                                        validator: (DateTime? value) {
                                          if (value == null) {
                                            return AppStrings.toDate
                                                .tr(context);
                                          }
                                          return null;
                                        },
                                        mode: DateTimeFieldPickerMode.date,
                                        initialPickerDateTime: DateTime.now(),
                                        onChanged: (DateTime? value) {
                                          toDate = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppValues.paddingWidth * 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child: DefaultButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      if (name.text.isEmpty ||
                                          toDate == null ||
                                          fromDate == null) {
                                        context
                                            .read<SearchBloc>()
                                            .add(SearchCleanEvent());
                                      } else {
                                        context
                                            .read<SearchBloc>()
                                            .add(SearchAboutClientEvent(value: {
                                              "id": client!.id,
                                              "fromDate": fromDate,
                                              "toDate": toDate,
                                              "page": 1,
                                              "pageSize": 7,
                                              "type": type
                                            }));
                                      }
                                    }
                                  },
                                  text: AppStrings.search,
                                ),
                              ),
                              SizedBox(
                                width: AppValues.sizeWidth * 20,
                              ),
                              Flexible(
                                child: DefaultButton(
                                  background: AppColors.error,
                                  onPressed: () {
                                    name.clear();
                                    price.clear();
                                    client = null;
                                    context
                                        .read<SearchBloc>()
                                        .add(SearchCleanEvent());
                                  },
                                  text: AppStrings.cancel,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: AppValues.sizeHeight * 10,
            ),
            Expanded(
                flex: 8,
                child: ReceiptsSearchedTableComponent(
                  price: price,
                )),
            SizedBox(
              height: AppValues.sizeHeight * 10,
            ),
          ],
        ),
      ),
    ));
  }
}
