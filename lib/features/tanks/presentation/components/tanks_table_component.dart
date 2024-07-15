import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:baraneq/core/utils/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/components/app_components/options_card_component.dart';
import '../../../../core/components/default_components/default_message_card.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../domain/entities/tank.dart';
import '../bloc/tanks_bloc/tanks_bloc.dart';

class TanksTableComponent extends StatelessWidget {
  TanksTableComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TanksBloc, TanksState>(
      builder: (contImt, state) {
        if (state is TanksLoadingState) {
          return Center(
              child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: CircularProgressIndicator()));
        } else if (state is TanksErrorState) {
          return DefaultMessageCard(
              sign: "!",
              title: AppStrings.someThingWentWrong,
              subTitle: state.message);
        } else if (state is TanksLoadedState) {
          if (state.tanks.isEmpty) {
            return DefaultMessageCard(
                sign: "!", title: AppStrings.noTanksFound, subTitle: "");
          }
          final data = _TanksDataSource(clients: state.tanks, context: context);
          return _TanksTable(
            myData: data,
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class _TanksTable extends StatelessWidget {
  final _TanksDataSource myData;
  final GlobalKey<SfDataGridState> dataKey = GlobalKey<SfDataGridState>();
  _TanksTable({required this.myData});
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
                  selectionMode: SelectionMode.multiple,
                  columnSizer: ColumnSizer(),
                  columnWidthCalculationRange:
                      ColumnWidthCalculationRange.allRows,
                  tableSummaryRows: [
                    GridTableSummaryRow(
                        showSummaryInRow: true,
                        title:
                            '''${AppStrings.clientsNumber.tr(context)} :\t\t\t\t {ClientCount} ''',
                        color: AppColors.white,
                        columns: [
                          GridSummaryColumn(
                              name: 'Sum',
                              columnName:
                                  AppStrings.currentQuantity.tr(context),
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
                        columnName: AppStrings.name,
                        allowSorting: false,
                        allowFiltering: false),
                    _buildGridColumns(context,
                        columnName: AppStrings.capacity, allowSorting: true),
                    _buildGridColumns(context,
                        columnName: AppStrings.currentQuantity,
                        allowSorting: true),
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

class _TanksDataSource extends DataGridSource {
  _TanksDataSource(
      {required List<Tank> clients, required BuildContext context}) {
    _clients = clients
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: AppStrings.id.tr(context), value: e.id),
              DataGridCell<String>(
                  columnName: AppStrings.name.tr(context), value: e.name),
              DataGridCell<double>(
                  columnName: AppStrings.capacity.tr(context),
                  value: e.capacity),
              DataGridCell<double>(
                  columnName: AppStrings.currentQuantity.tr(context),
                  value: e.currentQuantity),
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
