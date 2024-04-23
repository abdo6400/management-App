import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/app_colors.dart';

class ShimmerLoader extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? child;
  final double? borderRadius;
  const ShimmerLoader(
      {super.key, this.height, this.width, this.child, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Shimmer.fromColors(
          baseColor: AppColors.grey.withOpacity(0.1),
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: child ??
              Container(
                height: double.infinity,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(borderRadius!.r)),
              )),
    );
  }
}

class LoaderOne extends StatefulWidget {
  final Color? color;

  const LoaderOne({super.key, this.color});
  @override
  _LoaderOneState createState() => _LoaderOneState();
}

class _LoaderOneState extends State<LoaderOne>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    animation = CurvedAnimation(parent: controller, curve: Curves.elasticOut);
    animation.addListener(() {
      setState(() {});
    });

    animation.addStatusListener((AnimationStatus status) {});
    controller.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          color: widget.color,
          height: 3.0,
          width: animation.value * 75.0,
        ),
        const SizedBox(
          height: 5.0,
        ),
        Container(
          color: widget.color,
          height: 3.0,
          width: animation.value * 50.0,
        ),
        const SizedBox(
          height: 5.0,
        ),
        Container(
          color: widget.color,
          height: 3.0,
          width: animation.value * 35.0,
        ),
      ],
    );
  }
}

class Loader3 extends StatelessWidget {
  const Loader3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: LoadingIndicator(
          indicatorType: Indicator.ballRotateChase,
          colors: [
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

class LoaderTwo extends StatefulWidget {
  final Color centralDotColor;
  final Color dotOneColor;
  final Color dotTwoColor;
  final Color dotThreeColor;
  final Color dotFourColor;
  final Color dotFiveColor;
  final Color dotSixColor;
  final Color dotSevenColor;
  final Color dotEightColor;
  final double centralDotRadius;
  final double outerDotRadius;
  final double spanRadius;
  final Duration duration;

  const LoaderTwo(
      {super.key,
      this.centralDotColor = Colors.black26,
      this.dotOneColor = Colors.red,
      this.dotTwoColor = Colors.lightBlue,
      this.dotThreeColor = Colors.orange,
      this.dotFourColor = Colors.green,
      this.dotFiveColor = Colors.yellow,
      this.dotSixColor = Colors.blue,
      this.dotSevenColor = Colors.pink,
      this.dotEightColor = Colors.lightGreen,
      this.centralDotRadius = 15.0,
      this.spanRadius = 15.0,
      this.duration = const Duration(seconds: 2),
      this.outerDotRadius = 5.0});

  @override
  _LoaderTwoState createState() => _LoaderTwoState(centralDotRadius);
}

class _LoaderTwoState extends State<LoaderTwo>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animationRotation;
  late Animation<double> animationRadiusIn;
  late Animation<double> animationRadiusOut;

  final double initialRadius;
  double radius = 0.0;

  _LoaderTwoState(this.initialRadius);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: widget.duration);

    animationRadiusIn =
        Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.75, 1.0, curve: Curves.elasticIn),
    ));
    animationRadiusOut =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.25, curve: Curves.elasticOut),
    ));
    animationRotation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 1.0, curve: Curves.linear)));

    controller.addListener(() {
      if (controller.value >= 0.75 && controller.value <= 1.0) {
        setState(() {
          radius = animationRadiusIn.value * initialRadius;
        });
      } else if (controller.value >= 0.0 && controller.value <= 0.25) {
        setState(() {
          radius = animationRadiusOut.value * initialRadius;
        });
      }
    });

    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      width: 100.0,
      child: RotationTransition(
        turns: animationRotation,
        child: Stack(
          children: <Widget>[
            Dot(
              radius: widget.centralDotRadius,
              color: widget.centralDotColor,
            ),
            Transform.translate(
                offset: Offset(cos(pi / 4) * radius, sin(pi / 4) * radius),
                child: Dot(
                  radius: widget.outerDotRadius,
                  color: widget.dotOneColor,
                )),
            Transform.translate(
                offset:
                    Offset(cos(2 * pi / 4) * radius, sin(2 * pi / 4) * radius),
                child: Dot(
                  radius: widget.outerDotRadius,
                  color: widget.dotTwoColor,
                )),
            Transform.translate(
                offset:
                    Offset(cos(3 * pi / 4) * radius, sin(3 * pi / 4) * radius),
                child: Dot(
                  radius: widget.outerDotRadius,
                  color: widget.dotThreeColor,
                )),
            Transform.translate(
                offset: Offset(cos(pi) * radius, sin(pi) * radius),
                child: Dot(
                  radius: widget.outerDotRadius,
                  color: widget.dotFourColor,
                )),
            Transform.translate(
                offset:
                    Offset(cos(5 * pi / 4) * radius, sin(5 * pi / 4) * radius),
                child: Dot(
                  radius: widget.outerDotRadius,
                  color: widget.dotFiveColor,
                )),
            Transform.translate(
                offset:
                    Offset(cos(6 * pi / 4) * radius, sin(6 * pi / 4) * radius),
                child: Dot(
                  radius: widget.outerDotRadius,
                  color: widget.dotSixColor,
                )),
            Transform.translate(
                offset:
                    Offset(cos(7 * pi / 4) * radius, sin(7 * pi / 4) * radius),
                child: Dot(
                  radius: widget.outerDotRadius,
                  color: widget.dotSevenColor,
                )),
            Transform.translate(
                offset:
                    Offset(cos(8 * pi / 4) * radius, sin(8 * pi / 4) * radius),
                child: Dot(
                  radius: widget.outerDotRadius,
                  color: widget.dotEightColor,
                )),
          ],
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final double? radius;
  final Color? color;

  const Dot({super.key, this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
