import 'dart:io';

import 'package:baraneq/core/components/default_components/default_appbar.dart';
import 'package:baraneq/core/utils/app_strings.dart';
import 'package:baraneq/core/utils/app_values.dart';
import 'package:baraneq/features/client/presentation/screens/add_client_screen.dart';
import 'package:baraneq/features/invoices/presentation/screens/invoices_screen.dart';
import 'package:baraneq/features/profile/presentation/screens/profile_screen.dart';
import 'package:baraneq/features/search/presentation/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../../features/home/presentation/screens/home_screen.dart';
import '../../utils/app_colors.dart';
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

  @override
  Widget build(BuildContext context) {

    
    return Platform.isAndroid || Platform.isIOS
        ? MobileLayout(screens: _screens)
        : WindowsLayout(
            screens: _screens,
          );
  }
}
