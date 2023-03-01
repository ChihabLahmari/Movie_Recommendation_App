import 'package:flutter/material.dart';
import 'package:movies_clean_architecture_mvvm/presentation/resources/styles_manager.dart';
import 'package:movies_clean_architecture_mvvm/presentation/resources/values_manager.dart';

import 'color_manager.dart';
import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // material 3
    useMaterial3: false,

    // main colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.white,
    primaryColorDark: ColorManager.primary,
    disabledColor: ColorManager.grey,
    splashColor: ColorManager
        .white, // ripple effect color (when i click and hold on a button)

    // cradview theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

    // appbar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.white,
      titleTextStyle: getRegulerStyle(
        color: ColorManager.white,
        fontSize: FontSize.s16,
      ),
    ),

    // bottom theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.white,
    ),

    // elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle:
            getRegulerStyle(color: ColorManager.white, fontSize: FontSize.s17),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),

    // 🛑 2018-2021 error
    //  2018 text theme don't use this :
    //     NAME         SIZE  WEIGHT  SPACING
    // headline1    96.0  light   -1.5
    // headline2    60.0  light   -0.5
    // headline3    48.0  regular  0.0
    // headline4    34.0  regular  0.25
    // headline5    24.0  regular  0.0
    // headline6    20.0  medium   0.15
    // subtitle1    16.0  regular  0.15
    // subtitle2    14.0  medium   0.1
    // body1        16.0  regular  0.5   (bodyText1)
    // body2        14.0  regular  0.25  (bodyText2)
    // button       14.0  medium   1.25
    // caption      12.0  regular  0.4
    // overline     10.0  regular  1.5

    // text theme
    textTheme: TextTheme(
      displayLarge: getSemiBoldStyle(
          color: ColorManager.darkGrey, fontSize: FontSize.s16),
      headlineLarge: getSemiBoldStyle(
          color: ColorManager.darkGrey, fontSize: FontSize.s16),
      headlineMedium:
          getRegulerStyle(color: ColorManager.darkGrey, fontSize: FontSize.s14),
      titleMedium:
          getMeduimStyle(color: ColorManager.primary, fontSize: FontSize.s16),
      titleSmall:
          getRegulerStyle(color: ColorManager.white, fontSize: FontSize.s16),
      labelSmall:
          getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s14),
      bodyLarge: getRegulerStyle(color: ColorManager.grey),
      bodySmall: getRegulerStyle(color: ColorManager.grey),
      bodyMedium:
          getRegulerStyle(color: ColorManager.darkGrey, fontSize: FontSize.s12),
    ),

    // input decoration theme ( text form field )
    inputDecorationTheme: InputDecorationTheme(
      // content padding
      contentPadding: const EdgeInsets.all(AppPadding.p8),

      // hint style
      hintStyle:
          getRegulerStyle(color: ColorManager.grey, fontSize: FontSize.s14),

      // labes style
      labelStyle:
          getMeduimStyle(color: ColorManager.grey, fontSize: FontSize.s14),

      // error style
      errorStyle:
          getRegulerStyle(color: ColorManager.red, fontSize: FontSize.s14),

      // enabled border style
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

      // focused border
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

      // error border style
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.red, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

      // focused error border
      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
    ),
  );
}
