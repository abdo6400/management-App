import 'package:accordion/accordion.dart';
import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            height: AppValues.screenHeight,
            width: AppValues.screenWidth,
            child: Column(children: [
              Expanded(
                flex: 8,
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
              ),
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
                                      Text(AppStrings.exporter.tr(context),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                      Text(
                                          state.clients
                                              .filter((f) =>
                                                  f.clientType.compareTo(
                                                      AppStrings.exporter
                                                          .toUpperCase()) ==
                                                  0)
                                              .map((e) => e.receipts
                                                  .sumByDouble(
                                                      (d) => d.quantity))
                                              .toList()
                                              .sumByDouble((d) => d)
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium)
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(AppStrings.importer.tr(context),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                      Text(
                                          state.clients
                                              .filter((f) =>
                                                  f.clientType.compareTo(
                                                      AppStrings.importer
                                                          .toUpperCase()) ==
                                                  0)
                                              .map((e) => e.receipts
                                                  .sumByDouble(
                                                      (d) => d.quantity))
                                              .toList()
                                              .sumByDouble((d) => d)
                                              .toString(),
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
                                      Text(
                                          state.clients
                                              .map((e) => e.receipts
                                                  .sumByDouble(
                                                      (d) => d.quantity))
                                              .toList()
                                              .sumByDouble((d) => d)
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Accordion(
                                openAndCloseAnimation: true,
                                headerBackgroundColor:
                                    Theme.of(context).primaryColor,
                                maxOpenSections: 1,
                                initialOpeningSequenceDelay: 1,
                                children: state.clients
                                    .map(
                                      (e) => AccordionSection(
                                        header: Text(e.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                    color: AppColors.white,
                                                    fontSize:
                                                        AppValues.font * 18)),
                                        content: CLientCardComponent(
                                          client: e,
                                          enableEditing: false,
                                          context: context,
                                        ),
                                        leftIcon: CircleAvatar(
                                          backgroundColor:
                                              AppColors.nearlyWhite,
                                          child: Text(
                                            e.clientType
                                                .toLowerCase()
                                                .tr(context)
                                                .substring(2),
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        AppValues.font * 10),
                                          ),
                                        ),
                                        headerPadding: EdgeInsets.symmetric(
                                            horizontal:
                                                AppValues.paddingWidth * 10,
                                            vertical:
                                                AppValues.paddingHeight * 10),
                                      ),
                                    )
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
