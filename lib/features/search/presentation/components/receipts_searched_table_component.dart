import 'package:baraneq/config/locale/app_localizations.dart';

import 'package:baraneq/core/utils/app_values.dart';
import 'package:baraneq/core/utils/common_services.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
// import 'package:open_filex/open_filex.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// import 'package:syncfusion_flutter_datagrid_export/export.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
//import 'package:syncfusion_flutter_xlsio/xlsio.dart' as docs;
import '../../../../core/components/app_components/options_card_component.dart';
import '../../../../core/components/default_components/default_message_card.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../domain/entities/weekly_client.dart';
import '../bloc/search_bloc.dart';

class ReceiptsSearchedTableComponent extends StatelessWidget {
  final TextEditingController price;
  ReceiptsSearchedTableComponent({super.key,required this.price});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (contImt, state) {
        if (state is SearchLoadingState) {
          return Center(
              child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: CircularProgressIndicator()));
        } else if (state is SearchErrorState) {
          return DefaultMessageCard(
              sign: "!",
              title: AppStrings.someThingWentWrong,
              subTitle: state.message);
        } else if (state is SearchLoadedState) {
          if (state.clients.isEmpty) {
            return DefaultMessageCard(
                sign: "!", title: AppStrings.noInvoicesFound, subTitle: "");
          }
          final data = ReceiptsDataSource(
              receipts: state.clients.first.receipts, context: context,price:price);
          return ReceiptsTable(
            myData: data,
            client: state.clients.first,
            price:double.parse(price.text)
          );
        }
        return DefaultMessageCard(
            sign: "!", title: AppStrings.searchAboutClient, subTitle: "");
      },
    );
  }
}

