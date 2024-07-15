import 'package:baraneq/config/locale/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercharged/supercharged.dart';
import '../../../../core/components/app_components/client_card_compenent.dart';
import '../../../../core/components/default_components/default_message_card.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';
import '../bloc/invoices_bloc.dart';

class InvoicesScreen extends StatelessWidget {
  const InvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            height: AppValues.screenHeight,
            width: AppValues.screenWidth,
            child: Column(children: [
           /*   Expanded(
                flex: 10,
                child: Card(
                  elevation: 0.5,
                  color: AppColors.white,
                  margin: EdgeInsets.symmetric(
                      horizontal: AppValues.marginWidth * 15,
                      vertical: AppValues.marginHeight * 20),
                  child: CalendarDatePicker2(
                    config: CalendarDatePicker2Config(
                        calendarType: CalendarDatePicker2Type.range,
                        selectedDayHighlightColor: AppColors.secondery),
                    value: [
                      DateTime(DateTime.now().year, DateTime.now().month,
                          DateTime.now().day)
                    ],
                    onValueChanged: (dates) {
                      context.read<InvoicesBloc>().add(AccountStatementEvent(
                              value: {
                                "fromDate": dates.first,
                                "toDate": dates.last
                              }));
                    },
                  ),
                ),
              ),*/
              Expanded(
                  flex: 10,
                  child: BlocBuilder<InvoicesBloc, InvoicesState>(
                    builder: (contImt, state) {
                      if (state is AccountStatementLoadingState) {
                        return CircularProgressIndicator();
                      } else if (state is AccountStatementErrorState) {
                        return DefaultMessageCard(
                            sign: "!",
                            title: AppStrings.someThingWentWrong,
                            subTitle: state.message);
                      } else if (state is AccountStatementLoadedState) {
                        if (state.clients.isEmpty) {
                          return DefaultMessageCard(
                              sign: "!",
                              title: AppStrings.noInvoicesFound,
                              subTitle: "");
                        }

                        final double exValue = state.clients
                            .map((e) => e.receipts
                                .filter((f) =>
                                    f.type.compareTo(
                                        AppStrings.exporter.toUpperCase()) ==
                                    0)
                                .sumByDouble((d) => d.totalQuantity))
                            .toList()
                            .sumByDouble((d) => d);
                        final double impValue = state.clients
                            .map((e) => e.receipts
                                .filter((f) =>
                                    f.type.compareTo(
                                        AppStrings.importer.toUpperCase()) ==
                                    0)
                                .sumByDouble((d) => d.totalQuantity))
                            .toList()
                            .sumByDouble((d) => d);
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: AppValues.marginWidth * 15,
                                  vertical: AppValues.marginHeight * 2),
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppValues.paddingWidth * 15,
                                  vertical: AppValues.paddingHeight * 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(AppStrings.importer.tr(context),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                      Text(impValue.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium)
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(AppStrings.exporter.tr(context),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                      Text(exValue.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium)
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(AppStrings.totalQuantity.tr(context),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                      Text("${impValue - exValue}".toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView(
                                children: state.clients
                                    .map((e) => ClientCardComponent(
                                          client: e,
                                          enableEditing: false,
                                        ))
                                    .toList(),
                              ),
                            ),
                          ],
                        );
                      }
                      return DefaultMessageCard(
                          sign: "!",
                          title: AppStrings.noInvoicesFound,
                          subTitle: AppStrings.noInvoicesFound);
                    },
                  ))
            ])));
  }
}
