import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/size_config.dart';
import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import 'package:audifie_version_1/core/widgets/loading_widget.dart';
import '../../../../core/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'components/change_password_dialog.dart';

class ChangePasswordPage extends StatefulWidget {
  static const String routeName = '/change_password_page';

  const ChangePasswordPage({Key? key});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  static const String _changePassword = "Change your password";
  static const String _oldPassword = "Old  Password";
  static const String _newPassword = "New  Password";
  static const String _confirmPassword = "Confirm Password";
  static const String _save = "SAVE";

  static const double _horizontalPadding = 34;

  static SizeConfig sc = sl<SizeConfig>();

  final TextEditingController _oldController = TextEditingController();
  final TextEditingController _newController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _isOldFieldEmpty = false;
  bool _isNewFieldEmpty = false;
  bool _isConfirmFieldEmpty = false;

  @override
  void dispose() {
    _oldController.dispose();
    _newController.dispose();
    _confirmController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // TODO: Uncomment under line
        // return !isLoading;
        return true;
      },
      child: Scaffold(
        appBar: IndependentAppBar(context: context),
        backgroundColor: Palette.bg,
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  // SizedBox(height: sc.height(51)),
                  // IndependentAppBarWidget(),
                  SizedBox(height: sc.height(41)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: sc.width(_horizontalPadding)),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _changePassword,
                        style: TStyle(
                                color: Palette.primaryText, size: sc.text(20))
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(height: sc.height(93)),
                  // Old Password
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: sc.width(_horizontalPadding)),
                    child: CustomTextFields(
                      errorText:
                          _isOldFieldEmpty ? Strings.fieldCantEmpty : null,
                      controller: _oldController,
                      labelText: _oldPassword,
                      onChange: (oldPassword) {},
                      isObscure: true,
                    ),
                  ),
                  SizedBox(height: sc.height(32)),
                  // New Password
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: sc.width(_horizontalPadding)),
                    child: CustomTextFields(
                      errorText:
                          _isNewFieldEmpty ? Strings.fieldCantEmpty : null,
                      controller: _newController,
                      labelText: _newPassword,
                      onChange: (newPassword) {},
                      isObscure: true,
                    ),
                  ),
                  SizedBox(height: sc.height(32)),
                  // Confirm Password
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: sc.width(_horizontalPadding)),
                    child: CustomTextFields(
                      errorText:
                          _isConfirmFieldEmpty ? Strings.fieldCantEmpty : null,
                      controller: _confirmController,
                      labelText: _confirmPassword,
                      onChange: (confirmPassword) {},
                      isObscure: true,
                    ),
                  ),
                  SizedBox(height: sc.height(88)),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isOldFieldEmpty =
                            _isNewFieldEmpty = _isConfirmFieldEmpty = false;
                        if (_oldController.text.trim().isEmpty) {
                          _isOldFieldEmpty = true;
                        }
                        if (_newController.text.trim().isEmpty) {
                          _isNewFieldEmpty = true;
                        }
                        if (_confirmController.text.trim().isEmpty) {
                          _isConfirmFieldEmpty = true;
                        }
                      });

                      if (!_isOldFieldEmpty &&
                          !_isNewFieldEmpty &&
                          !_isConfirmFieldEmpty) {
                        final String oldPassword = _oldController.text;
                        final String newPassword = _newController.text;
                        final String confirmPassword = _confirmController.text;
                        showDialog(
                          context: context,
                          builder: (_) {
                            return WillPopScope(
                              onWillPop: () async {
                                return false;
                              },
                              child: ChangePasswordDialog(
                                context: context,
                                onPressed: () {
                                  // TODO: Change password
                                },
                              ),
                            );
                          },
                        );
                      }

                      _oldController.clear();
                      _newController.clear();
                      _confirmController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Palette.primaryText,
                      padding: EdgeInsets.symmetric(
                          horizontal: sc.width(34), vertical: sc.height(14)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(sc.height(100))),
                    ),
                    child: Text(
                      _save,
                      style: TStyle(
                        color: Colors.black,
                        size: sc.text(14),
                      ).copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            // TODO: Uncomment under line
            // isLoading ? LoadingWidget() : AbsorbPointer(),
          ],
        ),
      ),
    );
  }
}
