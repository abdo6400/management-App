import 'package:baraneq/core/components/default_components/default_button.dart';
import 'package:baraneq/core/utils/app_colors.dart';
import 'package:baraneq/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../entities/client.dart';
import '../../utils/commen_services.dart';

class OptionsCardComponent extends StatelessWidget {
  final List<Client> clients;
  const OptionsCardComponent({super.key, required this.clients});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: DefaultButton(
            borderColor: AppColors.primary,
            background: Colors.transparent,
            elevation: 0,
            onPressed: () => showDialog(
              builder: (context) => PdfPreview(
                build: (format) =>
                    CommenServices.generatePdf(format, "", clients: clients,ctx: context),
              ),
              context: context,
            ),
            textColor: AppColors.black,
            text: AppStrings.print,
          ),
        ),
        Flexible(child: SizedBox()),
        Flexible(
          child: DefaultButton(
            elevation: 0,
            borderColor: AppColors.error,
            background: Colors.transparent,
            textColor: AppColors.black,
            onPressed: () => CommenServices.generateExcel(clients: clients),
            text: AppStrings.exportExecl,
          ),
        ),
      ],
    );
  }
}
