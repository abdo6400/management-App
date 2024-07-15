import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:baraneq/core/entities/client.dart';
import 'package:baraneq/core/utils/app_values.dart';
import 'package:baraneq/features/home/presentation/bloc/blocs/receipt_bloc/recepit_bloc.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';
// import 'package:open_filex/open_filex.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:supercharged/supercharged.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// import 'package:syncfusion_flutter_datagrid_export/export.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
//import 'package:syncfusion_flutter_xlsio/xlsio.dart' as docs;
import '../../../../core/components/app_components/options_card_component.dart';
import '../../../../core/components/default_components/default_message_card.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../bloc/blocs/clients_bloc/clients_bloc.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class ReceiptsTableComponent extends StatelessWidget {
  ReceiptsTableComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientsBloc, ClientsState>(
      builder: (contImt, state) {
        if (state is ClientsLoadingState) {
          return Center(
              child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: CircularProgressIndicator()));
        } else if (state is ClientsErrorState) {
          return DefaultMessageCard(
              sign: "!",
              title: AppStrings.someThingWentWrong,
              subTitle: state.message);
        } else if (state is ClientsLoadedState) {
          if (state.clients.isEmpty) {
            return DefaultMessageCard(
                sign: "!", title: AppStrings.noInvoicesFound, subTitle: "");
          }
          final data =
              ReceiptsDataSource(clients: state.clients, context: context);
          return ReceiptsTable(
            myData: data,
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class ReceiptsTable extends StatelessWidget {
  final ReceiptsDataSource myData;
  final GlobalKey<SfDataGridState> dataKey = GlobalKey<SfDataGridState>();
  ReceiptsTable({required this.myData});
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
        child: Column(
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
                    exportPdf: () async {},
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
                  selectionMode: SelectionMode.none,
                  columnSizer: ColumnSizer(),
                  footerFrozenRowsCount: 1,
                  columnWidthCalculationRange:
                      ColumnWidthCalculationRange.allRows,
                  tableSummaryRows: [
                    GridTableSummaryRow(
                        showSummaryInRow: true,
                        title:
                            '''${AppStrings.clientsNumber.tr(context)} :\t\t\t\t {ClientCount}      |    ${AppStrings.am.tr(context)}:\t\t\t\t  {AmSum}   |      ${AppStrings.pm.tr(context)} :\t\t\t\t {PmSum}   |    ${AppStrings.totalQuantityForAllClients.tr(context)} :\t\t\t\t {Sum} ''',
                        color: AppColors.white,
                        columns: [
                          GridSummaryColumn(
                              name: 'Sum',
                              columnName: AppStrings.totalQuantity.tr(context),
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
                              name: 'ClientCount',
                              columnName: AppStrings.id.tr(context),
                              summaryType: GridSummaryType.count)
                        ],
                        position: GridTableSummaryRowPosition.bottom),
                  ],
                  columns: [
                    _buildGridColumns(context,
                        columnName: AppStrings.id,
                        allowSorting: false,
                        allowFiltering: false),
                    _buildGridColumns(context,
                        columnName: AppStrings.name, allowSorting: false),
                    _buildGridColumns(context,
                        columnName: AppStrings.phoneNumber,
                        allowSorting: false),
                    _buildGridColumns(context,
                        columnName: AppStrings.am, allowSorting: true),
                    _buildGridColumns(context,
                        columnName: AppStrings.bont, allowSorting: false),
                    _buildGridColumns(context,
                        columnName: AppStrings.pm, allowSorting: true),
                    _buildGridColumns(context,
                        columnName: AppStrings.bont, allowSorting: false),
                    _buildGridColumns(context,
                        columnName: AppStrings.totalQuantity,
                        allowSorting: true),
                    _buildGridColumns(context,
                        columnName: AppStrings.settings,
                        allowSorting: false,
                        allowFiltering: false),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: SfDataPager(
                  delegate: myData,
                  pageCount: myData._clients.length / 15,
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
      {required List<Client> clients, required BuildContext context}) {
    _clients = clients
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: AppStrings.id.tr(context), value: e.id),
              DataGridCell<String>(
                  columnName: AppStrings.name.tr(context), value: e.name),
              DataGridCell<String>(
                  columnName: AppStrings.phoneNumber.tr(context),
                  value: e.phoneNumber),
              DataGridCell<double>(
                  columnName: AppStrings.am.tr(context),
                  value: e.receipts
                      .toList()
                      .filter((f) => f.time == AppStrings.am.toUpperCase())
                      .sumByDouble((s) => s.totalQuantity)),
              DataGridCell<double>(
                  columnName: AppStrings.bont.tr(context),
                  value: e.receipts
                          .toList()
                          .filter((f) => f.time == AppStrings.am.toUpperCase())
                          .isNotEmpty
                      ? e.receipts
                          .toList()
                          .filter((f) => f.time == AppStrings.am.toUpperCase())
                          .first
                          .bont
                      : 0.0),
              DataGridCell<double>(
                  columnName: AppStrings.pm.tr(context),
                  value: e.receipts
                      .toList()
                      .filter((f) => f.time == AppStrings.pm.toUpperCase())
                      .sumByDouble((s) => s.totalQuantity)),
              DataGridCell<double>(
                  columnName: AppStrings.bont.tr(context),
                  value: e.receipts
                          .toList()
                          .filter((f) => f.time == AppStrings.pm.toUpperCase())
                          .isNotEmpty
                      ? e.receipts
                          .toList()
                          .filter((f) => f.time == AppStrings.pm.toUpperCase())
                          .first
                          .bont
                      : 0.0),
              DataGridCell<double>(
                  columnName: AppStrings.totalQuantity.tr(context),
                  value:
                      e.receipts.toList().sumByDouble((s) => s.totalQuantity)),
              DataGridCell<Widget>(
                  columnName: AppStrings.totalQuantity.tr(context),
                  value: GestureDetector(
                      onTap: () {
                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.confirm,
                            title: AppStrings.doYOuWantToDeleteReceiptForSure
                                .tr(context),
                            confirmBtnText: AppStrings.confirme.tr(context),
                            cancelBtnText: AppStrings.cancel.tr(context),
                            width: AppValues.screenWidth / 4,
                            onCancelBtnTap: () => Navigator.pop(context),
                            onConfirmBtnTap: () {
                              Navigator.pop(context);
                              context.read<RecepitBloc>().add(
                                  DeleteReceiptEvent(
                                      ids: e.receipts
                                          .map((receipt) => receipt.id)
                                          .toList()));
                            });
                      },
                      child:
                          Icon(Icons.delete_forever, color: AppColors.error))),
            ]))
        .toList();
  }

  List<DataGridRow> _clients = <DataGridRow>[];

  @override
  List<DataGridRow> get rows => _clients;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: Alignment.center,
        child: dataGridCell.value is Widget
            ? dataGridCell.value
            : Text(
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
