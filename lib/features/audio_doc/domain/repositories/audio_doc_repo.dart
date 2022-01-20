import 'dart:io';

import 'package:audifie_version_1/core/errors/failure.dart';
import 'package:audifie_version_1/core/errors/success.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/audio_doc.dart';
import 'package:dartz/dartz.dart';

abstract class AudioDocRepo {
  Future<Either<Failure, List<AudioDoc>>> getAllAudioDocs();
  Future<Either<Failure, AudioDoc>> getAudioDoc(AudioDoc audioDoc);
  Future<Either<Failure, Success>> uploadDoc(File doc);
  Future<Either<Failure, Success>> changeFavouriteTo(String fileId, bool favourite);
  Future<Either<Failure, Success>> deleteAudioDoc(String fileId);
  Future<File?> pickFile();
}
