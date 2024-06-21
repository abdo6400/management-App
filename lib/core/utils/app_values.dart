import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppValues {
  static double screenHeight = ScreenUtil().screenHeight;
  static double screenWidth = ScreenUtil().screenWidth;

  static double marginHeight = 1.h; 
  static double paddingHeight = 1.h;
  static double sizeHeight = 1.h;
  static double marginWidth = 1.w;
  static double paddingWidth = 1.w;
  static double sizeWidth = 1.w;
  static double font = 1.sp;
  static double radius = 1.r;


  static Size getPlatformSize(){
     if (kIsWeb) {
    return Size(1024, 768); // Typical web design size
  } else if (Platform.isAndroid) {
    return Size(360, 640); // Typical Android design size (e.g., mdpi)
  } else if (Platform.isIOS) {
    return Size(375, 812); // Typical iPhone design size (e.g., iPhone X)
  } else if (Platform.isMacOS) {
    return Size(1440, 900); // Typical macOS design size (e.g., MacBook Air)
  } else if (Platform.isWindows) {
    return Size(1366, 768); // Typical Windows design size (e.g., common laptop)
  } else if (Platform.isLinux) {
    return Size(1366, 768); // Typical Linux design size (e.g., common laptop)
  } else {
    return Size.zero; // Default case
  }
    
  }
}
