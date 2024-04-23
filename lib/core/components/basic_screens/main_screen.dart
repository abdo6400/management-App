import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:baraneq/core/components/default_components/default_appbar.dart';
import 'package:baraneq/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../utils/app_colors.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static final List<Map<String, dynamic>> _screens = [
    {"icon": Icons.home, "title": AppStrings.home},
    {"icon": Icons.search_sharp, "title": AppStrings.search},
    {"icon": Icons.add, "title": AppStrings.addNewClient},
    {"icon": Icons.receipt, "title": AppStrings.history},
    {"icon": Icons.person, "title": AppStrings.profile},
  ];
  static final PersistentTabController controller =
      PersistentTabController(initialIndex: 0);
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: controller,
      context,
      screens: List<Widget>.from(_screens.map((e) => SafeArea(
            child: Scaffold(
              appBar: DefaultAppBar(
                addLang: false,
                addLeadingButton: false,
                appBarText: e["title"].toString(),
                backgroundColor: AppColors.white,
                elevation: 2
            ,
              ),
              body: Center(child: Text(e["title"].toString().tr(context))),
            ),
          ))),
      items: _screens
          .map((e) => PersistentBottomNavBarItem(
                icon: Icon(e["icon"]),
                activeColorPrimary: AppColors.primary,
                inactiveColorPrimary: AppColors.grey,
              ))
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
          NavBarStyle.style15, // Choose the nav bar style with this property.
    );
  }
}