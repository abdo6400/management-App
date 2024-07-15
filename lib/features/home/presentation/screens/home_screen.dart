import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:baraneq/core/utils/app_colors.dart';
import 'package:baraneq/core/utils/app_values.dart';
import 'package:baraneq/features/tanks/presentation/bloc/tanks_bloc/tanks_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:quickalert/quickalert.dart';
import '../../../../config/database/local/pagination_values.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../client/presentation/bloc/client_bloc/client_information_bloc.dart';
import '../bloc/blocs/balance_bloc/balance_bloc.dart';
import '../bloc/blocs/clients_bloc/clients_bloc.dart';
import '../bloc/blocs/receipt_bloc/recepit_bloc.dart';
import '../bloc/cubits/appbar_cubit/appbar_cubit.dart';
import '../bloc/cubits/tanks_cubit/tanks_cubit.dart';
import '../components/statistics_card_component.dart';
import '../components/custom_tab_bar_component.dart';
import '../components/receipts_table_component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  void getData(BuildContext context) {
    final options = PaginationValues.getOptions();
    if (context.read<AppbarCubit>().selected == 0) {
      options['type'] = AppStrings.exporter.toUpperCase();
    } else if (context.read<AppbarCubit>().selected == 1) {
      options['type'] = AppStrings.importer.toUpperCase();
    }
    context.read<ClientsBloc>().add(GetClientsEvent(options: options));
    context.read<BalanceBloc>().add(GetBalanceEvent());
    context
        .read<TanksBloc>()
        .add(GetTanksEvent(options: PaginationValues.getOptions()));
    context.read<ClientInformationBloc>().add(
        GetClientsInformationEvent(options: PaginationValues.getOptions()));
  }

  void _handleStates(BuildContext context, RecepitState state) {
    if (state is RecepitLoadingState) {
      context.loaderOverlay.show();
    } else if (state is RecepitLoadErrorState) {
      context.loaderOverlay.hide();
      context.read<TanksCubit>().clear();
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          width: AppValues.screenWidth / 4,
          autoCloseDuration: Durations.extralong4,
          showConfirmBtn: false,
          title: AppStrings.someThingWentWrong.tr(context));
    } else if (state is RecepitAddLoadedState) {
      context.loaderOverlay.hide();
      context.read<TanksCubit>().clear();
      QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              autoCloseDuration: Durations.extralong4,
              showConfirmBtn: false,
              width: AppValues.screenWidth / 4,
              title: AppStrings.receiptAdded.tr(context))
          .then((value) {
        getData(context);
      });
    } else if (state is RecepitEditLoadedState) {
      context.loaderOverlay.hide();
      QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              autoCloseDuration: Durations.extralong4,
              showConfirmBtn: false,
              width: AppValues.screenWidth / 4,
              title: AppStrings.receiptEdited.tr(context))
          .then((value) {
        getData(context);
      });
    } else if (state is RecepitDeleteLoadedState) {
      context.loaderOverlay.hide();
      QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              autoCloseDuration: Durations.extralong4,
              showConfirmBtn: false,
              width: AppValues.screenWidth / 4,
              title: AppStrings.receiptDeleted.tr(context))
          .then((value) {
        getData(context);
      });
      ;
    }
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
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        StatisticsCardComponent(
                          title: AppStrings.balance,
                          color: AppColors.primary,
                          function: () {},
                        ),
                        StatisticsCardComponent(
                          title: AppStrings.importer,
                          function: () {},
                        ),
                        StatisticsCardComponent(
                          title: AppStrings.exporter,
                          function: () {},
                        ),
                        StatisticsCardComponent(
                          title: AppStrings.clientsNumber,
                          type: AppStrings.client,
                          function: () {},
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppValues.sizeHeight * 20,
                  ),
                  Expanded(
                    flex: 2,
                    child: CustomTabBarComponent(),
                  ),
                  SizedBox(
                    height: AppValues.sizeHeight * 20,
                  ),
                  Expanded(
                    flex: 10,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: AppValues.paddingHeight * 5,
                          right: AppValues.paddingWidth * 5,
                          left: AppValues.paddingWidth * 5),
                      child: ReceiptsTableComponent(),
                    ),
                  ),
                  SizedBox(
                    height: AppValues.sizeHeight * 10,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
