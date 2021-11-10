import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/core/size_config.dart';
import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import 'package:audifie_version_1/core/widgets/loading_widget.dart';
import 'package:audifie_version_1/features/authentication/domain/entities/sign_up_info.dart';
import 'package:audifie_version_1/features/authentication/presenter/notifiers/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class OtpPage extends StatefulWidget {
  static const String routeName = '/otp_page';

  final SignUpInfo signUpInfo;
  const OtpPage({Key? key, required this.signUpInfo}) : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  static const _otpSent = "OTP has been sent to your Email";
  static const _enterOtp = "Enter OTP";
  static const _didntGot = "Didn’t got it? ";
  static const _resend = "Resend";
  static const _submit = "SUBMIT";

  final SizeConfig sc = sl<SizeConfig>();

  TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthNotifier authNotifier = context.watch<AuthNotifier>();

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Palette.bg,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sc.width(30)),
                child: Column(
                  children: [
                    SizedBox(height: sc.height(88)),
                    // Audifie Logo
                    SvgPicture.asset(Strings.audifieTextIcon,
                        width: sc.width(143), height: sc.height(32)),
                    SizedBox(height: sc.height(60)),
                    // Otp container
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xff1D1D1D),
                        borderRadius: BorderRadius.circular(sc.height(15)),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: sc.width(25), vertical: sc.height(37)),
                      child: Column(
                        children: [
                          Text(
                            _otpSent,
                            style: TStyle(
                                color: Palette.secondaryText,
                                size: sc.text(16)),
                          ),
                          SizedBox(height: sc.height(55)),
                          Text(
                            _enterOtp,
                            style: TStyle(
                                color: Palette.secondaryText,
                                size: sc.text(16)),
                          ),
                          SizedBox(height: sc.height(60)),
                          PinCodeTextField(
                            appContext: context,
                            length: 6,
                            onChanged: (n) {},
                            cursorColor: Palette.primary,
                            autoDismissKeyboard: true,
                            controller: _otpController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            textStyle: TStyle(
                              color: Palette.primaryText,
                              size: sc.text(20),
                              isBold: true,
                            ),
                            animationType: AnimationType.scale,
                            pinTheme: PinTheme.defaults(
                              borderWidth: sc.width(2),
                              fieldWidth: sc.width(35),
                              activeColor: Palette.primary,
                              disabledColor: Color(0xff707070),
                              inactiveColor: Color(0xff707070),
                              selectedColor: Color(0xff707070),
                            ),
                          ),
                          SizedBox(height: sc.height(56)),
                          // Submit button
                          ElevatedButton(
                            onPressed: () async {
                              final String otp = _otpController.text;
                              context.read<AuthNotifier>().verifyOtpAndSignUp(context, widget.signUpInfo, otp);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xffFEFEFE),
                              padding: EdgeInsets.symmetric(
                                  horizontal: sc.width(37),
                                  vertical: sc.height(14)),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(sc.height(100))),
                            ),
                            child: Text(
                              _submit,
                              style: TStyle(
                                color: Color(0xff1D1D1D),
                                size: sc.text(14),
                              ).copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(height: sc.height(73)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _didntGot,
                                style: TStyle(
                                    color: Palette.secondaryText,
                                    size: sc.text(18)),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // TODO: Resend otp
                                },
                                child: Text(
                                  _resend,
                                  style: TStyle(
                                    color: Palette.primary,
                                    size: sc.text(18),
                                  ).copyWith(
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              authNotifier.isLoading
                  ? LoadingWidget()
                  : AbsorbPointer(),
            ],
          ),
        ),
      ),
    );
  }
}
