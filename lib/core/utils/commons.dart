import 'dart:io';

import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http_parser/http_parser.dart';
import '../../app/service_locator.dart';
import '../../config/database/cache/cache_consumer.dart';
import '../../config/database/error/exceptions.dart';
import '../components/default_components/default_button.dart';
import '../components/default_components/default_dialogs.dart';
import 'app_colors.dart';
import 'app_enums.dart';
import 'app_strings.dart';
import 'app_values.dart';

//open url
Future<void> openUrl(String urlLink) async {
  final Uri url = Uri.parse(urlLink);
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}

// compare date with another date.
extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

//close keyboard when finished user typing.
extension CloseKeyboard on BuildContext {
  void closeKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(this);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}

// convert image to be uploaded to API.
Future multipartConvertImage({
  required XFile image,
}) async {
  return MultipartFile.fromFileSync(image.path,
      contentType: MediaType('image', 'jpeg'),
      filename: image.path.split('/').last);
}

//* Image Picker
//pick image from user either from camera or from gallery.
Future<XFile?> pickImage(ImageSource source) async {
  XFile? image = await ImagePicker().pickImage(
      source: source, maxHeight: 1024, maxWidth: 1024, imageQuality: 50);
  if (image != null) {
    return image;
  } else {
    return null;
  }
}

Future<XFile?> pickvideo(ImageSource source) async {
  XFile? image = await ImagePicker()
      .pickVideo(source: source, maxDuration: const Duration(minutes: 2));
  if (image != null) {
    return image;
  } else {
    return null;
  }
}

// show Picke Image Dialog
extension ShowPickeImageDialog on BuildContext {
  Future<XFile?> showPickeImageDialog() async {
    XFile? image;
    await showDialog(
        context: this,
        builder: ((context) => ImagePickerDialog(
              cameraOnTap: () async {
                image = await pickImage(ImageSource.camera);
                Navigator.pop(this, true);
              },
              galleryOnTap: () async {
                image = await pickImage(ImageSource.gallery);
                Navigator.pop(this, true);
              },
            )));
    return image;
  }
}

// show Picke video Dialog
extension ShowPickeVideoDialog on BuildContext {
  Future<XFile?> showPickeVideoDialog() async {
    XFile? video;
    await showDialog(
        context: this,
        builder: ((context) => ImagePickerDialog(
              cameraOnTap: () async {
                video = await pickvideo(ImageSource.camera);
                Navigator.pop(this, true);
              },
              galleryOnTap: () async {
                video = await pickvideo(ImageSource.gallery);
                Navigator.pop(this, true);
              },
            )));
    return video;
  }
}

extension NavigateTo on BuildContext {
  void navigateTo({
    required String screenRoute,
    dynamic arg,
  }) {
    Navigator.of(this, rootNavigator: true)
        .pushNamed(screenRoute, arguments: arg);
  }
} 

extension NavigateAndFinish on BuildContext {
  void navigateAndFinish({
    required String screenRoute,
    dynamic arg,
  }) {
    Navigator.of(this, rootNavigator: true)
        .pushReplacementNamed(screenRoute, arguments: arg);
  }
}

extension NavigateAndFinishAll on BuildContext {
  void navigateAndFinishAll({
    required String screenRoute,
    dynamic arg,
  }) {
    Navigator.of(this, rootNavigator: true)
        .pushNamedAndRemoveUntil(screenRoute, (value) => false, arguments: arg);
  }
}

//* Loaders
extension ShowLoader on BuildContext {
  void showLoader({String? message}) {
    Loader.show(this,
        progressIndicator: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.transparent,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballRotate,
                  colors: [
                    AppColors.white,
                    AppColors.primary,
                    AppColors.white,
                    AppColors.primary,
                  ],
                  strokeWidth: 2,
                  backgroundColor: Colors.transparent,
                  pathBackgroundColor: Colors.transparent,
                ),
              ),
              if (message != null) Text(message.tr(this))
            ],
          ),
        ));
  }
}

extension HideLoader on BuildContext {
  void hideLoader() {
    if (Loader.isShown) {
      Loader.hide();
    }
  }
}

extension ShowSuccessDialogToast on BuildContext {
  Future<void> showSuccessDialogToast(
      {String? message,
      String? title,
      dynamic Function()? function,
      required Duration duration,
      String? icon}) async {
    await showDialog(
        context: this,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (BuildContext context) => PopScope(
              canPop: false,
              child: CustomAlertDialog(
                  icon: icon != null
                      ? Lottie.asset(icon, height: AppValues.sizeHeight * 120)
                      : null,
                  title: title,
                  content: message,
                  type: AlertDialogType.success),
            )).timeout(duration, onTimeout: () => Navigator.pop(this, true));
  }
}

extension ShowInfoDialog on BuildContext {
  void showInfoDialog(String message, AlertDialogType type,
      {dynamic Function()? function}) async {
    showDialog(
        context: this,
        builder: (BuildContext context) => CustomAlertDialog(
            content: message,
            buttonLabel: AppStrings.cancel,
            type: type,
            function: function));
  }
}

