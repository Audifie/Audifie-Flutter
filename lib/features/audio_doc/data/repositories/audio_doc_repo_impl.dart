import 'package:audifie_version_1/core/errors/exception.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/features/audio_doc/data/data_sources/audio_doc_local_data_source.dart';
import 'package:audifie_version_1/features/audio_doc/data/data_sources/audio_doc_remote_data_source.dart';
import 'package:audifie_version_1/features/audio_doc/data/models/audio_doc_model.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/audio_doc.dart';
import 'package:audifie_version_1/core/errors/success.dart';
import 'package:audifie_version_1/core/errors/failure.dart';
import 'dart:io';

import 'package:audifie_version_1/features/audio_doc/domain/repositories/audio_doc_repo.dart';
import 'package:audifie_version_1/features/authentication/data/data_sources/auth_local_data_source.dart';
import 'package:dartz/dartz.dart';

class AudioDocRepoImpl implements AudioDocRepo {
  final AudioDocRemoteDataSource _audioDocRemoteDataSource = sl<AudioDocRemoteDataSource>();
  final AudioDocLocalDataSource _audioDocLocalDataSource = sl<AudioDocLocalDataSource>();
  final AuthLocalDataSource _authLocalDataSource = sl<AuthLocalDataSource>();

  @override
  Future<Either<Failure, List<AudioDoc>>> getAllAudioDocs() async {
    try {
      final List<AudioDocModel> audioDocModel = await _audioDocRemoteDataSource.getAllAudioDocs();
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
  Future<Either<Failure, Stream<int>>> uploadDoc(File doc) async {
    try {
      final String accessToken = await _authLocalDataSource.getAccessToken();
      return Right(await _audioDocRemoteDataSource.uploadDoc(accessToken, doc));
    } on PostException catch (e) {
      return Left(PostFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Success>> changeFavouriteTo(String fileId, bool favourite) async {
    try {
      await _audioDocRemoteDataSource.changeFavouriteTo(fileId, favourite);
      return Right(PostSuccess(message: ''));
    } on PostException catch (e) {
      return Left(PostFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Success>> deleteAudioDoc(String fileId) async {
    try {
      await _audioDocRemoteDataSource.deleteAudioDoc(fileId);
      return Right(PostSuccess(message: ''));
    } on PostException catch (e) {
      return Left(PostFailure(message: e.message));
    }
  }

  @override
  Future<File?> pickFile() {
    return _audioDocLocalDataSource.pickFile();
  }
}