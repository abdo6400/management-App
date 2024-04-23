import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../utils/app_colors.dart';

class DefaultLoadingIndicator extends StatelessWidget {
  final Color? color;
  final double? value;
  const DefaultLoadingIndicator({super.key, this.color, this.value});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: LoadingIndicator(
          indicatorType: Indicator.ballPulse,
          colors: [
            AppColors.lightGrey,
            AppColors.primary,
            AppColors.lightGrey,
            AppColors.primary,
          ],
          strokeWidth: 2,
          backgroundColor: Colors.transparent,
          pathBackgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
