import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/color_constants.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
}

ColorScheme _customColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: ColorConstants.instance.deepCerulean,
  onPrimary: ColorConstants.instance.alabaster,
  secondary: ColorConstants.instance.prussianBlue,
  //
  outline: ColorConstants.instance.sinbad,
  onSecondary: ColorConstants.instance.bermuda,
  error: ColorConstants.instance.red,
  onError: ColorConstants.instance.brickRed,
  background: ColorConstants.instance.kDarkGrey,
  onBackground: ColorConstants.instance.prussianBlue,
  surface: ColorConstants.instance.deepCerulean,
  onSurface: ColorConstants.instance.chathamsBlue,
  tertiary: ColorConstants.instance.mineShaft,
);

class MyThemes {
  static final lightTheme = ThemeData(
    //backgroundColor: ColorConstants.instance.kDarkGrey,
    scaffoldBackgroundColor: _customColorScheme.background,
    primaryColor: _customColorScheme.primary,
    focusColor: _customColorScheme.secondary,
    colorScheme: _customColorScheme,
    canvasColor: ColorConstants.instance.kDarkGrey,
    unselectedWidgetColor: ColorConstants.instance.kDarkGrey,
    bottomSheetTheme: BottomSheetThemeData(
      constraints: BoxConstraints(
        maxHeight: 500.h,
      ),
    ),
    iconTheme: IconThemeData(color: ColorConstants.instance.black, opacity: 0.8),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 20.sp,
        color: ColorConstants.instance.black,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontSize: 20.sp,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        fontSize: 18.sp,
        color: ColorConstants.instance.black,
        fontWeight: FontWeight.w600, //SemiBold
      ),
      bodyLarge: TextStyle(
        fontSize: 18.sp,
        color: Colors.white,
        fontWeight: FontWeight.w600, //Semibold
      ),
      bodyMedium: TextStyle(
        fontSize: 16.sp,
        color: ColorConstants.instance.black,
        fontWeight: FontWeight.w500, //Medium
      ),
      bodySmall: TextStyle(
        fontSize: 16.sp,
        color: Colors.white,
        fontWeight: FontWeight.w500, //Medium
      ),
      titleMedium: TextStyle(
        fontSize: 14.sp,
        color: ColorConstants.instance.black,
        fontWeight: FontWeight.w900, //HEavy
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        color: Colors.white,
        fontWeight: FontWeight.w900, //HEavy
      ),
    ),
  );

  static final darkTheme = ThemeData(
    //backgroundColor: _customColorScheme.background,
    scaffoldBackgroundColor: ColorConstants.instance.prussianBlue, //_customColorScheme.background,
    primaryColor: ColorConstants.instance.deepCerulean, //_customColorScheme.primary,
    focusColor: _customColorScheme.secondary,
    colorScheme: _customColorScheme,
    canvasColor: ColorConstants.instance.kDarkGrey,
    unselectedWidgetColor: ColorConstants.instance.kDarkGrey,
    bottomSheetTheme: BottomSheetThemeData(
      constraints: BoxConstraints(
        maxHeight: 500.h,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.red, opacity: 0.8),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 20.sp,
        color: ColorConstants.instance.black,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontSize: 20.sp,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        fontSize: 18.sp,
        color: ColorConstants.instance.black,
        fontWeight: FontWeight.w600, //SemiBold
      ),
      bodyLarge: TextStyle(
        fontSize: 18.sp,
        color: Colors.white,
        fontWeight: FontWeight.w600, //Semibold
      ),
      bodyMedium: TextStyle(
        fontSize: 16.sp,
        color: ColorConstants.instance.black,
        fontWeight: FontWeight.w500, //Medium
      ),
      bodySmall: TextStyle(
        fontSize: 16.sp,
        color: Colors.white,
        fontWeight: FontWeight.w500, //Medium
      ),
      titleMedium: TextStyle(
        fontSize: 14.sp,
        color: ColorConstants.instance.black,
        fontWeight: FontWeight.w900, //HEavy
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        color: Colors.white,
        fontWeight: FontWeight.w900, //HEavy
      ),
    ),
  );
}