extension ShowMultiSelect on BuildContext {
  void showMultiSelect({
    required List<String> items,
    required Function function,
  }) async {
    List<Widget> buildPositionChips() {
      List<Widget> chips = [];
      for (int index = 0; index < items.length; index++) {
        chips.add(
          GestureDetector(
            onTap: () {
              Navigator.of(this).pop(true);
              function(items[index], index);
            },
            child: Chip(
                label: Text(items[index].tr(this)),
                backgroundColor: AppColors.blueLight,
                labelStyle: Theme.of(this)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: AppColors.white)),
          ),
        );
      }

      return chips;
    }

    showDialog(
        context: this,
        barrierColor: AppColors.blueDarK.withOpacity(0.5),
        builder: ((context) {
          return Container(
              height: AppValues.screenHeight / 2,
              padding: EdgeInsets.symmetric(
                  vertical: AppValues.paddingHeight * 16,
                  horizontal: AppValues.paddingWidth * 16),
              margin: EdgeInsets.symmetric(
                  vertical: AppValues.marginHeight * 190,
                  horizontal: AppValues.marginWidth * 16),
              child: Wrap(
                spacing: AppValues.radius * 20,
                runSpacing: AppValues.radius * 12,
                children: buildPositionChips(),
              ));
        }));
  }
}

extension ShowToastMsg on BuildContext {
  Future<void> showToastMsg(
      {required String msg, required ToastStates toastState}) async {
    Color color, textColor;
    switch (toastState) {
      case ToastStates.success:
        color = AppColors.primary;
        textColor = AppColors.white;
        break;
      case ToastStates.warning:
        color = AppColors.white;
        textColor = AppColors.blueDarK;
        break;
      case ToastStates.error:
        color = Colors.red;
        textColor = AppColors.white;
        break;
    }
    await Fluttertoast.showToast(
      msg: AppLocalizations.of(this)!.translate(msg) ?? msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: color,
      textColor: textColor,
      fontSize: AppValues.font * 16,
    );
  }
}

extension ShowBottomSheet on BuildContext {
  void showBottomSheet({
    required String buttonLabel,
    required Widget child,
    required double maxHeight,
    required bool isDismissible,
    required Function function,
  }) {
    showModalBottomSheet(
      context: this,
      barrierColor: AppColors.blueLight.withOpacity(0.69),
      useSafeArea: true,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.only(
            //  topLeft: Radius.circular(AppSize.s60.r),
            // topRight: Radius.circular(AppSize.s60.r),
            ),
      ),
      backgroundColor: AppColors.white,
      isScrollControlled: true,
      constraints: BoxConstraints(
          maxHeight: maxHeight,
          maxWidth: double.infinity,
          minWidth: double.infinity),
      builder: (BuildContext context) {
        return Column(
          children: [
            const SizedBox(
                // height: AppSize.s24.h,
                ),
            Container(
              alignment: Alignment.topCenter,
              //    width: AppSize.s90.w,
              //   height: AppSize.s4.h,
              decoration: const BoxDecoration(
                color: AppColors.blueDarK,
                //    borderRadius: BorderRadius.circular(AppSize.s12.r)
              ),
            ),
            const SizedBox(
                // height: AppSize.s24.h,
                ),
            child,
            const SizedBox(
                //  height: AppSize.s20.h,
                ),
            DefaultButton(
              // height: AppSize.s60.h,
              // fontSize: AppSize.s24.sp,
              //   margin: EdgeInsets.symmetric(horizontal: (AppMargin.m20 * 4).w),
              onPressed: () {
                Navigator.of(context).pop(true);
                function();
              },
              text: buttonLabel,
            ),
            const SizedBox(
                //    height: AppSize.s20.h,
                ),
          ],
        );
      },
    );
  }
}

void showLoginDialog(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (BuildContext context) => CustomAlertDialog(
            title: message,
            content: message,
            buttonLabel: AppStrings.ok.tr(context),
            function: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            type: AlertDialogType.success,
          ));
}

Future<void> showLogoutDialog(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) => ConfirmationDialog(
          alertMsg: 'Logout',
          onTapConfirm: () {
            sl<CacheConsumer>().clearData();
            // showToastMsg(msg: 'LogOut', toastState: ToastStates.success);
            // context.navigateAndFinish(screenRoute: screenRoute)
          }));
}

Future<XFile> downloadAndSaveImage(String imageUrl) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/$imageUrl.jpg';
  await sl<Dio>().download(imageUrl, filePath);
  return XFile(filePath);
}

//save token to cache
Future<void> saveTokenToCache(String token) async {
  await sl<CacheConsumer>()
      .saveData(key: MySharedKeys.apiToken.name, value: token);
}

Future<Either<CacheException, String>> saveToken(String token) async {
  try {
    await saveTokenToCache(token);
    return const Right('Done');
  } catch (e) {
    return Left(CacheException(message: e.toString()));
  }
}
