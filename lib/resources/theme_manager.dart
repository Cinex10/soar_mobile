import 'package:flutter/material.dart';
import 'package:soar_mobile/resources/color_manager.dart';
import 'package:soar_mobile/resources/styles_manager.dart';

ThemeData getApplicationTheme() => ThemeData(
      useMaterial3: true,
      //appbar theme
      fontFamily: 'Poppins',
      appBarTheme: AppBarTheme(
        surfaceTintColor: ColorManager.white,
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorManager.white,
        iconTheme: const IconThemeData(
          color: ColorManager.black,
        ),
        shadowColor: ColorManager.lightGrey,
        titleTextStyle: getSemiBoldStyle(
          fontSize: 17,
          color: ColorManager.black,
        ).copyWith(
          fontFamily: 'Poppins',
        ),
      ),

      //bottom navbar theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorManager.white,
        selectedItemColor: ColorManager.primary,
        selectedLabelStyle: getMediumStyle(
          fontSize: 13.0,
          color: ColorManager.primary,
        ),
        unselectedItemColor: ColorManager.black,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primary,
          disabledBackgroundColor: ColorManager.lightGrey,
          textStyle: getBoldStyle(
            color: ColorManager.white,
            fontSize: 16.0,
          ),
        ),
      ),
      buttonTheme: const ButtonThemeData(
        //  overlayColor:  ColorManager.red,
        splashColor: ColorManager.lightGrey,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(

            // splashColor: ColorManager.lightGrey,

            ),
      ),
      sliderTheme: SliderThemeData(
        overlayColor: ColorManager.black.withOpacity(0.2),
        activeTrackColor: ColorManager.black,
        activeTickMarkColor: ColorManager.black,
        thumbColor: ColorManager.black,
        inactiveTrackColor: const Color(0xFFDAD8D9),
      ),
      //input decoration theme
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: ColorManager.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black54,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black54,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorManager.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        prefixIconColor: ColorManager.black,
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFFDAD8D9),
        space: 1.5,
      ),

      switchTheme: const SwitchThemeData(
        trackColor: MaterialStatePropertyAll(ColorManager.lightGrey),
      ),
      scaffoldBackgroundColor: ColorManager.white,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: ColorManager.black,
        primary: ColorManager.primary,
      ),
    );
