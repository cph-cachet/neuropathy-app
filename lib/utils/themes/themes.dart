import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/utils/themes/colors.dart';

ThemeData appTheme = ThemeData(
  unselectedWidgetColor: AppColors.primaryBlue70,
  dividerColor: Colors.transparent,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: AppColors.primaryBlue),
    actionsIconTheme: IconThemeData(color: AppColors.primaryBlue),
    shadowColor: AppColors.primaryBlue,
    elevation: 0,
  ),
  textButtonTheme: TextButtonThemeData(style: _roundedButtonStyle),
  elevatedButtonTheme: ElevatedButtonThemeData(style: _roundedButtonStyle),
  outlinedButtonTheme: OutlinedButtonThemeData(style: _roundedButtonStyle),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    fillColor: MaterialStateProperty.all(AppColors.primaryBlue),
    checkColor: MaterialStateProperty.all(Colors.white),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(AppColors.primaryBlue),
  ),
  iconTheme: IconThemeData(color: AppColors.primaryBlue),
  primarySwatch: AppColors.primarySwatch,
  colorScheme: AppColors.colorScheme,
);

ButtonStyle _roundedButtonStyle = ButtonStyle(
    shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))));
