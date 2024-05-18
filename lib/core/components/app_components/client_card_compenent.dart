import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../entities/client.dart';
import '../../utils/app_strings.dart';

class CLientCardComponent extends StatelessWidget {
  final Client client;
  final bool enableEditing;
  const CLientCardComponent(
      {super.key, required this.client, required this.enableEditing});
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
