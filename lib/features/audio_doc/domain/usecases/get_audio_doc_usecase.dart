import 'package:audifie_version_1/core/errors/failure.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/audio_doc.dart';
import 'package:audifie_version_1/features/audio_doc/domain/repositories/audio_doc_repo.dart';
import 'package:dartz/dartz.dart';

class GetAudioDocUsecase {
  final AudioDocRepo audioDocRepo = sl<AudioDocRepo>();

  Future<Either<Failure, List<AudioDoc>>> getAllAudioDocs() {
    return audioDocRepo.getAllAudioDocs();
  }

  Future<Either<Failure, AudioDoc>> getAudioDoc(AudioDoc audioDoc) {
    return audioDocRepo.getAudioDoc(audioDoc);
  }
}
