import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/size_config.dart';
import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import 'package:audifie_version_1/core/widgets/loading_widget.dart';
import 'package:audifie_version_1/features/authentication/domain/entities/sign_in_info.dart';
import 'package:audifie_version_1/features/authentication/presenter/notifiers/auth_notifier.dart';
import '../../../../core/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'components/forgor_password_email_dialog.dart';

class SignInPage extends StatefulWidget {
  final void Function() toggleView;
  const SignInPage({required this.toggleView, Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  static const _email = "Email";
  static const _password = "Password";
  static const _signIn = "Sign In";
  static const _forgotPass = "Forgot Password?";
  static const _orSignIn = "or Sign In with";
  static const _google = "Google";
  static const _facebook = "Facebook";
  static const _dontAcc = "Don't have an account? ";
  static const _signUp = "Sign Up";

  static final SizeConfig sc = sl<SizeConfig>();

  bool _isSignInPressed = false;

  bool _isEmailEmpty = false;
  bool _isPasswordEmpty = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, notifier, child) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: Palette.bg,
              body: SingleChildScrollView(
                child: child,
              ),
            ),
            notifier.isLoading ? LoadingWidget() : AbsorbPointer(),
          ],
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sc.width(45)),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: sc.height(140)),
              SvgPicture.asset(Strings.audifieTextIcon,
                  width: sc.width(143), height: sc.height(32)),
              SizedBox(height: sc.height(94)),
              // Email Text field
              CustomTextFields(
                errorText: _isEmailEmpty ? Strings.emailCantEmpty : null,
                controller: _emailController,
                labelText: _email,
                onChange: (email) {},
              ),
              SizedBox(height: sc.height(30)),
              // Password Text field
              CustomTextFields(
                errorText: _isPasswordEmpty ? Strings.passwordCantEmpty : null,
                controller: _passwordController,
                labelText: _password,
                onChange: (password) {},
                isObscure: true,
              ),
              SizedBox(height: sc.height(46)),
              // Sign in Button
              GestureDetector(
                onTapDown: (d) {
                  setState(() {
                    _isSignInPressed = true;
                  });
                },
                onTapUp: (d) async {
                  if (_emailController.text.trim().isNotEmpty &&
                      _passwordController.text.trim().isNotEmpty) {
                    _isEmailEmpty = _isPasswordEmpty = false;
                  } else {
                    _isEmailEmpty = _isPasswordEmpty = false;
                    if (_emailController.text.trim().isEmpty) {
                      _isEmailEmpty = true;
                    }
                    if (_passwordController.text.trim().isEmpty) {
                      _isPasswordEmpty = true;
                    }
                  }

                  setState(() {
                    _isSignInPressed = false;
                  });

                  if (!_isEmailEmpty && !_isPasswordEmpty) {
                    final String email = _emailController.text;
                    final String password = _passwordController.text;

                    final SignInInfo signInInfo = SignInInfo(
                      email: email,
                      password: password,
                    );
                    context.read<AuthNotifier>().signIn(context, signInInfo);
                  }

                  _passwordController.clear();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: sc.width(43), vertical: sc.height(15)),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Palette.primary, width: sc.height(2)),
                    color:
                        _isSignInPressed ? Colors.transparent : Palette.primary,
                    borderRadius: BorderRadius.circular(sc.height(100)),
                  ),
                  child: Text(
                    _signIn,
                    style: TStyle(
                      font: Strings.comfortaaFont,
                      color: Palette.btnText,
                      size: sc.text(16),
                      isBold: true,
                    ),
                  ),
                ),
              ),
              SizedBox(height: sc.height(30)),
              // Forgot password Button
              GestureDetector(
                onTap: () {
                  context.read<AuthNotifier>().forgotPassword(context);
                  // showDialog(
                  //   context: context,
                  //   builder: (context) {
                  //     return WillPopScope(
                  //       onWillPop: () async {
                  //         return false;
                  //       },
                  //       child: ForgotPasswordEmailDialog(
                  //         context: context,
                  //         onPressed: (email) {
                  //           // TODO: Forgot password
                  //         },
                  //       ),
                  //     );
                  //   },
                  // );
                },
                child: Text(
                  _forgotPass,
                  style: TStyle(color: Palette.secondaryText, size: sc.text(16))
                      .copyWith(decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(height: sc.height(65)),
              // Sign in Text
              Text(
                _orSignIn,
                style:
                    TStyle(color: Palette.secondaryText, size: sc.height(16)),
              ),
              SizedBox(height: sc.height(22)),
              // Google and Facebook Sign in Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Google Button
                  ElevatedButton(
                    onPressed: () {
                      // context.read<AuthNotifier>().googleSignIn(context);
                      context.read<AuthNotifier>().googleSignIn(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: sc.width(28),
                        vertical: sc.height(14),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(sc.height(100)),
                      ),
                      primary: Colors.white,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          Strings.googleIcon,
                          width: sc.width(20),
                          height: sc.height(20),
                        ),
                        SizedBox(width: sc.width(15)),
                        Text(
                          _google,
                          style: TStyle(
                            color: Colors.black,
                            size: sc.text(16),
                            isBold: true,
                          ),
                        )
                      ],
                    ),
                  ),
                  // Facebook Button
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Facebook sign in
                      context.read<AuthNotifier>().facebookSignIn(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: sc.width(24),
                        vertical: sc.height(14),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(sc.height(100)),
                      ),
                      primary: Color(0xff1877F2),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          Strings.facebookIcon,
                          width: sc.width(20),
                          height: sc.height(20),
                        ),
                        SizedBox(width: sc.width(15)),
                        Text(
                          _facebook,
                          style: TStyle(
                            color: Colors.white,
                            size: sc.text(16),
                            isBold: true,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: sc.height(47)),
              // Don't have an account button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _dontAcc,
                    style:
                        TStyle(color: Palette.secondaryText, size: sc.text(16)),
                  ),
                  GestureDetector(
                    onTap: widget.toggleView,
                    child: Text(
                      _signUp,
                      style: TStyle(color: Palette.primary, size: sc.text(16))
                          .copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: sc.height(40)),
            ],
          ),
        ),
      ),
    );
  }
}
