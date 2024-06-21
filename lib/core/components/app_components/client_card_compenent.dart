import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:baraneq/features/home/domain/usecases/edit_receipt_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:supercharged/supercharged.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../features/home/domain/usecases/add_receipt_usecase.dart';
import '../../../features/home/presentation/bloc/receipt_bloc/recepit_bloc.dart';
import '../../entities/client.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_values.dart';
import '../default_components/default_button.dart';

class ClientCardComponent extends StatelessWidget {
  final Client client;
  final bool enableEditing;
  ClientCardComponent({
    super.key,
    required this.client,
    required this.enableEditing,
  });

  @override
  Widget build(context) {
    return Dismissible(
      key: ValueKey(client.id),
      onDismissed: (direction) {},
      confirmDismiss: (direction) async {
        context
                      .read<RecepitBloc>()
                      .add(DeleteReceiptEvent(id: client.id));
        /* QuickAlert.show(
            context: context,
            type: QuickAlertType.confirm,
            onConfirmBtnTap: () {
              Navigator.pop(context, true);
              /*  context
                      .read<RecepitBloc>()
                      .add(DeleteReceiptEvent(id: client.id));*/
            },
            confirmBtnText: AppStrings.ok.tr(context),
            cancelBtnText: AppStrings.cancel.tr(context));*/

        return Future.value(false);
      },
      direction:
          client.clientType.compareTo(AppStrings.importer.toUpperCase()) == 0
              ? DismissDirection.startToEnd
              : DismissDirection.endToStart,
      background: Container(
        color: AppColors.greySoft1,
        padding: EdgeInsets.symmetric(horizontal: AppValues.paddingWidth * 20),
        margin: EdgeInsets.symmetric(
            horizontal: AppValues.marginWidth * 10,
            vertical: AppValues.marginHeight * 10),
        alignment:
            client.clientType.compareTo(AppStrings.importer.toUpperCase()) == 0
                ? Alignment.centerRight
                : Alignment.centerLeft,
        child: Icon(
          Icons.delete,
          color: AppColors.error,
          size: AppValues.font * 25,
        ),
      ),
      child: Card(
        elevation: 0.5,
        color: AppColors.nearlyWhite,
        margin: EdgeInsets.symmetric(
            vertical: AppValues.marginHeight * 10,
            horizontal: AppValues.marginWidth * 10),
        child: ListTile(
          onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) {
              return _infoDialog(
                client: client,
                context: context,
                enableEditing: enableEditing,
              );
            },
          ),
          title: Text(client.name,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: AppValues.font * 18)),
          leading: CircleAvatar(
            backgroundColor: AppColors.primary,
            child: Text(client.clientType.toLowerCase().tr(context),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: AppValues.font * 10, color: AppColors.white)),
          ),
          trailing: Text(
              client.phoneNumber.isNotEmpty ? client.phoneNumber : "*********",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: AppValues.font * 18)),
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppValues.paddingWidth * 15,
          ),
        ),
      ),
    );
  }
}

class _infoDialog extends StatelessWidget {
  final Client client;
  final bool enableEditing;
  late final ReceiptDataSource receiptDataSource;
  _infoDialog({
    required this.client,
    required BuildContext context,
    required this.enableEditing,
  }) {
    receiptDataSource =
        ReceiptDataSource(receipts: client.receipts, context: context);
    receiptDataSource
        .addColumnGroup(ColumnGroup(name: "day", sortGroupRows: true));
  }
  @override
  Widget build(context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(
          horizontal: AppValues.paddingWidth * 25,
          vertical: AppValues.paddingHeight * 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppValues.radius * 15)),
      contentPadding: EdgeInsets.symmetric(
        vertical: AppValues.paddingHeight * 20,
        horizontal: AppValues.paddingWidth * 10,
      ),
      scrollable: false,
      titlePadding: EdgeInsets.symmetric(
        vertical: AppValues.paddingHeight * 20,
        horizontal: AppValues.paddingWidth * 20,
      ),
      titleTextStyle: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(fontSize: AppValues.font * 22),
      icon: Container(
        width: AppValues.screenWidth,
        padding: EdgeInsets.symmetric(
          vertical: AppValues.paddingHeight * 20,
          horizontal: AppValues.paddingWidth * 10,
        ),
        decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppValues.radius * 40),
                bottomRight: Radius.circular(AppValues.radius * 40),
                topLeft: Radius.circular(AppValues.radius * 15),
                topRight: Radius.circular(AppValues.radius * 15))),
        child: Icon(
          Icons.info,
          size: AppValues.font * 50,
          color: AppColors.white,
        ),
      ),
      iconPadding: EdgeInsets.zero,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            client.name,
          ),
          Text(
            client.phoneNumber.isNotEmpty ? client.phoneNumber : "****",
          ),
        ],
      ),
      actions: [
        DefaultButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          borderColor: AppColors.error,
          background: Colors.transparent,
          textColor: AppColors.black,
          elevation: 0,
          text: AppStrings.cancel,
        ),
      ],
      content: SizedBox(
        height: AppValues.screenHeight / 3,
        width: AppValues.screenWidth,
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
              Text(
                  client.receipts
                      .sumByDouble((d) =>
                          d.tanks.values.sumByDouble((s) => double.parse(s)))
                      .toString(),
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
          ],
        ),
      ),
    );
  }
}

class ReceiptDataSource extends DataGridSource {
  final List<MilkReceipt> receipts;
  final BuildContext context;
  ReceiptDataSource({required this.receipts, required, required this.context}) {
    _receipts = receipts
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'day',
                  value: DateFormat.yMd('ar').format(e.dateTime)),

              DataGridCell<String>(
                  columnName: 'time',
                  value: "${e.type.toLowerCase().tr(context)}"),
              DataGridCell<double>(
                  columnName: 'quantity',
                  value: e.tanks.values.sumByDouble((s) => double.parse(s))),
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
