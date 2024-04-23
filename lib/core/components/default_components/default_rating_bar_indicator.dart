import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultRatingBarIndicator extends StatelessWidget {
  final double rating;
  final int itemCount;
  final double itemSize;
  final EdgeInsets? itemPadding;
  final Color? inActiveColor;
  const DefaultRatingBarIndicator(
      {super.key,
      required this.rating,
      required this.itemCount,
      required this.itemSize,
      this.itemPadding,
      this.inActiveColor});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      itemPadding: itemPadding ?? EdgeInsets.all(4.sp),
      rating: rating,
      unratedColor: inActiveColor,
      itemBuilder: (context, index) => const Text("⭐"),
      itemCount: itemCount,
      itemSize: itemSize.sp,
      direction: Axis.horizontal,
    );
  }
}
