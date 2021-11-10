import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/size_config.dart';
import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import '../../../../core/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransectionsPage extends StatelessWidget {
  static const String routeName = '/transection_page';

  const TransectionsPage({Key? key}) : super(key: key);

  static const String _text1 = "Wait for sometime!\n";
  static const String _text2 = "Some ";
  static const String _text3 = "Exiciting Services ";
  static const String _text4 = "are Coming Soon.";

  static const double _horizontalPadding = 34;

  static const String _yourTransections = "Your Transections";
  static const String _noHistory = "No History";
  static const String _noPurchase = "You have not made any purchase yet.";

  static SizeConfig sc = sl<SizeConfig>();

  static final List<int> _transectionNumList =
      List.generate(4, (index) => index);

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
    //TODO: Don't delete this code this is the actual Transections Page code
    // return Scaffold(
    //   appBar: IndependentAppBar(),
    //   backgroundColor: Palette.bg,
    //   body: SingleChildScrollView(
    //     physics: BouncingScrollPhysics(),
    //     child: Column(
    //       children: [
    //         // SizedBox(height: sc.height(51)),
    //         // IndependentAppBarWidget(),
    //         SizedBox(height: sc.height(41)),
    //         Padding(
    //           padding: EdgeInsets.symmetric(
    //             horizontal: sc.width(_horizontalPadding),
    //           ),
    //           child: Align(
    //             alignment: Alignment.centerLeft,
    //             child: Text(
    //               _yourTransections,
    //               style: TStyle(
    //                 color: Palette.primaryText,
    //                 size: sc.text(20),
    //               ).copyWith(fontWeight: FontWeight.w500),
    //             ),
    //           ),
    //         ),
    //         _transectionNumList.isNotEmpty
    //             ? Column(
    //                 children: <Widget>[SizedBox(height: sc.height(71))] +
    //                     _transectionNumList.map((trasectionInfo) {
    //                       return Padding(
    //                         padding: EdgeInsets.only(
    //                           bottom: sc.height(27),
    //                           left: sc.width(_horizontalPadding),
    //                           right: sc.width(_horizontalPadding),
    //                         ),
    //                         child: TransectionCard(),
    //                       );
    //                     }).toList(),
    //               )
    //             : Expanded(
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     SvgPicture.asset(
    //                       Strings.historyIcon,
    //                       width: sc.height(32),
    //                       height: sc.height(32),
    //                       color: Palette.emptyColor,
    //                     ),
    //                     SizedBox(height: sc.height(32)),
    //                     Text(
    //                       _noHistory,
    //                       style: TStyle(
    //                         color: Palette.emptyColor,
    //                         size: sc.text(28),
    //                       ).copyWith(fontWeight: FontWeight.w500),
    //                     ),
    //                     SizedBox(height: sc.height(42)),
    //                     Text(
    //                       _noPurchase,
    //                       textAlign: TextAlign.center,
    //                       style: TStyle(
    //                         color: Palette.emptyColor,
    //                         size: sc.text(16),
    //                       ).copyWith(fontWeight: FontWeight.w500),
    //                     ),
    //                     SizedBox(height: sc.height(140)),
    //                   ],
    //                 ),
    //               ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
