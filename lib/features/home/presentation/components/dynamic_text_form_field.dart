import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/default_components/default_form_field.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';
import '../../../../core/utils/custom_validation.dart';

class DynamicTextFormField extends StatefulWidget {
  final Map<TextEditingController, TextEditingController> fields;
  const DynamicTextFormField({super.key, required this.fields});

  @override
  State<DynamicTextFormField> createState() => _DynamicTextFormFieldState();
}

class _DynamicTextFormFieldState extends State<DynamicTextFormField> {
  Widget _buildField(
      TextEditingController tank, TextEditingController quantity) {
    return Row(children: [
      /*  SizedBox(
        width: AppValues.sizeWidth * 15,
      ),
      Icon(
        Icons.delete_forever,
        color: AppColors.error,
      ),
      SizedBox(
        width: AppValues.sizeWidth * 15,
      ),*/
      Flexible(
        flex: 1,
        child: DefaultTextFormField(
          controller: tank,
          type: TextInputType.phone,
          label: AppStrings.tank,
          prefix: Icons.propane_tank,
          validate: (value) => CustomValidationHandler.isVaildCode(value)
              .translateWithNullSafetyString(context),
        ),
      ),
      SizedBox(
        width: AppValues.sizeWidth * 20,
      ),
      Flexible(
        flex: 2,
        child: DefaultTextFormField(
          controller: quantity,
          type: TextInputType.phone,
          label: AppStrings.quantity,
          prefix: Icons.add_to_queue_outlined,
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.fields.entries
          .map((e) => _buildField(e.key, e.value))
          .toList(),
    );
  }
}
