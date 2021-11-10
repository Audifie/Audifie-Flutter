import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/size_config.dart';
import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import '../../../../../core/service_locator.dart';
import 'package:flutter/material.dart';

class ForgotPasswordEmailDialog extends Dialog {
  static const String _submit = "SUBMIT";
  static const String _cancel = "CANCEL";
  static const String _enterEmail = "Enter email";
  static const String _email = "Email";

  static const double _horizontalPadding = 34;

  static SizeConfig sc = sl<SizeConfig>();

  static final TextEditingController _emailController = TextEditingController();

  final BuildContext context;
  final Function(String email) onPressed;

  ForgotPasswordEmailDialog({required this.context, required this.onPressed})
      : super(
          backgroundColor: Palette.bottomNavBar,
          elevation: 0,
          insetPadding: EdgeInsets.symmetric(horizontal: sc.width(31)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(sc.height(15))),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: sc.width(_horizontalPadding),
                vertical: sc.height(40)),
            decoration: BoxDecoration(
              color: Palette.bottomNavBar,
              borderRadius: BorderRadius.circular(sc.height(15)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _enterEmail,
                  style: TStyle(
                    color: Palette.secondaryText,
                    size: sc.text(18),
                  ).copyWith(height: sc.height(2.1)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: sc.height(32)),
                CustomTextFields(
                  errorText: null,
                  controller: _emailController,
                  labelText: _email,
                  onChange: (email) {},
                ),
                SizedBox(height: sc.height(51)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // CANCEL Button
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.black45,
                        overlayColor: MaterialStateProperty.all(Colors.black45),
                        borderRadius: BorderRadius.circular(sc.height(100)),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: sc.width(20),
                            vertical: sc.height(15),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(sc.height(100)),
                          ),
                          child: Text(
                            _cancel,
                            style: TStyle(
                              color: Palette.primaryText,
                              size: sc.text(14),
                            ).copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: sc.width(20)),
                    // YES Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onPressed(_emailController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Palette.primaryText,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(
                          horizontal: sc.width(35),
                          vertical: sc.height(15),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(sc.height(100))),
                      ),
                      child: Text(
                        _submit,
                        style: TStyle(
                          color: Colors.black,
                          size: sc.text(14),
                        ).copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
}
