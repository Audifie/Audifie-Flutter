import 'package:audifie_version_1/features/audio_doc/domain/entities/audio_doc.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/page_info.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/progress_state_enum.dart';

class AudioDocModel extends AudioDoc {
  AudioDocModel({
    required String fileId,
    required String title,
    String? imageUrl,
    required bool isProcessing,
    required List<String> pages,
    required bool isFavourite,
  }) : super(
          fileId: fileId,
          title: title,
          duration: const Duration(),
          imageUrl: imageUrl,
          fileUrl: null,
          progressState: _getProgressState(isProcessing),
          pages: _getPageInfos(pages),
          isFavourite: isFavourite,
          file: null,
        );
  
  static List<PageInfo> _getPageInfos(List<String> pages) {
    if (pages.isEmpty) return [];
    return pages.map((url) => PageInfo(url: url)).toList();
  }

  static ProgressStateEnum _getProgressState(bool isProcessing) {
    if (isProcessing) return ProgressStateEnum.processing;
    return ProgressStateEnum.complete;
  }

  factory AudioDocModel.fromMap(Map<String, dynamic> map) {
    return AudioDocModel(
      fileId: map['_id'] ?? DateTime.now().toString(),
      title: map['title'] ?? '-- Title --',
      imageUrl: map['imageURL'] ?? null,
      isProcessing: map['processing'] ?? false,
      pages: [],
      isFavourite: map['isFavourite'] ?? false,
    );
  }
}
