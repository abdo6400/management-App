import 'package:accordion/accordion.dart';
import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:baraneq/core/utils/app_colors.dart';
import 'package:baraneq/core/utils/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/default_components/default_message_card.dart';
import '../../../../core/entities/client.dart';
import '../../../../core/utils/app_strings.dart';
import '../bloc/importers_bloc/importers_bloc.dart';

class ImportersScreen extends StatelessWidget {
  const ImportersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImportersBloc, ImportersState>(
      builder: (contImt, state) {
        if (state is ImportersClientsLoadingState) {
          return CircularProgressIndicator();
        } else if (state is ImportersClientsErrorState) {
          return DefaultMessageCard(
              sign: "!",
              title: AppStrings.someThingWentWrong,
              subTitle: state.message);
        } else if (state is ImportersClientsLoadedState) {
          return Accordion(
            openAndCloseAnimation: true,
            headerBackgroundColor: Theme.of(context).primaryColor,
            maxOpenSections: 1,
            initialOpeningSequenceDelay: 1,
            children: state.clients
                .map(
                  (e) => AccordionSection(
                    header: Text(e.name,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: AppColors.white,
                            fontSize: AppValues.font * 18)),
                    content: MyDataTable(client: e),
                    leftIcon: CircleAvatar(
                      child: Text(e.name.characters.first),
                    ),
                    headerPadding: EdgeInsets.symmetric(
                        horizontal: AppValues.paddingWidth * 10,
                        vertical: AppValues.paddingHeight * 10),
                  ),
                )
                .toList(),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class MyDataTable extends StatelessWidget {
  final Client client;
  const MyDataTable({super.key, required this.client});
  static const contentStyleHeader = TextStyle(
      color: Color(0xff999999), fontSize: 10, fontWeight: FontWeight.w700);
  static const contentStyle = TextStyle(
      color: Color(0xff999999), fontSize: 10, fontWeight: FontWeight.normal);
  @override
  Widget build(context) {
    return DataTable(
      sortAscending: true,
      sortColumnIndex: 1,
      showBottomBorder: false,
      columns: [
        DataColumn(
            label:
                Text(AppStrings.time.tr(context), style: contentStyleHeader)),
        DataColumn(
            label: Text(AppStrings.quantity.tr(context),
                style: contentStyleHeader),
            numeric: true),
      ],
      rows: client.receipts
          .map(
            (e) => DataRow(
              cells: [
                DataCell(Text(
                    e.dateTime.toUtc().toString() +
                        e.type.toLowerCase().tr(context),
                    style: contentStyle)),
                DataCell(Text(e.quantity.toString(),
                    style: contentStyle, textAlign: TextAlign.right))
              ],
            ),
          )
          .toList(),
    );
  }
}
