import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/size_config.dart';
import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import '../../../../../core/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransectionCard extends StatelessWidget {
  const TransectionCard({Key? key}) : super(key: key);

  static SizeConfig sc = sl<SizeConfig>();

  static const String _title = "Recharge :  Weekly Entertainment";
  static const String _date = "13/05/2021";
  static const String _downloadReciept = "Download Reciept";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: sc.width(36), vertical: sc.height(20)),
      decoration: BoxDecoration(
        color: Palette.bottomNavBar,
        borderRadius: BorderRadius.circular(sc.height(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _title,
            style: TStyle(
              color: Palette.primaryText,
              size: sc.text(16),
            ).copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: sc.height(12)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: sc.width(15), vertical: sc.height(6)),
            decoration: BoxDecoration(
              color: Palette.settingsBtn.withOpacity(.20),
              borderRadius: BorderRadius.circular(sc.height(100)),
            ),
            child: Text(
              _date,
              style: TStyle(
                color: Palette.secondaryText,
                size: sc.text(14),
              ),
            ),
          ),
          SizedBox(height: sc.height(24)),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: sc.width(32),
                  vertical: sc.height(15),
                ),
                primary: Palette.primaryText,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(sc.height(100)),
                ),
              ),
              child: Text(
                _downloadReciept,
                style: TStyle(color: Colors.black, size: sc.text(14)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
