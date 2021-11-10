import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/size_config.dart';
import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/audio_doc.dart';
import '../../../../../core/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AudioDocProcessingCard extends StatefulWidget {
  final AudioDoc audioDoc;
  const AudioDocProcessingCard({Key? key, required this.audioDoc})
      : super(key: key);

  @override
  _AudioDocProcessingCardState createState() => _AudioDocProcessingCardState();
}

class _AudioDocProcessingCardState extends State<AudioDocProcessingCard> {
  static const String _processing = "Processing...";
  static const String _getAudio = "GET AUDIO";

  static SizeConfig sc = sl<SizeConfig>();

  static Widget _emptyImage = Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(sc.height(2)),
      color: Palette.primary,
    ),
    child: SvgPicture.asset(
      Strings.audifieIcon,
      width: sc.height(40),
      height: sc.height(40),
      color: Palette.primaryText.withOpacity(.60),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final String title = widget.audioDoc.title;

    return Container(
      height: .56 * MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: sc.height(34)),
      decoration: BoxDecoration(
        color: Palette.audioDocCardBg,
        borderRadius: BorderRadius.circular(sc.height(5)),
      ),
      child: Row(
        children: [
          // Doc Image
          Expanded(
            flex: 44,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: sc.width(4),
                vertical: sc.height(4),
              ),
              child: _emptyImage,
            ),
          ),
          // Doc Info
          Expanded(
            flex: 56,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: sc.width(24),
                vertical: sc.height(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title
                  Text(
                    title,
                    style: TStyle(
                      color: Palette.primaryText,
                      size: sc.text(16),
                      isBold: true,
                    ),
                  ),
                  // Progress State
                  Text(_processing,
                      style: TStyle(
                          color: Palette.secondaryText, size: sc.text(14))),
                  // Get audio Button
                  ElevatedButton(
                    onPressed: () async {
                      // TODO: Get audio button
                      // final String fileId = widget.audioDocModel.fileId;
                      // final String idToken = context
                      //     .read<PageSelectorNotifier>()
                      //     .authSession!
                      //     .userPoolTokens
                      //     .idToken;

                      // await context.read<UploadNotifier>().postAudioDocModel(
                      //       widget.audioDocModel,
                      //       fileId,
                      //       idToken,
                      //       filePathsBox: Hive.box(Strings.filePathsBox),
                      //     );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: sc.width(36),
                        vertical: sc.height(14),
                      ),
                      primary: Palette.primaryText,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(sc.height(50)),
                      ),
                    ),
                    child: Text(
                      _getAudio,
                      style: TStyle(
                        color: Palette.audioDocCardBg,
                        size: sc.text(14),
                      ).copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
