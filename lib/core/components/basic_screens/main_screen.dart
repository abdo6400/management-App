import 'package:baraneq/core/components/app_components/options_card_component.dart';
import 'package:baraneq/core/components/default_components/default_appbar.dart';
import 'package:baraneq/core/utils/app_strings.dart';
import 'package:baraneq/core/utils/app_values.dart';
import 'package:baraneq/features/client/presentation/screens/add_client_screen.dart';
import 'package:baraneq/features/invoices/presentation/screens/invoices_screen.dart';
import 'package:baraneq/features/profile/presentation/screens/profile_screen.dart';
import 'package:baraneq/features/search/presentation/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:quickalert/quickalert.dart';

import '../../../features/home/presentation/screens/home_screen.dart';
import '../../utils/app_colors.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static final List<Map<String, dynamic>> _screens = [
    {
      "icon": Icons.home,
      "title": AppStrings.home,
      "screen": const HomeScreen()
    },
    {
      "icon": Icons.search_sharp,
      "title": AppStrings.search,
      "screen": const SearchScreen()
    },
    {
      "icon": Icons.add,
      "title": AppStrings.addNewClient,
      "screen": const AddClientScreen()
    },
    {
      "icon": Icons.receipt,
      "title": AppStrings.invoices,
      "screen": const InvoicesScreen()
    },
    {
      "icon": Icons.person,
      "title": AppStrings.profile,
      "screen": const ProfileScreen()
    },
  ];
  static final PersistentTabController controller =
      PersistentTabController(initialIndex: 0);
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: controller,
      context,
      floatingActionButton: SpeedDial(
        elevation: 5,
        animationCurve: Curves.elasticInOut,
        shape: const StadiumBorder(),
        direction: SpeedDialDirection.up,
        icon: Icons.settings,
        iconTheme:
            Theme.of(context).iconTheme.copyWith(color: AppColors.primary),
        backgroundColor: AppColors.nearlyWhite,
        children: [
          SpeedDialChild(
            child: const Icon(
              Icons.share,
              color: AppColors.primary,
            ),
            onTap: () => QuickAlert.show(
                type: QuickAlertType.custom,
                context: context,
                widget: OptionsCardComponent()),
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.print,
              color: AppColors.green,
            ),
            onTap: () => QuickAlert.show(
                type: QuickAlertType.custom,
                context: context,
                widget: OptionsCardComponent()),
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.file_download,
              color: AppColors.error,
            ),
            onTap: () => QuickAlert.show(
                type: QuickAlertType.custom,
                context: context,
                widget: OptionsCardComponent()),
          ),
        ],
      ),
      screens: List<Widget>.from(_screens.map((e) => SafeArea(
            child: Scaffold(
              appBar: DefaultAppBar(
                addLang: false,
                addLeadingButton: false,
                appBarText: e["title"].toString(),
                backgroundColor: AppColors.white,
                elevation: 0.5,
              ),
              body: e["screen"],
            ),
          ))),
      items: _screens
          .map((e) => PersistentBottomNavBarItem(
              icon: Icon(e["icon"]),
              activeColorSecondary: AppColors.primary,
              activeColorPrimary: AppColors.white,
              inactiveColorSecondary: AppColors.grey,
              inactiveColorPrimary: AppColors.grey,
              iconSize: AppValues.font * 30))
          .toList(),
      confineInSafeArea: true,
      backgroundColor: AppColors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: const NavBarDecoration(
        colorBehindNavBar: AppColors.white,
        borderRadius: BorderRadius.zero,
        boxShadow: [
          BoxShadow(
            color: Colors.grey, // Set your desired shadow color here
            blurRadius: 10,
            spreadRadius: 0,
            offset: Offset(0, 2), // This will cast the shadow only downwards
          ),
        ],
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: false,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style12, // Choose the nav bar style with this property.
    );
  }
}
