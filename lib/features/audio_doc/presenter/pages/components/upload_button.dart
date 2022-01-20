import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/core/size_config.dart';
import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UploadButton extends StatelessWidget {
  final bool isUploading;
  final Function()? onUploadClicked;
  final Function()? onCancelClicked;
  const UploadButton({
    Key? key,
    required this.isUploading,
    this.onUploadClicked,
    this.onCancelClicked,
  }) : super(key: key);

  static final SizeConfig sc = sl<SizeConfig>();

  @override
  Widget build(BuildContext context) {
    return !isUploading
        ? ElevatedButton(
            onPressed: onUploadClicked,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: sc.width(44),
                vertical: sc.height(14),
              ),
              primary: Palette.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(sc.height(100)),
              ),
              alignment: Alignment.center,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Strings.uploadIcon,
                  width: sc.height(20),
                  height: sc.height(20),
                  color: Palette.primaryText,
                ),
                SizedBox(width: sc.width(20)),
                Text(
                  'Upload',
                  style: TStyle(
                    color: Palette.primaryText,
                    size: sc.text(18),
                    isBold: true,
                  ),
                ),
              ],
            ),
          )
        : ElevatedButton(
            onPressed: onCancelClicked,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: sc.width(44),
                vertical: sc.height(14),
              ),
              primary: Palette.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(sc.height(100)),
              ),
              alignment: Alignment.center,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Uploading...',
                  style: TStyle(
                    color: Palette.primaryText,
                    size: sc.text(18),
                    isBold: true,
                  ),
                ),
              ],
            ),
          );
  }
}
