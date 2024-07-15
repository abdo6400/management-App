import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:baraneq/core/utils/app_values.dart';
import 'package:baraneq/features/client/domain/entities/client_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../config/database/local/pagination_values.dart';
import '../../../../core/components/app_components/options_card_component.dart';
import '../../../../core/components/default_components/default_message_card.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../bloc/client_bloc/client_information_bloc.dart';

class ClientsTableComponent extends StatelessWidget {
  ClientsTableComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientInformationBloc, ClientInformationState>(
      builder: (context, state) {
        if (state is ClientLoadingState) {
          return Center(
              child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: CircularProgressIndicator()));
        } else if (state is ClientErrorState) {
          return DefaultMessageCard(
              sign: "!",
              title: AppStrings.someThingWentWrong,
              subTitle: state.message);
        } else if (state is ClientLoadedState) {
          if (state.clients.isEmpty) {
            return DefaultMessageCard(
                sign: "!", title: AppStrings.noClientsFound, subTitle: "");
          }
          final data =
              _ClientsDataSource(clients: state.clients, context: context);
          Map<String, dynamic> options = {
            "count": state.clients.first.totalClientsCount,
            "pageSize": state.options["pageSize"],
            "page": state.options["page"]
          };

          return _ClientsTable(myData: data, options: options);
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class _ClientsTable extends StatelessWidget {
  final _ClientsDataSource myData;
  final GlobalKey<SfDataGridState> dataKey = GlobalKey<SfDataGridState>();
  final DataPagerController controller = DataPagerController();
  final Map<String, dynamic> options;
  _ClientsTable({required this.myData, required this.options});
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
                              columnName: AppStrings.receiptsCount.tr(context),
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
                        columnName: AppStrings.receiptsCount,
                        allowSorting: true),
                    _buildGridColumns(context,
                        columnName: AppStrings.importer, allowSorting: true),
                    _buildGridColumns(context,
                        columnName: AppStrings.exporter, allowSorting: true),
                  ],
                ),
              ),
            ),
            /*  Expanded(
                flex: 2,
                child: SfDataPagerTheme(
                  data: SfDataPagerThemeData(
                      itemBorderWidth: 0.5,
                      itemBorderColor: AppColors.darkGrey.withOpacity(0.5),
                      itemBorderRadius:
                          BorderRadius.circular(AppValues.radius * 10),
                      selectedItemColor: AppColors.blueLight),
                  child: SfDataPager(
                    firstPageItemVisible: false,
                    lastPageItemVisible: false,
                    pageCount: double.parse(
                            (options["count"] / options["pageSize"]).toString())
                        .ceil()
                        .toDouble(),
                    visibleItemsCount: 3,
                    navigationItemWidth: AppValues.sizeWidth * 100,
                    delegate: myData,
                    pageItemBuilder: (String itemName) {
                      if (itemName == 'Next') {
                        return Center(
                          child: Text(AppStrings.next.tr(context)),
                        );
                      }
                      if (itemName == 'Previous') {
                        return Center(
                          child: Text(AppStrings.previous.tr(context)),
                        );
                      }
                    },
                    itemPadding: EdgeInsets.symmetric(
                        horizontal: AppValues.paddingWidth * 10,
                        vertical: AppValues.paddingHeight * 10),
                  ),
                ))*/
          ],
        ),
      ),
    );
  }
} /**/

class _ClientsDataSource extends DataGridSource {
  final BuildContext context;
  _ClientsDataSource(
      {required List<ClientInformation> clients, required this.context}) {
    _clients = clients
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: AppStrings.id.tr(context), value: e.id),
              DataGridCell<String>(
                  columnName: AppStrings.name.tr(context), value: e.name),
              DataGridCell<String>(
                  columnName: AppStrings.phoneNumber.tr(context),
                  value: e.phoneNumber),
              DataGridCell<int>(
                  columnName: AppStrings.receiptsCount.tr(context),
                  value: e.receiptCount),
              DataGridCell<double>(
                  columnName: AppStrings.importer.tr(context),
                  value: e.importerReceiptsTotalQuantity),
              DataGridCell<double>(
                  columnName: AppStrings.exporter.tr(context),
                  value: e.exporterReceiptsTotalQuantity),
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

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    if (newPageIndex != oldPageIndex) {
      context.read<ClientInformationBloc>().add(UpdateClientInformationEvent(
          options: PaginationValues.getOptions(page: newPageIndex + 1)));
      return true;
    }
    return false;
  }
}
