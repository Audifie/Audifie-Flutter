import 'dart:io';

import 'package:audifie_version_1/core/utils/dummy_util.dart';
import 'package:audifie_version_1/features/audio_doc/data/models/audio_doc_model.dart';

abstract class AudioDocRemoteDataSource {
  Future<List<AudioDocModel>> getAllAudioDocs();
  Future<AudioDocModel> getAudioDoc();
  Future<void> uploadDoc(File doc);
}

class AudioDocRemoteDataSourceImpl implements AudioDocRemoteDataSource {
  @override
  Future<List<AudioDocModel>> getAllAudioDocs() async {
    return DummyUtil.audioDocModels;
  }

  @override
  Future<AudioDocModel> getAudioDoc() {
    // TODO: implement getAudioDoc
    throw UnimplementedError();
  }

  @override
  Future<void> uploadDoc(File doc) {
    // TODO: implement uploadDoc
    throw UnimplementedError();
  }
}