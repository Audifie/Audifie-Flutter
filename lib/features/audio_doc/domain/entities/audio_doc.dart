import 'dart:io';

import 'package:audifie_version_1/features/audio_doc/domain/entities/page_info.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/progress_state_enum.dart';
import 'package:equatable/equatable.dart';

class AudioDoc extends Equatable {
  final String fileId;
  final String title;
  String? audioURL;
  String? speechURL;
  Duration duration;
  final ProgressStateEnum progressState;
  bool isFavourite;
  final String? imageURL;

  AudioDoc({
    required this.fileId,
    required this.title,
    required this.audioURL,
    required this.speechURL,
    required this.duration,
    required this.progressState,
    required this.isFavourite,
    required this.imageURL,
  });

  @override
  List<Object?> get props => [
        fileId,
        title,
      ];
}
