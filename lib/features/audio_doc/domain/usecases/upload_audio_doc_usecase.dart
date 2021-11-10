import 'dart:io';

import 'package:audifie_version_1/core/errors/failure.dart';
import 'package:audifie_version_1/core/errors/success.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/features/audio_doc/domain/repositories/audio_doc_repo.dart';
import 'package:dartz/dartz.dart';

class UploadAudioDocUsecase {
  final AudioDocRepo audioDocRepo = sl<AudioDocRepo>();

  Future<Either<Failure, Success>> uploadDoc(File doc) {
    return audioDocRepo.uploadDoc(doc);
  }
}