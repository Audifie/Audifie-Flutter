import 'package:audifie_version_1/core/errors/failure.dart';
import 'package:audifie_version_1/core/errors/success.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/audio_doc.dart';
import 'package:audifie_version_1/features/audio_doc/domain/repositories/audio_doc_repo.dart';
import 'package:dartz/dartz.dart';

class GetAudioDocUsecase {
  final AudioDocRepo _audioDocRepo = sl<AudioDocRepo>();

  Future<Either<Failure, List<AudioDoc>>> getAllAudioDocs() {
    return _audioDocRepo.getAllAudioDocs();
  }

  Future<Either<Failure, AudioDoc>> getAudioDoc(AudioDoc audioDoc) {
    return _audioDocRepo.getAudioDoc(audioDoc);
  }

  Future<Either<Failure, Success>> changeFavouriteTo(String fileId, bool favourite) {
    return _audioDocRepo.changeFavouriteTo(fileId, favourite);
  }

  Future<Either<Failure, Success>> deleteAudioDoc(String fileId) {
    return _audioDocRepo.deleteAudioDoc(fileId);
  }
}
