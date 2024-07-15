import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_images.dart';
import '../components/input_card.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    // if (sl<CacheHelper>().getDataString(key: MySharedKeys.id.name) != null) {
    //   context.navigateAndFinish(screenRoute: Routes.homeRoute);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              AppImages.loginBackground,
              fit: BoxFit.fill,
              width: ScreenUtil().screenWidth,
              height: ScreenUtil().screenHeight,
            ),
            Align(alignment: Alignment.center, child:  InputCard()),
          ],
        ),
      ),
    );
  }
}
