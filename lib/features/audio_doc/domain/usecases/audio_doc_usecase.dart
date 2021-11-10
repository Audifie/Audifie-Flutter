import 'dart:async';

import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/core/services/audio_player_service.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/audio_doc.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/page_info.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/playback_state_info.dart';

class AudioDocUsecase {
  final AudioPlayerService audioPlayerService = sl<AudioPlayerService>();

  Stream<List<PageInfo>> get playlistStream => audioPlayerService.playlistStream;
  Stream<PlaybackStateInfo> get playbackStateStream => audioPlayerService.playerStateStream;
  Stream<Duration> get positionStream => audioPlayerService.positionStream;
  Stream<Duration> get durationStream => audioPlayerService.durationStream;
  Stream<double> get speedStream => audioPlayerService.speedStream;

  Future<void> loadPlaylistOfAudioDoc(AudioDoc audioDoc) async {
    await audioPlayerService.addQueueItems(audioDoc);
  }

  Future<void> play() => audioPlayerService.play();
  Future<void> pause() => audioPlayerService.pause();
  Future<void> seek(Duration position) => audioPlayerService.seek(position);
  Future<void> skipToPrevious() => audioPlayerService.skipToPrevious();
  Future<void> skipToNext() => audioPlayerService.skipToNext();
  Future<void> setSpeed(double speed) => audioPlayerService.setSpeed(speed);
  Future<void> stop() => audioPlayerService.stop();
}
