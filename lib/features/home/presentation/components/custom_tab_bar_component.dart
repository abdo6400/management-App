import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:baraneq/features/home/presentation/components/create_receipt_component.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';

class CustomTabBarComponent extends StatelessWidget {
  const CustomTabBarComponent({super.key});

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
                title: Text(
                  AppStrings.clientType.tr(context),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                leading: GestureDetector(
                    onTap: () {
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.custom,
                          confirmBtnText: AppStrings.importer.tr(context),
                          cancelBtnText: AppStrings.cancel.tr(context),
                          confirmBtnColor: Theme.of(context).primaryColor,
                          showCancelBtn: true,
                          widget: CreateReceiptComponent());
                    },
                    child: const Icon(Icons.add_circle)),
              )),
          Expanded(
            child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: AppValues.marginWidth * 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppValues.radius * 10)),
                child: TabBar(
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
