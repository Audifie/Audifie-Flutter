import 'package:audifie_version_1/features/audio_doc/domain/entities/audio_doc.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/progress_state_enum.dart';

class AudioDocModel extends AudioDoc {
  AudioDocModel({
    required String fileId,
    required String title,
    required String? audioURL,
    required String? speechURL,
    required bool isProcessing,
    required bool isFavourite,
    required String? imageURL,
  }) : super(
          fileId: fileId,
          title: title,
          audioURL: audioURL,
          speechURL: speechURL,
          duration: const Duration(),
          progressState: _getProgressState(isProcessing),
          isFavourite: isFavourite,
          imageURL: imageURL,
        );

  // static List<PageInfo> _getPageInfos(List<String> pages) {
  //   if (pages.isEmpty) return [];
  //   return pages.map((url) => PageInfo(url: url)).toList();
  // }

  static ProgressStateEnum _getProgressState(bool isProcessing) {
    if (isProcessing) return ProgressStateEnum.processing;
    return ProgressStateEnum.complete;
  }

  static bool _isProcessing(ProgressStateEnum progressStateEnum) {
    return progressStateEnum == ProgressStateEnum.complete;
  }

  // This function is used when getting all audio docs initially
  factory AudioDocModel.fromMap(Map<String, dynamic> map) {
    return AudioDocModel(
      fileId: map['_id'] ?? DateTime.now().toString(),
      title: map['title'] ?? '-- Title --',
      audioURL: null,
      speechURL: null,
      isProcessing: map['processing'] ?? false,
      isFavourite: map['isFavourite'] ?? false,
      imageURL: map['imageURL'],
    );
  }

  // This function is used when getting a specific audio doc
  factory AudioDocModel.fromMapToGetAudioDoc(AudioDocModel audioDocModel, Map<String, dynamic> map) {
    return AudioDocModel(
      fileId: audioDocModel.fileId,
      title: audioDocModel.title,
      audioURL: map['audioUrl'],
      speechURL: map['speechUrl'],
      isProcessing: _isProcessing(audioDocModel.progressState),
      isFavourite: audioDocModel.isFavourite,
      imageURL: audioDocModel.imageURL,
    );
  }
}
