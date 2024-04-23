import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_values.dart';
import '/core/utils/app_colors.dart';

class DefaultButton extends StatelessWidget {
  final bool isUpperCase;
  final double width;
  final double? height;
  final double radius;
  final Color? background;
  final Color textColor;
  final Color? splashColor;
  final Color? disabledColor;
  final VoidCallback? onPressed; // voidCallback = void Function()
  final String? text;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? fontSize;
  final double? textScaleFactor;
  final double? elevation;
  final ButtonStyle? buttonStyle;
  final Color? borderColor;
  const DefaultButton({
    super.key,
    this.textColor = AppColors.white,
    required this.onPressed,
    this.text,
    this.width = double.infinity,
    this.isUpperCase = false,
    this.background,
    this.radius = 14,
    this.child,
    this.splashColor,
    this.padding,
    this.margin,
    this.borderColor,
    this.height,
    this.fontSize = 16,
    this.textScaleFactor,
    this.buttonStyle,
    this.elevation = 1,
    this.disabledColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      child: ElevatedButton(
        style: buttonStyle ??
            Theme.of(context).elevatedButtonTheme.style!.copyWith(
                elevation: MaterialStatePropertyAll(elevation),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    side: borderColor != null
                        ? BorderSide(color: borderColor!)
                        : BorderSide.none,
                    borderRadius: BorderRadius.circular(radius.r))),
                backgroundColor: MaterialStatePropertyAll(background)),
        onPressed: onPressed,
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(),
          child: child ??
              Text(
                isUpperCase ? text!.toUpperCase() : text!.tr(context),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: textColor,
                      fontSize: AppValues.font * fontSize!,
                    ),
              ),
        ),
      ),
    );
  }
}
