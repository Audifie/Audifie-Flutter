import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/core/size_config.dart';
import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({Key? key}) : super(key: key);

  static const String _text1 = "Wait for sometime!\n";
  static const String _text2 = "Some ";
  static const String _text3 = "Exiciting Services ";
  static const String _text4 = "are Coming Soon.";

  static const double _horizontalPadding = 34;

  static SizeConfig sc = sl<SizeConfig>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bg,
      appBar: IndependentAppBar(context: context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: sc.width(_horizontalPadding)),
        child: Column(
          children: [
            SizedBox(height: sc.height(80)),
            // Box Image
            Image.asset(
              Strings.surpriseBoxGif,
              width: sc.height(285),
              height: sc.height(285),
            ),
            SizedBox(height: sc.height(62)),
            RichText(
              textAlign: TextAlign.center,
              strutStyle: StrutStyle(height: sc.height(2.6)),
              text: TextSpan(
                style: TStyle(
                  color: Palette.secondaryText,
                  size: sc.text(16),
                ),
                children: [
                  TextSpan(text: _text1),
                  TextSpan(text: _text2),
                  TextSpan(
                    text: _text3,
                    style: TStyle(
                      color: Palette.premiumBottomNavBar,
                      size: sc.text(16),
                      isBold: true,
                    ),
                  ),
                  TextSpan(text: _text4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}