import 'dart:math';

import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImagePlaceholder extends StatelessWidget {
  final double width;
  final double height;
  const ImagePlaceholder({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double iconSize = .30 * min(width, height);

    return Container(
      alignment: Alignment.center,
      color: Palette.primary,
      child: SvgPicture.asset(
        Strings.audifieIcon,
        width: iconSize,
        color: Palette.primaryText.withOpacity(.60),
      ),
    );
  }
}
