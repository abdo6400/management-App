import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:baraneq/core/utils/app_colors.dart';
import 'package:baraneq/features/home/presentation/bloc/client_search_bloc/client_search_bloc.dart';
import 'package:baraneq/features/home/presentation/components/create_receipt_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../../../../core/components/app_components/options_card_component.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';

class CustomTabBarComponent extends StatelessWidget {
  final TabController tabController;
  const CustomTabBarComponent({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppValues.screenWidth,
      child: Column(
        children: [
          Container(
              margin:
                  EdgeInsets.symmetric(horizontal: AppValues.marginWidth * 10),
              child: ListTile(
                dense: true,
                title: Text(
                  AppStrings.clientType.tr(context),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                leading: GestureDetector(
                    onTap: () {
                      context
                          .read<ClientSearchBloc>()
                          .add(SearchCleanClientEvent());
                      showSearch(
                              context: context,
                              delegate: CustomSearchDelegate(
                                  isExporter: tabController.index == 1))
                          .then((value) {
                        if (value != null) {
                          showGeneralDialog(
                            context: context,
                            pageBuilder: (BuildContext context, a, b) {
                              return CreateReceiptComponent(
                                  isExporter: tabController.index == 1,
                                  client: value);
                            },
                          );
                        }
                      });
                    },
                    child:
                        const Icon(Icons.add_circle, color: AppColors.primary)),
              )),
          Expanded(
            child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: AppValues.marginWidth * 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppValues.radius * 10)),
                child: TabBar(
                  controller: tabController,
                  tabs: [
                    Tab(
                      text: AppStrings.importer.tr(context),
                    ),
                    Tab(
                      text: AppStrings.exporter.tr(context),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  String _currentQuery = '';
  final bool isExporter;
  // Method to handle query changes
  void handleQueryChange(String newQuery, BuildContext context) {
    if (newQuery != _currentQuery) {
      _currentQuery = newQuery;
      if (newQuery.isEmpty) {
        context.read<ClientSearchBloc>().add(SearchCleanClientEvent());
      } else {
        context
            .read<ClientSearchBloc>()
            .add(SearchClientEvent(value: newQuery, isExporter: isExporter));
      }
    }
  }

  CustomSearchDelegate({required this.isExporter});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          _currentQuery = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    handleQueryChange(query, context);
    return BlocBuilder<ClientSearchBloc, ClientSearchState>(
        builder: ((context, state) {
      if (state is ClientSearchLoadingState) {
        return const Center(
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is ClientSearchLoadedState) {
        return ListView.builder(
          itemCount: state.clients.length,
          itemBuilder: ((_, index) {
            return ListTile(
              title: Text(state.clients[index].name),
              onTap: () {
                close(context, state.clients[index]);
              },
            );
          }),
        );
      } else if (state is ClientSearchErrorState) {
        return Center(child: Text(state.message));
      } else {
        return Center();
      }
    }));
  }
}
