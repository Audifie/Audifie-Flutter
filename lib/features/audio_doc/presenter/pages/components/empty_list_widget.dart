import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/size_config.dart';
import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import '../../../../../core/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({Key? key}) : super(key: key);

  static const String _instruction = 'Upload your documents';

  static final SizeConfig sc = sl<SizeConfig>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          Strings.uploadIllustraion,
          width: sc.width(195),
          height: sc.height(165),
        ),
        SizedBox(height: sc.height(70)),
        Text(
          _instruction,
          style: TStyle(
            color: Palette.secondaryText,
            size: sc.text(16),
          ),
        ),
      ],
    );
  }
}