class ReceiptsTable extends StatelessWidget {
  final ReceiptsDataSource myData;
  final GlobalKey<SfDataGridState> dataKey = GlobalKey<SfDataGridState>();
  final WeeklyClient client;
  final double price;
  ReceiptsTable({required this.myData,required this.client, required this. price});
  GridColumn _buildGridColumns(BuildContext context,
      {required String columnName,
      bool allowSorting = false,
      bool allowFiltering = true,
      ColumnWidthMode columnWidthMode = ColumnWidthMode.fill}) {
    return GridColumn(
        columnName: columnName.tr(context),
        allowSorting: allowSorting,
        allowFiltering: allowFiltering,
        filterIconPosition: ColumnHeaderIconPosition.start,
        autoFitPadding: EdgeInsets.zero,
        columnWidthMode: columnWidthMode,
        filterIconPadding:
            EdgeInsets.symmetric(horizontal: AppValues.paddingWidth * 5),
        label: Container(
          color: AppColors.greenDarK,
          alignment: Alignment.center,
          child: Text(
            columnName.tr(context),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: AppColors.white),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppValues.screenWidth,
      child: Card(
        elevation: 0.4,
        color: AppColors.white,
        child: myData._receipts.isEmpty
            ? DefaultMessageCard(
                sign: "!", title: AppStrings.noInvoicesFound, subTitle: "")
            : Column(
                children: [
                  Expanded(
                    flex: 10,
                    child: SfDataGridTheme(
                      data: SfDataGridThemeData(
                        filterIconColor: AppColors.white,
                        headerColor: AppColors.greenDarK,
                        filterIconHoverColor: AppColors.green,
                        sortIconColor: AppColors.white,
                        gridLineColor: AppColors.grey.withOpacity(0.1),
                      ),
                      child: SfDataGrid(
                        key: dataKey,
                        footer: OptionsCardComponent(
                          exportPdf: () async => CommonServices.generatePdf(client: client,ctx: context,price:price),
                          exportExecl: () async {},
                          printPdf: () {},
                        ),
                        gridLinesVisibility: GridLinesVisibility.both,
                        headerGridLinesVisibility: GridLinesVisibility.both,
                        allowFiltering: true,
                        allowEditing: true,
                        allowSorting: true,
                        source: myData,
                        columnWidthMode: ColumnWidthMode.fill,
                        showVerticalScrollbar: true,
                        isScrollbarAlwaysShown: true,
                        columnResizeMode: ColumnResizeMode.onResize,
                        selectionMode: SelectionMode.multiple,
                        columnSizer: ColumnSizer(),
                        columnWidthCalculationRange:
                            ColumnWidthCalculationRange.allRows,
                        tableSummaryRows: [
                          GridTableSummaryRow(
                              showSummaryInRow: true,
                              title:
                                  '''${AppStrings.receiptsCount.tr(context)} :\t\t\t\t {ReceiptCount}      |    ${AppStrings.am.tr(context)}:\t\t\t\t  {AmSum}   |      ${AppStrings.pm.tr(context)} :\t\t\t\t {PmSum}   |    ${AppStrings.totalQuantity.tr(context)} :\t\t\t\t {Sum}   |    ${AppStrings.price.tr(context)} :\t\t\t\t {PSum}''',
                              color: AppColors.white,
                              columns: [
                                GridSummaryColumn(
                                    name: 'PSum',
                                    columnName: AppStrings.price.tr(context),
                                    summaryType: GridSummaryType.sum),
                                GridSummaryColumn(
                                    name: 'Sum',
                                    columnName:
                                        AppStrings.totalQuantity.tr(context),
                                    summaryType: GridSummaryType.sum),
                                GridSummaryColumn(
                                    name: 'AmSum',
                                    columnName: AppStrings.am.tr(context),
                                    summaryType: GridSummaryType.sum),
                                GridSummaryColumn(
                                    name: 'PmSum',
                                    columnName: AppStrings.pm.tr(context),
                                    summaryType: GridSummaryType.sum),
                                GridSummaryColumn(
                                    name: 'ReceiptCount',
                                    columnName: AppStrings.id.tr(context),
                                    summaryType: GridSummaryType.count)
                              ],
                              position: GridTableSummaryRowPosition.bottom),
                        ],
                        columns: [
                          _buildGridColumns(context,
                              columnName: AppStrings.day,
                              allowSorting: false,
                              allowFiltering: false),
                          _buildGridColumns(context,
                              columnName: AppStrings.date, allowSorting: false),
                          _buildGridColumns(context,
                              columnName: AppStrings.am, allowSorting: false),
                          _buildGridColumns(context,
                              columnName: AppStrings.bont, allowSorting: false),
                          _buildGridColumns(context,
                              columnName: AppStrings.pm, allowSorting: false),
                          _buildGridColumns(context,
                              columnName: AppStrings.bont, allowSorting: false),
                          _buildGridColumns(context,
                              columnName: AppStrings.totalQuantity,
                              allowSorting: true),
                          _buildGridColumns(context,
                              columnName: AppStrings.price, allowSorting: true),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: SfDataPager(
                        delegate: myData,
                        pageCount: myData._receipts.length / 15,
                        direction: Axis.horizontal,
                      ))
                ],
              ),
      ),
    );
  }
}

class ReceiptsDataSource extends DataGridSource {
  ReceiptsDataSource(
      {required List<Receipt> receipts, required BuildContext context,required TextEditingController price}) {
    _receipts = receipts
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: AppStrings.day.tr(context),
                  value: getArabicWeekDayName(e.receiptDate)),
              DataGridCell<String>(
                  columnName: AppStrings.date.tr(context),
                  value: DateFormat.yMd('ar').format(e.receiptDate)),
              DataGridCell<double>(
                  columnName: AppStrings.am.tr(context),
                  value: e.totalQuantityForAm),
              DataGridCell<double>(
                  columnName: AppStrings.bont.tr(context),
                  value: e.biggestBontForAm),
              DataGridCell<double>(
                  columnName: AppStrings.pm.tr(context),
                  value: e.totalQuantityForPm),
              DataGridCell<double>(
                  columnName: AppStrings.bont.tr(context),
                  value: e.biggestBontForPm),
              DataGridCell<double>(
                  columnName: AppStrings.totalQuantity.tr(context),
                  value: e.totalQuantityForDay),
              DataGridCell<double>(
                  columnName: AppStrings.price.tr(context),
                  value: e.totalQuantityForDay * double.parse(price.text.toString())),
            ]))
        .toList();
  }

  List<DataGridRow> _receipts = <DataGridRow>[];

  @override
  List<DataGridRow> get rows => _receipts;
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
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          dataGridCell.value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      );
    }).toList());
  }

  @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppValues.paddingWidth * 20,
          vertical: AppValues.paddingHeight * 10),
      child: Text(summaryValue),
    );
  }
}
