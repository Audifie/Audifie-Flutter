import 'dart:io';

import 'package:audifie_version_1/features/audio_doc/domain/entities/page_info.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/progress_state_enum.dart';
import 'package:equatable/equatable.dart';

class AudioDoc extends Equatable {
  final String fileId;
  final String title;
  final String subtitles;
  Duration duration;
  final String? imageUrl;
  final String? fileUrl;
  final ProgressStateEnum progressState;
  final List<PageInfo> pages;
  bool isFavourite;
  File? file;

  AudioDoc({
    required this.fileId,
    required this.title,
    required this.subtitles,
    required this.duration,
    required this.imageUrl,
    required this.fileUrl,
    required this.progressState,
    required this.pages,
    required this.isFavourite,
    required this.file,
  });

  @override
  List<Object?> get props => [
        fileId,
        title,
      ];
}
