import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/size_config.dart';
import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import 'package:audifie_version_1/core/widgets/loading_widget.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/progress_state_enum.dart';
import 'package:audifie_version_1/features/audio_doc/presenter/notifiers/audio_doc_notifier.dart';
import 'package:audifie_version_1/features/audio_doc/presenter/pages/components/audio_doc_card.dart';
import 'package:audifie_version_1/features/audio_doc/presenter/pages/components/audio_doc_processing_card.dart';
import 'package:audifie_version_1/features/audio_doc/presenter/pages/components/empty_list_widget.dart';
import '../../../../core/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String _upload = "Upload";
  static const double _horizontalPadding = 32;

  static final SizeConfig sc = sl<SizeConfig>();

  @override
  Widget build(BuildContext context) {
    final double dialogHeight = .62 * MediaQuery.of(context).size.height;

    final AudioDocNotifier audioDocNotifier = context.watch<AudioDocNotifier>();

    return Stack(
      children: [
        Scaffold(
          appBar: BaseAppBar(context: context),
          backgroundColor: Palette.bg,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                  horizontal: sc.width(_horizontalPadding)),
              child: Column(
                children: [
                  // SizedBox(height: sc.height(51)),
                  // Audifie icon
                  // SvgPicture.asset(
                  //   Strings.audifieTextIcon,
                  //   width: sc.width(111),
                  //   height: sc.height(24),
                  //   color: Palette.primary,
                  // ),
                  SizedBox(height: sc.height(104)),
                  // Upload button
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Upload function
                      // final String userID = context
                      //     .read<PageSelectorNotifier>()
                      //     .authUser!
                      //     .userId;
                      // final String idToken = context
                      //     .read<PageSelectorNotifier>()
                      //     .authSession!
                      //     .userPoolTokens
                      //     .idToken;
                      // context
                      //     .read<UploadNotifier>()
                      //     .uploadDoc(userID, idToken, filePathsBox: Hive.box(Strings.filePathsBox));
                      // Get.dialog(
                      //   WillPopScope(
                      //     onWillPop: () async {
                      //       return false;
                      //     },
                      //     child: UploadDialog(
                      //       height: dialogHeight,
                      //       valueStream: uploadNotifier.uploadStream,
                      //     ),
                      //   ),
                      //   useSafeArea: false,
                      //   barrierDismissible: false,
                      //   useRootNavigator: false,
                      // );
                    },
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
                          _upload,
                          style: TStyle(
                            color: Palette.primaryText,
                            size: sc.text(18),
                            isBold: true,
                            font: Strings.comfortaaFont,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: sc.height(93)),
                  // Document list
                  audioDocNotifier.audioDocs.isNotEmpty
                      ? Column(
                          children:
                              audioDocNotifier.audioDocs.asMap().entries.map(
                                    (audioDoc) {
                                      if (audioDoc.key >= 3) {
                                        return const SizedBox();
                                      }
                                      if (audioDoc.value.progressState ==
                                          ProgressStateEnum.complete) {
                                        return AudioDocCard(
                                          audioDoc: audioDoc.value,
                                        );
                                      }
                                      return AudioDocProcessingCard(audioDoc: audioDoc.value);
                                    },
                                  ).toList() +
                                  [SizedBox(height: sc.height(200))],
                        )
                      : EmptyListWidget(),
                ],
              ),
            ),
          ),
        ),
        audioDocNotifier.isLoading ? LoadingWidget() : AbsorbPointer(),
      ],
    );
  }
}
