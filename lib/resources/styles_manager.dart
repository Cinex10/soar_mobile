import 'package:flutter/material.dart';
import 'package:soar_mobile/resources/color_manager.dart';

const FontWeight thin = FontWeight.w100;
const FontWeight extraLight = FontWeight.w200;
const FontWeight light = FontWeight.w300;
const FontWeight regular = FontWeight.w400;
const FontWeight medium = FontWeight.w500;
const FontWeight semiBold = FontWeight.w600;
const FontWeight bold = FontWeight.w700;
const FontWeight extraBold = FontWeight.w800;
const FontWeight black = FontWeight.w900;

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) =>
    TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );

// Thin style
TextStyle getThinStyle({
  double fontSize = 12.0,
  Color color = ColorManager.black,
}) =>
    _getTextStyle(
      fontSize,
      thin,
      color,
    );

// ExtraLight style
TextStyle getExtraLightStyle({
  double fontSize = 12.0,
  Color color = ColorManager.black,
}) =>
    _getTextStyle(
      fontSize,
      extraLight,
      color,
    );

// Light style
TextStyle getLightStyle({
  double fontSize = 12.0,
  Color color = ColorManager.black,
}) =>
    _getTextStyle(
      fontSize,
      light,
      color,
    );

// Regular style
TextStyle getRegularStyle({
  double fontSize = 12.0,
  Color color = ColorManager.black,
}) =>
    _getTextStyle(
      fontSize,
      regular,
      color,
    );

// Medium style
TextStyle getMediumStyle({
  double fontSize = 12.0,
  Color color = ColorManager.black,
}) =>
    _getTextStyle(
      fontSize,
      medium,
      color,
    );

// SemiBold style
TextStyle getSemiBoldStyle({
  double fontSize = 12.0,
  Color color = ColorManager.black,
}) =>
    _getTextStyle(
      fontSize,
      semiBold,
      color,
    );

// Bold style
TextStyle getBoldStyle({
  double fontSize = 12.0,
  Color color = ColorManager.black,
}) =>
    _getTextStyle(
      fontSize,
      bold,
      color,
    );

// ExtraBold style
TextStyle getExtraBoldStyle({
  double fontSize = 12.0,
  Color color = ColorManager.black,
}) =>
    _getTextStyle(
      fontSize,
      extraBold,
      color,
    );

// Black style
TextStyle getBlackStyle({
  double fontSize = 12.0,
  Color color = ColorManager.black,
}) =>
    _getTextStyle(
      fontSize,
      black,
      color,
    );

TextStyle subtitleStyle = getRegularStyle(
  fontSize: 12,
  color: ColorManager.subtitleColor,
).copyWith(fontFamily: 'Poppins');
