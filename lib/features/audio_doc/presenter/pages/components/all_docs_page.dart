import 'package:audifie_version_1/core/size_config.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/audio_doc.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/progress_state_enum.dart';
import 'package:audifie_version_1/features/audio_doc/presenter/notifiers/audio_doc_notifier.dart';
import 'package:audifie_version_1/features/audio_doc/presenter/pages/components/audio_doc_card.dart';
import '../../../../../core/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'audio_doc_processing_card.dart';
import 'empty_list_widget.dart';

class AllDocsPage extends StatelessWidget {
  const AllDocsPage({Key? key}) : super(key: key);

  static SizeConfig sc = sl<SizeConfig>();

  @override
  Widget build(BuildContext context) {
    final AudioDocNotifier audioDocNotifier = context.watch<AudioDocNotifier>();
    final List<AudioDoc> audioDocs = audioDocNotifier.audioDocs;

    return audioDocs.isNotEmpty
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: sc.width(32)),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: audioDocs.length + 2,
              itemBuilder: (_, index) {
                if (index == 0) return SizedBox(height: sc.height(38));
                if (index == audioDocs.length + 1)
                  return SizedBox(height: sc.height(200));
                final AudioDoc audioDoc = audioDocs[index - 1];
                if (audioDoc.progressState == ProgressStateEnum.complete) {
                  return AudioDocCard(audioDoc: audioDoc);
                }
                return AudioDocProcessingCard(audioDoc: audioDoc);
              },
            ),
          )
        : EmptyListWidget();
  }
}
