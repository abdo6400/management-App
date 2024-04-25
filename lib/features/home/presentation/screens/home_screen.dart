import 'package:baraneq/core/utils/app_values.dart';
import 'package:flutter/material.dart';
import '../components/balance_component.dart';
import '../components/custom_tab_bar_component.dart';
import 'exporters_screen.dart';
import 'importers_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
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
                const Expanded(
                  flex: 2,
                  child: CustomTabBarComponent(),
                ),
                Expanded(
                  flex: 10,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: AppValues.paddingHeight * 5,
                        right: AppValues.paddingWidth * 5,
                        left: AppValues.paddingWidth * 5),
                    child: const TabBarView(
                      children: [
                        ImportersScreen(),
                        ExportersScreen(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
