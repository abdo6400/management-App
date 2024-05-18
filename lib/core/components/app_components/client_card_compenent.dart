import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:supercharged/supercharged.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../entities/client.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_values.dart';

class CLientCardComponent extends StatelessWidget {
  final Client client;
  final bool enableEditing;
  CLientCardComponent(
      {super.key,
      required this.client,
      required this.enableEditing,
      required BuildContext context}) {
    receiptDataSource =
        ReceiptDataSource(receipts: client.receipts, context: context);
    receiptDataSource
        .addColumnGroup(ColumnGroup(name: "day", sortGroupRows: true));
  }
  late ReceiptDataSource receiptDataSource;
  @override
  Widget build(context) {
    return SizedBox(
      child: SfDataGrid(
        columnWidthMode: ColumnWidthMode.fill,
        headerGridLinesVisibility: GridLinesVisibility.both,
        gridLinesVisibility: GridLinesVisibility.both,
        columnWidthCalculationRange: ColumnWidthCalculationRange.allRows,
        source: receiptDataSource,
        footer: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(AppStrings.totalQuantity.tr(context),
                style: Theme.of(context).textTheme.bodyMedium),
            Text(client.receipts.sumByDouble((d) => d.quantity).toString(),
                style: Theme.of(context).textTheme.bodyMedium)
          ],
        ),
        isScrollbarAlwaysShown: true,
        allowExpandCollapseGroup: !enableEditing,
        autoExpandGroups: enableEditing,
        columns: <GridColumn>[
          GridColumn(
              columnWidthMode: ColumnWidthMode.fill,
              columnName: 'day',
              label: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppValues.paddingWidth * 2,
                      vertical: AppValues.paddingHeight * 2),
                  alignment: Alignment.center,
                  child: Text(AppStrings.day.tr(context),
                      style: Theme.of(context).textTheme.bodyMedium))),
          GridColumn(
              columnWidthMode: ColumnWidthMode.fill,
              columnName: 'time',
              label: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppValues.paddingWidth * 2,
                      vertical: AppValues.paddingHeight * 2),
                  alignment: Alignment.center,
                  child: Text(AppStrings.time.tr(context),
                      style: Theme.of(context).textTheme.bodyMedium))),
          GridColumn(
              columnName: 'quantity',
              columnWidthMode: ColumnWidthMode.fill,
              label: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppValues.paddingWidth * 2,
                      vertical: AppValues.paddingHeight * 2),
                  alignment: Alignment.center,
                  child: Text(AppStrings.quantity.tr(context),
                      style: Theme.of(context).textTheme.bodyMedium))),
          GridColumn(
              columnName: 'bont',
              columnWidthMode: ColumnWidthMode.fill,
              label: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppValues.paddingWidth * 2,
                      vertical: AppValues.paddingHeight * 2),
                  alignment: Alignment.center,
                  child: Text(AppStrings.bont.tr(context),
                      style: Theme.of(context).textTheme.bodyMedium))),
          /*   GridColumn(
              columnName: 'tankNumber',
              columnWidthMode: ColumnWidthMode.fill,
              label: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppValues.paddingWidth * 2,
                      vertical: AppValues.paddingHeight * 2),
                  alignment: Alignment.center,
                  child: Text(AppStrings.tank.tr(context),
                      style: Theme.of(context).textTheme.bodyMedium))),*/
        ],
      ),
    );
  }
}

class ReceiptDataSource extends DataGridSource {
  final List<MilkReceipt> receipts;
  ReceiptDataSource({required this.receipts, required BuildContext context}) {
    _receipts = receipts
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'day',
                  value: DateFormat.yMd('ar').format(e.dateTime)),

              DataGridCell<String>(
                  columnName: 'time',
                  value: "${e.type.toLowerCase().tr(context)}"),
              DataGridCell<double>(columnName: 'quantity', value: e.quantity),
              DataGridCell<String>(columnName: 'bont', value: e.bont),
              //  DataGridCell<String>(columnName: 'tankNumber', value: e.tankNumber),
            ]))
        .toList();
  }

  List<DataGridRow> _receipts = [];

  @override
  List<DataGridRow> get rows => _receipts;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: AppValues.paddingWidth * 2,
        ),
        child: Text(
          dataGridCell.value.toString(),
          textAlign: TextAlign.center,
        ),
      );
    }).toList());
  }

  String getArabicWeekDayName(DateTime date) {
    const arabicWeekDays = {
      'Monday': 'الاثنين',
      'Tuesday': 'الثلاثاء',
      'Wednesday': 'الأربعاء',
      'Thursday': 'الخميس',
      'Friday': 'الجمعة',
      'Saturday': 'السبت',
      'Sunday': 'الأحد'
    };

    // Get the English name of the week day
    String weekDay = DateFormat('EEEE').format(date);

    // Return the corresponding Arabic name
    return arabicWeekDays[weekDay] ?? weekDay;
  }

  @override
  Widget? buildGroupCaptionCellWidget(
      RowColumnIndex rowColumnIndex, String summaryValue) {
    DateTime dateTime = receipts[rowColumnIndex.rowIndex - 1].dateTime;

    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppValues.paddingWidth * 5,
          vertical: AppValues.paddingHeight * 10,
        ),
        alignment: Alignment.centerRight,
        child: Row(
          children: [
            Text(getArabicWeekDayName(dateTime)),
            SizedBox(width: AppValues.sizeWidth * 10),
            Text(DateFormat.yMd('ar').format(dateTime))
          ],
        ));
  }
}
