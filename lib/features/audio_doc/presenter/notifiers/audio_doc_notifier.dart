import 'dart:async';

import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/audio_doc.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/page_info.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/playback_state_info.dart';
import 'package:audifie_version_1/features/audio_doc/domain/usecases/audio_doc_usecase.dart';
import 'package:audifie_version_1/features/audio_doc/domain/usecases/get_audio_doc_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudioDocNotifier extends ChangeNotifier {
  final GetAudioDocUsecase getAudioDocUsecase = GetAudioDocUsecase();
  final AudioDocUsecase audioDocUsecase = AudioDocUsecase();

  bool _isLoading = false;
  List<AudioDoc> _audioDocs = [];
  AudioDoc? _currentlyPlayingAudioDoc;
  bool get isLoading => _isLoading;
  List<AudioDoc> get audioDocs => _audioDocs;
  AudioDoc? get currentlyPlayingAudioDoc => _currentlyPlayingAudioDoc;
  Stream<List<PageInfo>> get playlistStream => audioDocUsecase.playlistStream;
  Stream<PlaybackStateInfo> get playbackStateStream =>
      audioDocUsecase.playbackStateStream;
  Stream<Duration> get positionStream => audioDocUsecase.positionStream;
  Stream<Duration> get durationStream => audioDocUsecase.durationStream;
  Stream<double> get speedStream => audioDocUsecase.speedStream;

  Future<void> getAllAudioDocsAndInit(BuildContext context) async {
    _isLoading = true;

    await getAudioDocUsecase.getAllAudioDocs()
      ..fold(
        (l) {
          ScaffoldMessenger.of(context)
              .showSnackBar(Snackbar(message: l.message));
        },
        (r) async {
          _audioDocs = r;
        },
      );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadPlaylist(AudioDoc audioDoc) async {
    _isLoading = true;

    await audioDocUsecase.loadPlaylistOfAudioDoc(audioDoc);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> play(AudioDoc audioDoc) async {
    audioDocUsecase.play();
    print('Currently playing: ${audioDoc.title}');
    _currentlyPlayingAudioDoc = audioDoc;
    notifyListeners();
  }

  Future<void> pause() => audioDocUsecase.pause();
  Future<void> seek(Duration position) => audioDocUsecase.seek(position);
  Future<void> skipToPrevious() => audioDocUsecase.skipToPrevious();
  Future<void> skipToNext() => audioDocUsecase.skipToNext();
  Future<void> setSpeed(double speed) => audioDocUsecase.setSpeed(speed);
  Future<void> stop() => audioDocUsecase.stop();
}
