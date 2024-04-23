
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/locale/app_localizations.dart';
import '../../utils/app_enums.dart';
import '../../utils/app_values.dart';
import '/core/utils/app_colors.dart';
import '/core/utils/app_strings.dart';

class CustomAlertDialog extends StatelessWidget {
  final AlertDialogType type;
  final String? title;
  final String? content;
  final String? buttonLabel;
  final String? buttonLabel2;
  final Widget? icon;
  final Function()? function;

  const CustomAlertDialog(
      {super.key,
      this.title,
      this.content,
      this.buttonLabel,
      this.buttonLabel2,
      required this.type,
      this.icon,
      this.function});

  IconData _getIcon(AlertDialogType type) {
    switch (type) {
      case AlertDialogType.success:
        return Icons.check_circle;
      case AlertDialogType.warrning:
        return Icons.warning;
      case AlertDialogType.error:
        return Icons.error;
      default:
        return Icons.info_outline;
    }
  }

  Color _getColor(AlertDialogType type) {
    switch (type) {
      case AlertDialogType.success:
        return Colors.green;
      case AlertDialogType.warrning:
        return Colors.orange;
      case AlertDialogType.error:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: AppValues.marginWidth * 50),
          padding: EdgeInsets.symmetric(
              horizontal: AppValues.paddingWidth * 20,
              vertical: AppValues.paddingHeight * 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              (icon != null)
                  ? icon!
                  : Icon(
                      size: 30.sp,
                      _getIcon(type),
                      color: _getColor(type),
                    ),
              SizedBox(
                height: AppValues.sizeHeight * 10,
              ),
              if (title != null)
                Text(
                  AppLocalizations.of(context)!.translate(title!) ?? title!,
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w400),
                ),
              const Divider(),
              if (content != null)
                Text(
                    AppLocalizations.of(context)!.translate(content!) ??
                        content!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(
                height: AppValues.sizeHeight * 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (buttonLabel != null)
                    TextButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(6.0))),
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (function != null) {
                          function!();
                        }
                      },
                      child: Text(buttonLabel!.tr(context),
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: _getColor(type))),
                    ),
                  if (buttonLabel2 != null)
                    TextButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(6.0))),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(buttonLabel2!.tr(context),
                          style: Theme.of(context).textTheme.labelLarge),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConfirmationDialog extends StatelessWidget {
  final String alertMsg;
  final VoidCallback onTapConfirm;

  const ConfirmationDialog(
      {super.key, required this.alertMsg, required this.onTapConfirm});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppValues.radius * 10),
          side: const BorderSide(color: AppColors.primary)),
      title: Icon(
        size: 50.sp,
        Icons.info,
        color: Colors.blue,
      ),
      content: Text(
        alertMsg,

        style: Theme.of(context).textTheme.bodyLarge,
        //  TextStyle(
        //     fontFamily: AppStrings.fontName,
        //     color: AppColors.primaryColor,
        //     fontSize: 16,
        //     fontWeight: FontWeight.w600),
      ),
      actions: <Widget>[
        TextButton(
            style: Theme.of(context).textButtonTheme.style,
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              AppStrings.cancel.tr(context),
            )),
        TextButton(
          style: Theme.of(context).textButtonTheme.style,
          onPressed: () => onTapConfirm(),
          child: Text(
            AppStrings.ok.tr(context),
          ),
        ),
      ],
    );
  }
}

class ImagePickerDialog extends StatelessWidget {
  final void Function()? cameraOnTap;
  final void Function()? galleryOnTap;

  const ImagePickerDialog({super.key, this.cameraOnTap, this.galleryOnTap});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAlias,
      backgroundColor: AppColors.black,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      child: Wrap(children: <Widget>[
        ListTile(
            leading: const Icon(
              Icons.camera_alt,
              color: AppColors.primary,
            ),
            title: Text(AppStrings.camera.tr(context),
                style: const TextStyle(
                  color: AppColors.primary,
                )),
            onTap: cameraOnTap),
        ListTile(
            leading: const Icon(
              Icons.photo_outlined,
              color: AppColors.primary,
            ),
            title: Text(AppStrings.gallery.tr(context),
                style: const TextStyle(
                  color: AppColors.primary,
                )),
            onTap: galleryOnTap),
      ]),
    );
  }
}
