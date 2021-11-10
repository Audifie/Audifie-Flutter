import 'package:audifie_version_1/core/errors/exception.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/features/audio_doc/data/data_sources/audio_doc_remote_data_source.dart';
import 'package:audifie_version_1/features/audio_doc/data/models/audio_doc_model.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/audio_doc.dart';
import 'package:audifie_version_1/core/errors/success.dart';
import 'package:audifie_version_1/core/errors/failure.dart';
import 'dart:io';

import 'package:audifie_version_1/features/audio_doc/domain/repositories/audio_doc_repo.dart';
import 'package:dartz/dartz.dart';

class AudioDocRepoImpl implements AudioDocRepo {
  final AudioDocRemoteDataSource audioDocRemoteDataSource = sl<AudioDocRemoteDataSource>();

  @override
  Future<Either<Failure, List<AudioDoc>>> getAllAudioDocs() async {
    try {
      final List<AudioDocModel> audioDocModel = await audioDocRemoteDataSource.getAllAudioDocs();
      return Right(audioDocModel);
    } on GetException catch (e) {
      return Left(GetFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, AudioDoc>> getAudioDoc(AudioDoc audioDoc) {
    // TODO: implement getAudioDoc
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Success>> uploadDoc(File doc) {
    // TODO: implement uploadDoc
    throw UnimplementedError();
  }
}