import 'package:baraneq/core/components/default_components/default_button.dart';
import 'package:baraneq/core/utils/app_colors.dart';
import 'package:baraneq/core/utils/app_strings.dart';
import 'package:baraneq/core/utils/app_values.dart';
import 'package:flutter/material.dart';

class OptionsCardComponent extends StatelessWidget {
  final VoidCallback exportPdf;
  final VoidCallback exportExecl;
  final VoidCallback printPdf;
  const OptionsCardComponent(
      {super.key,
      required this.exportPdf,
      required this.exportExecl,
      required this.printPdf});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppValues.paddingWidth * 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          /* Flexible(
            child: DefaultButton(
              borderColor: AppColors.primary,
              background: Colors.transparent,
              elevation: 0,
              onPressed: () => printPdf(),
              textColor: AppColors.black,
              text: AppStrings.print,
            ),
          ),
          SizedBox(
            width: AppValues.sizeWidth * 40,
          ),*/
          Flexible(
            child: DefaultButton(
              borderColor: AppColors.error,
              background: Colors.transparent,
              elevation: 0,
              onPressed: () => exportPdf(),
              textColor: AppColors.black,
              text: AppStrings.pdf,
            ),
          ),
          SizedBox(
            width: AppValues.sizeWidth * 40,
          ),
          Flexible(
            child: DefaultButton(
              elevation: 0,
              borderColor: AppColors.green,
              background: Colors.transparent,
              textColor: AppColors.black,
              onPressed: () => exportExecl(),
              text: AppStrings.exportExecl,
            ),
          ),
        ],
      ),
    );
  }
}
