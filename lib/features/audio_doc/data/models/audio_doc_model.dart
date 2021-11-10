import 'package:audifie_version_1/features/audio_doc/domain/entities/audio_doc.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/page_info.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/progress_state_enum.dart';

class AudioDocModel extends AudioDoc {
  AudioDocModel({
    required String fileId,
    required String title,
    String? imageUrl,
    String? fileUrl,
    required String progressState,
    required List<String> pages,
    required bool isFavourite,
  }) : super(
          fileId: fileId,
          title: title,
          duration: const Duration(),
          imageUrl: imageUrl,
          fileUrl: fileUrl,
          progressState: _getProgressState(progressState),
          pages: _getPageInfos(pages),
          isFavourite: isFavourite,
          file: null,
        );
  
  static List<PageInfo> _getPageInfos(List<String> pages) {
    if (pages.isEmpty) return [];
    return pages.map((url) => PageInfo(url: url)).toList();
  }

  static ProgressStateEnum _getProgressState(String progressState) {
    ProgressStateEnum progressEnum = ProgressStateEnum.processing;

    switch (progressState) {
      case "PROCESSING":
        progressEnum = ProgressStateEnum.processing;
        break;
      case "SPEECHSYNTH":
        progressEnum = ProgressStateEnum.speechsynth;
        break;
      case "COMPLETE":
        progressEnum = ProgressStateEnum.complete;
        break;
      default:
        progressEnum = ProgressStateEnum.processing;
    }

    return progressEnum;
  }
}
