import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:baraneq/core/utils/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:quickalert/quickalert.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../bloc/balance_bloc/balance_bloc.dart';
import '../bloc/exporter_bloc/exporter_bloc.dart';
import '../bloc/importers_bloc/importers_bloc.dart';
import '../bloc/receipt_bloc/recepit_bloc.dart';
import '../components/balance_component.dart';
import '../components/custom_tab_bar_component.dart';
import 'exporters_screen.dart';
import 'importers_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  void _handleStates(BuildContext context, RecepitState state) {
    if (state is RecepitLoadingState) {
      context.loaderOverlay.show();
    } else if (state is RecepitLoadErrorState) {
      context.loaderOverlay.hide();
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          autoCloseDuration: Durations.extralong4,
          showConfirmBtn: false,
          title: AppStrings.someThingWentWrong.tr(context));
    } else if (state is RecepitAddLoadedState) {
      context.loaderOverlay.hide();
      QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              autoCloseDuration: Durations.extralong4,
              showConfirmBtn: false,
              title: AppStrings.receiptAdded.tr(context))
          .then((value) {
        context.read<ExporterBloc>().add(GetExportersClientsEvent());
        context.read<ImportersBloc>().add(GetImportersClientsEvent());
        context.read<BalanceBloc>().add(GetBalanceEvent());
        context.read<ProfileBloc>().add(GetTanksEvent());
      });
    } else if (state is RecepitEditLoadedState) {
      context.loaderOverlay.hide();
      QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              autoCloseDuration: Durations.extralong4,
              showConfirmBtn: false,
              title: AppStrings.receiptEdited.tr(context))
          .then((value) {
        context.read<ExporterBloc>().add(GetExportersClientsEvent());
        context.read<ImportersBloc>().add(GetImportersClientsEvent());
        context.read<BalanceBloc>().add(GetBalanceEvent());
        context.read<ProfileBloc>().add(GetTanksEvent());
      });
    } else if (state is RecepitDeleteLoadedState) {
      context.loaderOverlay.hide();
      QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              autoCloseDuration: Durations.extralong4,
              showConfirmBtn: false,
              title: AppStrings.receiptDeleted.tr(context))
          .then((value) {
        context.read<ExporterBloc>().add(GetExportersClientsEvent());
        context.read<ImportersBloc>().add(GetImportersClientsEvent());
        context.read<BalanceBloc>().add(GetBalanceEvent());
        context.read<ProfileBloc>().add(GetTanksEvent());
      });
      ;
    }
  }

  late TabController tabController;
  @override
  void initState() {
    super.initState();

    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RecepitBloc, RecepitState>(
        listener: _handleStates,
        child: SizedBox(
            height: AppValues.screenHeight,
            width: AppValues.screenWidth,
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  SizedBox(
                    height: AppValues.sizeHeight * 10,
                  ),
                  const Expanded(
                    flex: 2,
                    child: BalanceComponents(),
                  ),
                  const Divider(),
                  Expanded(
                    flex: 2,
                    child: CustomTabBarComponent(
                      tabController: tabController,
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: AppValues.paddingHeight * 5,
                          right: AppValues.paddingWidth * 5,
                          left: AppValues.paddingWidth * 5),
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          ImportersScreen(),
                          ExportersScreen(),
                        ],
                      ),
                    ),
                  ),

                  //  OptionsCardComponent(clients: []),
                ],
              ),
            )),
      ),
    );
  }
}
