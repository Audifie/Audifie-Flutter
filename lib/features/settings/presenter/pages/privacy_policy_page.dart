import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/size_config.dart';
import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import '../../../../core/service_locator.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  static const String routeName = '/privacy_policy_page';

  const PrivacyPolicyPage({Key? key}) : super(key: key);

  static const String _privacy = "Privacy Policy";
  static const String _disc = "Disclaimer";
  static const String _cpy = "Copyright Policy";
  static const String _term = "Term & Condition";

  static const double _horizontalPadding = 34;

  static SizeConfig sc = sl<SizeConfig>();

  static Widget _dot = Container(
    width: sc.height(11),
    height: sc.height(11),
    decoration: BoxDecoration(
      color: Palette.primaryText,
      borderRadius: BorderRadius.circular(sc.height(6)),
    ),
  );

  static Widget _title(String title) {
    return Row(
      children: [
        _dot,
        SizedBox(width: sc.width(8)),
        Text(
          title,
          style: TStyle(
            color: Palette.primaryText,
            size: sc.text(20),
          ).copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IndependentAppBar(context: context),
      backgroundColor: Palette.bg,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            // SizedBox(height: sc.height(51)),
            // IndependentAppBarWidget(),
            
            /// Privacy Policy 
            SizedBox(height: sc.height(60)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
              child: _title(_privacy),
            ),
            SizedBox(height: sc.height(24)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
              child: Text(
                Strings.privacyPolicy,
                style: TStyle(
                  color: Palette.primaryText,
                  size: sc.text(16),
                ).copyWith(height: sc.height(1.8)),
              ),
            ),
            /// Disclaimer
            SizedBox(height: sc.height(60)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
              child: _title(_disc),
            ),
            SizedBox(height: sc.height(24)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
              child: Text(
                Strings.disclaimer,
                style: TStyle(
                  color: Palette.primaryText,
                  size: sc.text(16),
                ).copyWith(height: sc.height(1.8)),
              ),
            ),
            /// Copyright Policy
            SizedBox(height: sc.height(60)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
              child: _title(_cpy),
            ),
            SizedBox(height: sc.height(24)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
              child: Text(
                Strings.copyRightPolicy,
                style: TStyle(
                  color: Palette.primaryText,
                  size: sc.text(16),
                ).copyWith(height: sc.height(1.8)),
              ),
            ),
            /// Terms and Conditions
            SizedBox(height: sc.height(60)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
              child: _title(_term),
            ),
            SizedBox(height: sc.height(24)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
              child: Text(
                Strings.termsAndConditions,
                style: TStyle(
                  color: Palette.primaryText,
                  size: sc.text(16),
                ).copyWith(height: sc.height(1.8)),
              ),
            ),
            SizedBox(height: sc.height(60)),
          ],
        ),
      ),
    );
  }
}
