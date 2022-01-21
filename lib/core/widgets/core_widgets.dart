import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:flutter/services.dart';
import '../service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';

import '../size_config.dart';

// TextStyle
class TStyle extends TextStyle {
  final double size;
  final bool isBold;
  final String? font;
  const TStyle({
    Color color = Colors.black,
    this.size = 14,
    this.isBold = false,
    this.font,
  }) : super(
          fontFamily: font,
          color: color,
          fontSize: size,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        );
}

// Snackbar
class Snackbar extends SnackBar {
  final String? title;
  final String message;
  final Color? leftBarColor;
  final Function? onPressed;
  Snackbar({
    this.title,
    required this.message,
    this.leftBarColor,
    this.onPressed,
  }) : super(
          content: Text(
            message,
            style: TStyle(
              color: Palette.secondaryText,
              size: sl<SizeConfig>().text(16),
            ),
          ),
          backgroundColor: Palette.snackbarBg,
          duration: snackbarDuration,
        );
  // : super(
  //     title: title,
  //     backgroundColor: Palette.snackbarBg,
  //     leftBarIndicatorColor: leftBarColor ?? Palette.error,
  //     snackPosition: SnackPosition.BOTTOM,
  //     duration: const Duration(seconds: 4),
  //     // message: title,
  //     messageText: Text(
  //       message,
  // style: TStyle(
  //   color: Palette.secondaryText,
  //   size: sl<SizeConfig>().text(16),
  // ),
  //     ),
  //   );

  static const Duration snackbarDuration = const Duration(seconds: 2);
}

class CustomTextFields extends TextFormField {
  /// If errorText is not null then error in text field will be enabled
  final String? errorText;
  final TextEditingController controller;
  final String labelText;
  final bool isObscure;
  final Function(String) onChange;
  final bool isNumeric;

  static SizeConfig sc = sl<SizeConfig>();

  static OutlineInputBorder _border(Color color, SizeConfig sc) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(sc.height(100)),
      borderSide: BorderSide(color: color, width: sc.height(2)),
    );
  }

  CustomTextFields({
    required this.errorText,
    required this.controller,
    required this.labelText,
    this.isObscure = false,
    required this.onChange,
    this.isNumeric = false,
  }) : super(
          controller: controller,
          style: TStyle(color: Palette.primaryText, size: sc.text(16)),
          obscureText: isObscure,
          onChanged: onChange,
          cursorColor: Palette.primary,
          keyboardType: isNumeric ? TextInputType.number : null,
          decoration: InputDecoration(
            errorText: errorText,
            errorStyle: TStyle(color: Palette.error, size: sc.text(14)),
            contentPadding: EdgeInsets.symmetric(
                vertical: sc.height(16), horizontal: sc.width(40)),
            labelText: labelText,
            labelStyle:
                TStyle(color: Palette.textFieldLabel, size: sc.text(16)),
            border: _border(Palette.textFieldBorder, sc),
            errorBorder: _border(Palette.error, sc),
            enabledBorder: _border(Palette.textFieldBorder, sc),
            disabledBorder: _border(Palette.textFieldBorder, sc),
            focusedBorder: _border(Palette.textFieldFocusedBorder, sc),
            focusedErrorBorder: _border(Palette.error, sc),
          ),
        );
}

class IndependentAppBarWidget extends Padding {
  final BuildContext context;

  static SizeConfig sc = sl<SizeConfig>();

  IndependentAppBarWidget({required this.context})
      : super(
          padding: EdgeInsets.symmetric(horizontal: sc.width(16)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: sc.width(4)),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: sc.height(24),
                    color: Palette.primary,
                  ),
                ),
              ),
              Container(
                child: SvgPicture.asset(
                  Strings.audifieTextIcon,
                  width: sc.width(111),
                  height: sc.height(24),
                  color: Palette.primary,
                ),
              ),
              SizedBox(width: sc.width(32)),
            ],
          ),
        );
}

class BaseAppBar extends AppBar {
  final BuildContext context;

  static SizeConfig sc = sl<SizeConfig>();

  BaseAppBar({required this.context})
      : super(
          centerTitle: true,
          leading: SizedBox(),
          elevation: sc.height(0),
          toolbarHeight: sc.height(64),
          backgroundColor: Palette.bg,
          title: SvgPicture.asset(
            Strings.audifieTextIcon,
            width: sc.width(111),
            height: sc.height(24),
          ),
        );
}

class IndependentAppBar extends AppBar {
  final BuildContext context;

  static SizeConfig sc = sl<SizeConfig>();

  IndependentAppBar({required this.context})
      : super(
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: sc.width(4)),
              alignment: Alignment.center,
              child: Icon(
                Icons.arrow_back_ios_rounded,
                size: sc.height(24),
                color: Palette.primary,
              ),
            ),
          ),
          actions: [],
          elevation: sc.height(0),
          toolbarHeight: sc.height(64),
          backgroundColor: Palette.bg,
          title: SvgPicture.asset(
            Strings.audifieTextIcon,
            width: sc.width(111),
            height: sc.height(24),
          ),
        );
}
