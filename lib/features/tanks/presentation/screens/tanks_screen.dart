import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:quickalert/quickalert.dart';
import '../../../../config/database/local/pagination_values.dart';
import '../../../../core/components/default_components/default_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';
import '../bloc/tank_crud_bloc/tank_crud_bloc.dart';
import '../bloc/tanks_bloc/tanks_bloc.dart';
import '../components/add_tank_component.dart';
import '../components/tanks_table_component.dart';

class TanksScreen extends StatelessWidget {
  const TanksScreen({super.key});
  void _handleStates(BuildContext context, TankCrudState state) {
    if (state is AddTankLoadingState) {
      context.loaderOverlay.show();
    } else if (state is AddTankErrorState) {
      context.loaderOverlay.hide();
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          autoCloseDuration: Durations.extralong4,
          showConfirmBtn: false,
          width: AppValues.screenWidth / 4,
          title: AppStrings.someThingWentWrong.tr(context));
    } else if (state is AddTankLoadedState) {
      context.loaderOverlay.hide();
      QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          showConfirmBtn: false,
          width: AppValues.screenWidth / 4,
          title: AppStrings.newTankAdded.tr(context),
          autoCloseDuration: Durations.extralong4);
      context
          .read<TanksBloc>()
          .add(GetTanksEvent(options: PaginationValues.getOptions()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<TankCrudBloc, TankCrudState>(
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
                                  Icons.propane_tank_outlined,
                                  size: AppValues.font * 25,
                                  color: AppColors.blueLight,
                                ),
                                SizedBox(
                                  width: AppValues.sizeWidth * 20,
                                ),
                                Text(
                                  AppStrings.tanks.tr(context),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: AppValues.sizeWidth * 150,
                              child: DefaultButton(
                                onPressed: () {
                                  showGeneralDialog(
                                    context: context,
                                    pageBuilder: (BuildContext context, a, b) {
                                      return AddTankComponent();
                                    },
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppStrings.addNewTank.tr(context),
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
                  child: TanksTableComponent(),
                ),
                SizedBox(
                  height: AppValues.sizeHeight * 40,
                ),
              ],
            )),
      ),
    );
  }
}
