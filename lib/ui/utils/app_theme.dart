import 'package:flutter/material.dart';
import 'package:news_app/ui/utils/app_colors.dart';

abstract final class AppTheme{
  static ThemeData lightTheme=ThemeData(
    primaryColor: AppColor.white,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColor.white,primary: AppColor.white
    ,secondary: AppColor.black),
    scaffoldBackgroundColor: AppColor.white,
    textTheme: TextTheme(titleLarge: TextStyle(fontSize:24,fontWeight:FontWeight.w500 ,color: AppColor.white ),
    titleMedium: TextStyle(fontSize:20,fontWeight:FontWeight.w500 ,color: AppColor.black),
    bodyLarge:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: AppColor.black),
    bodyMedium:TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: AppColor.black),
    bodySmall: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: AppColor.black),
    labelLarge: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: AppColor.white),
    labelMedium: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: AppColor.gray),

    ),
      iconTheme: IconThemeData(size: 24,color: AppColor.black),
      appBarTheme: AppBarTheme(color: AppColor.white,
          centerTitle: true,titleTextStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: AppColor.black))
  );
  static ThemeData darkTheme=ThemeData(
    scaffoldBackgroundColor: AppColor.black,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColor.black,primary: AppColor.black,
    secondary: AppColor.white),
      textTheme: TextTheme(titleLarge: TextStyle(fontSize:20,fontWeight:FontWeight.w500),
        titleMedium: TextStyle(fontSize:20,fontWeight:FontWeight.w500 ,color: AppColor.white),
        bodyLarge:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: AppColor.black),
        bodyMedium:TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: AppColor.white),
        bodySmall: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: AppColor.white),
        labelLarge: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: AppColor.black),
        labelMedium: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: AppColor.gray),

      ),
      iconTheme: IconThemeData(size: 24,color: AppColor.black),
      appBarTheme: AppBarTheme(color: AppColor.black,centerTitle:
      true,titleTextStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: AppColor.white))
  );
}