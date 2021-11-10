import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/core/size_config.dart';
import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import 'package:audifie_version_1/core/widgets/loading_widget.dart';
import 'package:audifie_version_1/features/authentication/domain/entities/sign_up_info.dart';
import 'package:audifie_version_1/features/authentication/presenter/notifiers/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';


class SignUpPage extends StatefulWidget {
  final void Function() toggleView;
  const SignUpPage({required this.toggleView, Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  static const _name = "Name";
  static const _email = "Email";
  static const _password = "Password";
  static const _confirmPass = "Confirm Password";
  static const _signIn = "Sign In";
  static const _orSignIn = "or Sign In with";
  static const _google = "Google";
  static const _facebook = "Facebook";
  static const _alreadyAcc = "Already have an account? ";
  static const _signUp = "Sign Up";

  static final SizeConfig sc = sl<SizeConfig>();

  bool _isNameEmpty = false;
  bool _isEmailEmpty = false;
  bool _isPasswordEmpty = false;
  bool _isConfirmPasswordEmpty = false;

  bool _isSignInPressed = false;

  final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthNotifier authNotifier = context.watch<AuthNotifier>();

    return Scaffold(
      backgroundColor: Palette.bg,
      body: SingleChildScrollView(
        child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sc.width(45)),
                  child: Column(
                    children: [
                      SizedBox(height: sc.height(76)),
                      SvgPicture.asset(Strings.audifieTextIcon,
                          width: sc.width(143), height: sc.height(32)),
                      SizedBox(height: sc.height(52)),
                      // Name Text field
                      CustomTextFields(
                        errorText: _isNameEmpty ? Strings.nameCantEmpty : null,
                        controller: _nameController,
                        labelText: _name,
                        onChange: (email) {},
                      ),
                      SizedBox(height: sc.height(32)),
                      // Email Text field
                      CustomTextFields(
                        errorText:
                            _isEmailEmpty ? Strings.emailCantEmpty : null,
                        controller: _emailController,
                        labelText: _email,
                        onChange: (email) {},
                      ),
                      SizedBox(height: sc.height(32)),
                      // Password Text field
                      CustomTextFields(
                        errorText:
                            _isPasswordEmpty ? Strings.passwordCantEmpty : null,
                        controller: _passwordController,
                        labelText: _password,
                        onChange: (password) {},
                        isObscure: true,
                      ),
                      SizedBox(height: sc.height(32)),
                      // Confirm Password Text field
                      CustomTextFields(
                        errorText: _isConfirmPasswordEmpty
                            ? Strings.confirmPasswordCantEmpty
                            : null,
                        controller: _confirmPasswordController,
                        labelText: _confirmPass,
                        onChange: (password) {},
                        isObscure: true,
                      ),
                      SizedBox(height: sc.height(32)),
                      // Sign up Button
                      GestureDetector(
                        onTapDown: (d) {
                          setState(() {
                            _isSignInPressed = true;
                          });
                        },
                        onTapUp: (d) async {
                          setState(() {
                            _isSignInPressed = false;
                          });
                          if (_nameController.text.trim().isNotEmpty &&
                              _emailController.text.trim().isNotEmpty &&
                              _passwordController.text.trim().isNotEmpty &&
                              _confirmPasswordController.text
                                  .trim()
                                  .isNotEmpty) {
                            _isNameEmpty = _isEmailEmpty = _isPasswordEmpty =
                                _isConfirmPasswordEmpty = false;
                          } else {
                            _isNameEmpty = _isEmailEmpty = _isPasswordEmpty =
                                _isConfirmPasswordEmpty = false;
                            if (_nameController.text.trim().isEmpty) {
                              _isNameEmpty = true;
                            }
                            if (_emailController.text.trim().isEmpty) {
                              _isEmailEmpty = true;
                            }
                            if (_passwordController.text.trim().isEmpty) {
                              _isPasswordEmpty = true;
                            }
                            if (_confirmPasswordController.text.trim().isEmpty) {
                              _isConfirmPasswordEmpty = true;
                            }
                          }

                          if (!_isNameEmpty &&
                              !_isEmailEmpty &&
                              !_isPasswordEmpty &&
                              !_isConfirmPasswordEmpty) {
                            final String name = _nameController.text;
                            final String email = _emailController.text;
                            final String password = _passwordController.text;
                            final String confirmPassword =
                                _confirmPasswordController.text;
                            // TODO: Custom sign up
                            final SignUpInfo signUpInfo = SignUpInfo(
                              name: name,
                              email: email,
                              password: password,
                              configmPassword: confirmPassword,
                            );
                            // TODO: Sign up function
                            context.read<AuthNotifier>().sendOtpForSignUp(context, signUpInfo);
                          }

                          _passwordController.clear();
                          _confirmPasswordController.clear();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: sc.width(43),
                              vertical: sc.height(15)),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Palette.primary, width: sc.height(2)),
                            color: _isSignInPressed
                                ? Colors.transparent
                                : Palette.primary,
                            borderRadius: BorderRadius.circular(sc.height(100)),
                          ),
                          child: Text(
                            _signUp,
                            style: TStyle(
                              font: Strings.comfortaaFont,
                              color: Palette.btnText,
                              size: sc.text(16),
                              isBold: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: sc.height(52)),
                      // Sign in Text
                      Text(
                        _orSignIn,
                        style: TStyle(
                            color: Palette.secondaryText, size: sc.height(16)),
                      ),
                      SizedBox(height: sc.height(22)),
                      // Google and Facebook Sign in Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Google Button
                          ElevatedButton(
                            onPressed: () {
                              // TODO: Google sign up
                              context.read<AuthNotifier>().googleSignIn(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: sc.width(30),
                                vertical: sc.height(14),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(sc.height(100)),
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
                              // TODO: Facebook sign up
                              context.read<AuthNotifier>().facebookSignIn(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: sc.width(28),
                                vertical: sc.height(14),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(sc.height(100)),
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
                            _alreadyAcc,
                            style: TStyle(
                                color: Palette.secondaryText,
                                size: sc.text(16)),
                          ),
                          GestureDetector(
                            onTap: widget.toggleView,
                            child: Text(
                              _signIn,
                              style: TStyle(
                                      color: Palette.primary, size: sc.text(16))
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
                authNotifier.isLoading
                    ? LoadingWidget()
                    : AbsorbPointer(),
              ],
            )
      ),
    );
  }
}
