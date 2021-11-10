import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/size_config.dart';
import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import '../../../../../core/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChangePasswordDialog extends Dialog {
  static const String _yes = "YES";
  static const String _cancel = "CANCEL";
  static const String _sureChangePassword =
      "Are you sure you want to change password?";

  static SizeConfig sc = sl<SizeConfig>();

  final Function() onPressed;
  final BuildContext context;

  ChangePasswordDialog({required this.context, required this.onPressed})
      : super(
          backgroundColor: Palette.bottomNavBar,
          elevation: 0,
          insetPadding: EdgeInsets.symmetric(horizontal: sc.width(31)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(sc.height(15))),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: sc.width(75), vertical: sc.height(40)),
            decoration: BoxDecoration(
              color: Palette.bottomNavBar,
              borderRadius: BorderRadius.circular(sc.height(15)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  Strings.passwordIcon,
                  width: sc.width(25),
                  height: sc.height(28),
                  color: Palette.secondaryText,
                ),
                SizedBox(height: sc.height(32)),
                Text(
                  _sureChangePassword,
                  style: TStyle(
                    color: Palette.secondaryText,
                    size: sc.text(18),
                  ).copyWith(height: sc.height(2.1)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: sc.height(51)),
                Row(
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
                    Spacer(),
                    // YES Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onPressed();
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
                        _yes,
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
