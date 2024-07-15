import 'dart:io';
import 'package:baraneq/core/utils/app_strings.dart';
import 'package:baraneq/features/client/presentation/screens/clients_screen.dart';
import 'package:baraneq/features/invoices/presentation/screens/invoices_screen.dart';
import 'package:baraneq/features/profile/presentation/screens/profile_screen.dart';
import 'package:baraneq/features/search/presentation/screens/search_screen.dart';
import 'package:flutter/material.dart';
import '../../../features/home/presentation/screens/home_screen.dart';
import '../../../features/tanks/presentation/screens/tanks_screen.dart';
import 'mobile_layout.dart';
import 'windows_layout.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static final List<Map<String, dynamic>> _screens = [
    {
      "icon": Icons.home,
      "title": AppStrings.home,
      "screen": const HomeScreen()
    },
    {
      "icon": Icons.receipt,
      "title": AppStrings.invoices,
      "screen": SearchScreen()
    },
    /* {
      "icon": Icons.search_sharp,
      "title": AppStrings.search,
      "screen":  SearchScreen()
    },*/
    {
      "icon": Icons.groups_outlined,
      "title": AppStrings.clients,
      "screen": const ClientScreen()
    },
    {
      "icon": Icons.propane_tank_outlined,
      "title": AppStrings.tanks,
      "screen": const TanksScreen()
    },
    {
      "icon": Icons.person,
      "title": AppStrings.profile,
      "screen": const ProfileScreen()
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid || Platform.isIOS
        ? MobileLayout(screens: _screens)
        : WindowsLayout(
            screens: _screens,
          );
  }
}
