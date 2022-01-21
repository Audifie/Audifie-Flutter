import 'dart:async';
import 'dart:io';

import 'package:audifie_version_1/core/errors/failure.dart';
import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/audio_doc.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/page_info.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/playback_state_info.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/progress_state_enum.dart';
import 'package:audifie_version_1/features/audio_doc/domain/usecases/audio_doc_usecase.dart';
import 'package:audifie_version_1/features/audio_doc/domain/usecases/get_audio_doc_usecase.dart';
import 'package:audifie_version_1/features/audio_doc/domain/usecases/upload_audio_doc_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudioDocNotifier extends ChangeNotifier {
  final GetAudioDocUsecase _getAudioDocUsecase = GetAudioDocUsecase();
  final AudioDocUsecase _audioDocUsecase = AudioDocUsecase();
  final UploadAudioDocUsecase _uploadAudioDocUsecase = UploadAudioDocUsecase();

  bool _isLoading = false;
  bool _isUploadingFile = false;
  List<AudioDoc> _audioDocs = [];
  bool _isProblemInFetching = false;
  AudioDoc? _currentlyPlayingAudioDoc;
  bool get isLoading => _isLoading;
  bool get isUploadingFile => _isUploadingFile;
  List<AudioDoc> get audioDocs => _audioDocs;
  bool get isProblemInFetching => _isProblemInFetching;
  AudioDoc? get currentlyPlayingAudioDoc => _currentlyPlayingAudioDoc;
  Stream<List<PageInfo>> get playlistStream => _audioDocUsecase.playlistStream;
  Stream<PlaybackStateInfo> get playbackStateStream =>
      _audioDocUsecase.playbackStateStream;
  Stream<Duration> get positionStream => _audioDocUsecase.positionStream;
  Stream<Duration> get durationStream => _audioDocUsecase.durationStream;
  Stream<double> get speedStream => _audioDocUsecase.speedStream;

  Future<void> getAllAudioDocsAndInit(BuildContext context) async {
    _isLoading = true;

    await _getAudioDocUsecase.getAllAudioDocs()
      ..fold(
        (l) {
          _isProblemInFetching = true;
          ScaffoldMessenger.of(context)
              .showSnackBar(Snackbar(message: l.message));
        },
        (r) async {
          _isProblemInFetching = false;
          _audioDocs = r;
        },
      );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getAllAudioDocs(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    await _getAudioDocUsecase.getAllAudioDocs()
      ..fold(
        (l) {
          _isProblemInFetching = true;
          ScaffoldMessenger.of(context)
              .showSnackBar(Snackbar(message: l.message));
        },
        (r) async {
          _isProblemInFetching = false;
          _audioDocs = r;
        },
      );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getAudioDoc(BuildContext context, AudioDoc audioDoc) async {
    if (audioDoc.audioURL != null) {
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    await _getAudioDocUsecase.getAudioDoc(audioDoc)
      ..fold((l) {
        ScaffoldMessenger.of(context)
            .showSnackBar(Snackbar(message: l.message));
      }, (r) {
        print('Should be updated');
        // ** Updating the audioURL and speechURL **
        for (int i = 0; i < _audioDocs.length; i++) {
          if (_audioDocs[i].fileId == r.fileId) {
            _audioDocs[i].audioURL = r.audioURL;
            _audioDocs[i].speechURL = r.speechURL;
            _audioDocs[i].progressState = ProgressStateEnum.complete;
            break;
          }
        }
      });

    _isLoading = false;
    notifyListeners();
  }

  Future<Stream<int>?> uploadAudioDoc(BuildContext context) async {
    _isUploadingFile = true;
    notifyListeners();

    final File? doc = await _uploadAudioDocUsecase.pickFile();
    if (doc != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(Snackbar(message: 'Uploading file'));
      await _uploadAudioDocUsecase.uploadDoc(doc)
        ..fold((l) {
          ScaffoldMessenger.of(context)
              .showSnackBar(Snackbar(message: l.message));
        }, (r) async {
          await Future.delayed(const Duration(seconds: 1));
          _isUploadingFile = false;
          notifyListeners();

          await getAllAudioDocs(context);

          ScaffoldMessenger.of(context)
              .showSnackBar(Snackbar(message: 'File uploaded'));
        });
    } else {
      _isUploadingFile = false;
      notifyListeners();

      ScaffoldMessenger.of(context)
          .showSnackBar(Snackbar(message: 'No file selected'));
    }
  }

  Future<void> changeFavouriteTo(
      BuildContext context, AudioDoc audioDoc, bool favourite) async {
    audioDoc.isFavourite = favourite;
    notifyListeners();

    await _getAudioDocUsecase.changeFavouriteTo(audioDoc.fileId, favourite)
      ..fold((l) {
        ScaffoldMessenger.of(context)
            .showSnackBar(Snackbar(message: l.message));
        audioDoc.isFavourite = !favourite;
      }, (r) {
        audioDoc.isFavourite = favourite;
      });

    notifyListeners();
  }

  void _deleteAudioDocFromAudioDocList(AudioDoc audioDoc) {
    for (int i = 0; i < _audioDocs.length; i++) {
      if (audioDoc.fileId == _audioDocs[i].fileId) {
        _audioDocs.removeAt(i);
        break;
      }
    }
  }

  Future<void> deleteAudioDoc(
      BuildContext context, AudioDoc audioDoc) async {
    _isLoading = true;
    notifyListeners();

    await _getAudioDocUsecase.deleteAudioDoc(audioDoc.fileId)
      ..fold((l) {
        ScaffoldMessenger.of(context)
            .showSnackBar(Snackbar(message: l.message));
      }, (r) {
        _deleteAudioDocFromAudioDocList(audioDoc);
      });

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadPlaylist(AudioDoc audioDoc) async {
    _isLoading = true;

    await _audioDocUsecase.loadPlaylistOfAudioDoc(audioDoc);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> play(AudioDoc audioDoc) async {
    _audioDocUsecase.play();
    print('Currently playing: ${audioDoc.title}');
    _currentlyPlayingAudioDoc = audioDoc;
    notifyListeners();
  }

  Future<void> pause() => _audioDocUsecase.pause();
  Future<void> seek(Duration position) => _audioDocUsecase.seek(position);
  Future<void> skipToPrevious() => _audioDocUsecase.skipToPrevious();
  Future<void> skipToNext() => _audioDocUsecase.skipToNext();
  Future<void> setSpeed(double speed) => _audioDocUsecase.setSpeed(speed);

  /// Fast forwards 15 s
  Future<void> fastForward() => _audioDocUsecase.fastForward();

  /// Rewinds 15 s
  Future<void> rewind() => _audioDocUsecase.rewind();
  Future<void> stop() => _audioDocUsecase.stop();
}
