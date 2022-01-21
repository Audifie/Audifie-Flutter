import 'dart:async';

import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/size_config.dart';
import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import 'package:audifie_version_1/core/widgets/loading_widget.dart';
import 'package:audifie_version_1/features/audio_doc/data/data_sources/audio_doc_remote_data_source.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/progress_state_enum.dart';
import 'package:audifie_version_1/features/audio_doc/presenter/notifiers/audio_doc_notifier.dart';
import 'package:audifie_version_1/features/audio_doc/presenter/pages/components/audio_doc_card.dart';
import 'package:audifie_version_1/features/audio_doc/presenter/pages/components/audio_doc_processing_card.dart';
import 'package:audifie_version_1/features/audio_doc/presenter/pages/components/empty_list_widget.dart';
import 'package:audifie_version_1/features/audio_doc/presenter/pages/components/upload_button.dart';
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
  static const double _horizontalPadding = 32;

  static final SizeConfig sc = sl<SizeConfig>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                  SizedBox(height: sc.height(104)),
                  // Upload button
                  Consumer<AudioDocNotifier>(
                      builder: (context, notifier, chlid) {
                    return UploadButton(
                      isUploading: notifier.isUploadingFile,
                      onUploadClicked: () {
                        context
                            .read<AudioDocNotifier>()
                            .uploadAudioDoc(context);
                      },
                      onCancelClicked: () {},
                    );
                  }),
                  SizedBox(height: sc.height(93)),
                  // Document list
                  !audioDocNotifier.isProblemInFetching
                      ? audioDocNotifier.audioDocs.isNotEmpty
                          ? Column(
                              children: audioDocNotifier.audioDocs
                                      .asMap()
                                      .entries
                                      .map(
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
                                      return AudioDocProcessingCard(
                                          audioDoc: audioDoc.value);
                                    },
                                  ).toList() +
                                  [SizedBox(height: sc.height(200))],
                            )
                          : EmptyListWidget()
                      : Column(
                          children: [
                            Text(
                              'There was an error. Please reload',
                              style: TStyle(
                                color: Palette.primaryText,
                                size: sc.text(14),
                                isBold: true,
                                font: Strings.comfortaaFont,
                              ),
                            ),
                            SizedBox(height: sc.height(24)),
                            InkWell(
                              onTap: () {
                                context
                                    .read<AudioDocNotifier>()
                                    .getAllAudioDocs(context);
                              },
                              child: Container(
                                padding: EdgeInsets.all(sc.height(6)),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Palette.primary,
                                ),
                                child: Icon(
                                  Icons.replay_outlined,
                                  color: Palette.primaryText,
                                  size: sc.height(24),
                                ),
                              ),
                            ),
                          ],
                        ),
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
