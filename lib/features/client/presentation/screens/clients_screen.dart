import 'package:baraneq/config/locale/app_localizations.dart';

import 'package:baraneq/core/utils/app_strings.dart';
import 'package:baraneq/features/client/presentation/bloc/client_bloc/client_information_bloc.dart';
import 'package:baraneq/features/client/presentation/bloc/client_crud_bloc/client_crud_bloc.dart';
import 'package:baraneq/features/client/presentation/components/clients_table_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';
import '../../../../config/database/local/pagination_values.dart';
import '../../../../core/components/default_components/default_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_values.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../home/presentation/bloc/blocs/balance_bloc/balance_bloc.dart';
import '../../../tanks/presentation/bloc/tanks_bloc/tanks_bloc.dart';
import '../components/add_client_component.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({super.key});
  void getData(BuildContext context) {
    context.read<BalanceBloc>().add(GetBalanceEvent());
    context
        .read<TanksBloc>()
        .add(GetTanksEvent(options: PaginationValues.getOptions()));
    context.read<ClientInformationBloc>().add(
        GetClientsInformationEvent(options: PaginationValues.getOptions()));
  }

  void _handleStates(BuildContext context, ClientCrudState state) {
    if (state is AddClientLoadingState) {
      context.loaderOverlay.show();
    } else if (state is AddClientErrorState) {
      context.loaderOverlay.hide();
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          autoCloseDuration: Durations.extralong4,
          showConfirmBtn: false,
          width: AppValues.screenWidth / 4,
          title: AppStrings.someThingWentWrong.tr(context));
    } else if (state is AddClientLoadedState) {
      context.loaderOverlay.hide();
      QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          showConfirmBtn: false,
          width: AppValues.screenWidth / 4,
          title: AppStrings.newClientAdded.tr(context),
          autoCloseDuration: Durations.extralong4);
      getData(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ClientCrudBloc, ClientCrudState>(
        listener: _handleStates,
        child: SizedBox(
            height: AppValues.screenHeight,
            width: AppValues.screenWidth,
            child: Column(
              children: [
                SizedBox(
                  height: AppValues.sizeHeight * 20,
                ),
                Expanded(
                    flex: 1,
                    child: Card(
                      color: AppColors.white,
                      margin: EdgeInsets.symmetric(
                          horizontal: AppValues.marginWidth * 5),
                      elevation: 0.1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppValues.paddingWidth * 50,
                          vertical: AppValues.paddingHeight * 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.groups_2_outlined,
                                  size: AppValues.font * 25,
                                  color: AppColors.blueLight,
                                ),
                                SizedBox(
                                  width: AppValues.sizeWidth * 20,
                                ),
                                Text(
                                  AppStrings.clients.tr(context),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: AppValues.sizeWidth * 200,
                              child: DefaultButton(
                                onPressed: () {
                                  showGeneralDialog(
                                    context: context,
                                    pageBuilder: (BuildContext context, a, b) {
                                      return AddClientComponent();
                                    },
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppStrings.addNewClient.tr(context),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                            color: AppColors.white,
                                            fontSize: AppValues.font * 12,
                                          ),
                                    ),
                                    const Icon(
                                      Icons.add_circle_outline_outlined,
                                      color: AppColors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                SizedBox(
                  height: AppValues.sizeHeight * 20,
                ),
                Expanded(
                  flex: 10,
                  child: ClientsTableComponent(),
                ),
                SizedBox(
                  height: AppValues.sizeHeight * 10,
                ),
              ],
            )),
      ),
    );
  }
}
