import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/audio_doc.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/page_info.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/playback_state_info.dart';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import '../service_locator.dart';

Future<AudioHandler> initAudioService() async {
  return await AudioService.init(
    builder: () => MyAudioHandler(),
    config: AudioServiceConfig(
      androidNotificationChannelId: 'com.mycompany.myapp.audio',
      androidNotificationChannelName: 'Audio Service Demo',
      // androidNotificationOngoing: true,
      // androidStopForegroundOnPause: true,
      notificationColor: Palette.audioDocCardBg,
    ),
  );
}

class MyAudioHandler extends BaseAudioHandler {
  final AudioPlayer _player = sl<AudioPlayer>();
  ConcatenatingAudioSource _playlist = ConcatenatingAudioSource(children: []);

  MyAudioHandler() {
    _loadEmptyPlaylist();
    _notifyAudioHandlerAboutPlaybackEvent();
    _listenForDurationChanges();
  }

  Future<void> _loadEmptyPlaylist() async {
    try {
      await _player.setAudioSource(_playlist);
    } catch (e) {
      print('Error in [_loadEmptyPlaylist] in [MyAudioHandler] class: $e');
    }
  }

  void _notifyAudioHandlerAboutPlaybackEvent() {
    _player.playbackEventStream.listen((event) {
      final bool isPlaying = _player.playing;
      playbackState.add(playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          isPlaying ? MediaControl.pause : MediaControl.play,
          MediaControl.skipToNext,
        ],
        androidCompactActionIndices: const [0, 1, 2],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[_player.processingState]!,
        playing: isPlaying,
        // updatePosition: event.updatePosition,
        // bufferedPosition: event.bufferedPosition,
        queueIndex: event.currentIndex,
      ));
    });
  }

  void _listenForDurationChanges() {
    _player.durationStream.listen((duration) {
      final index = _player.currentIndex;
      final newQueue = queue.value;
      if (index == null || newQueue.isEmpty) return;
      final oldMediaItem = newQueue[index];
      final newMediaItem = oldMediaItem.copyWith(duration: duration);
      newQueue[index] = newMediaItem;
      queue.add(newQueue);
      mediaItem.add(newMediaItem);
    });
  }

  UriAudioSource _getUriAudioSourceFromMediaItem(MediaItem mediaItem) {
    return AudioSource.uri(Uri.parse(mediaItem.id));
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    if (mediaItems.isNotEmpty) {
      _player.setAudioSource(
        ConcatenatingAudioSource(
          children: mediaItems.map((mediaItem) {
            return _getUriAudioSourceFromMediaItem(mediaItem);
          }).toList(),
          useLazyPreparation: true,
        ),
      );

      // Notifying system
      queue.add(mediaItems);

      return super.addQueueItems(mediaItems);
    }
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> skipToPrevious() => _player.seekToPrevious();

  @override
  Future<void> skipToNext() => _player.seekToNext();

  @override
  Future<void> setSpeed(double speed) => _player.setSpeed(speed);

  @override
  Future<void> stop() => _player.stop();
}

abstract class AudioPlayerService {
  Stream<List<PageInfo>> get playlistStream;
  Stream<PlaybackStateInfo> get playerStateStream;
  Stream<Duration> get positionStream;
  Stream<Duration> get durationStream;
  Stream<double> get speedStream;
  Future<void> addQueueItems(AudioDoc audioDoc);
  Future<void> play();
  Future<void> pause();
  Future<void> seek(Duration position);
  Future<void> skipToPrevious();
  Future<void> skipToNext();
  Future<void> setSpeed(double speed);
  Future<void> stop();
}

class AudioPlayerServiceImpl implements AudioPlayerService {
  final AudioHandler audioHandler = sl<AudioHandler>();
  final AudioPlayer player = sl<AudioPlayer>();

  String _getPageNum(int index) {
    return '${index + 1}';
  }

  List<MediaItem> _getMediaItemsFromPagesInAudioDoc(AudioDoc audioDoc) {
    if (audioDoc.pages.isEmpty) return [];
    final List<MediaItem> mediaItems = audioDoc.pages
        .asMap()
        .entries
        .map((e) => MediaItem(
              id: e.value.url,
              title: audioDoc.title,
              displayTitle: audioDoc.title,
              displaySubtitle: _getPageNum(e.key),
            ))
        .toList();

    return mediaItems;
  }

  @override
  Stream<List<PageInfo>> get playlistStream => audioHandler.queue.map(
        (mediaItems) {
          if (mediaItems.isEmpty) return [];
          return mediaItems
              .map((mediaItem) => PageInfo(url: mediaItem.id))
              .toList();
        },
      );

  @override
  Stream<PlaybackStateInfo> get playerStateStream =>
      audioHandler.playbackState.map((event) {
        return PlaybackStateInfo(
          processingState: {
            AudioProcessingState.idle: ProcessingStateEnum.idle,
            AudioProcessingState.buffering: ProcessingStateEnum.loading,
            AudioProcessingState.loading: ProcessingStateEnum.loading,
            AudioProcessingState.ready: ProcessingStateEnum.ready,
            AudioProcessingState.completed: ProcessingStateEnum.completed,
            AudioProcessingState.error: ProcessingStateEnum.loading,
          }[event.processingState]!,
          isPlaying: event.playing,
          bufferedPosition: event.bufferedPosition,
          updatePosition: event.updatePosition,
          position: event.position,
          speed: event.speed,
          queueIndex: event.queueIndex,
          errorMessage: event.errorMessage,
        );
      });

  @override
  Stream<Duration> get positionStream => player.positionStream;

  @override
  Stream<Duration> get durationStream =>
      player.durationStream.map((event) => event ?? Duration.zero);

  @override
  Stream<double> get speedStream => player.speedStream;

  @override
  Future<void> addQueueItems(AudioDoc audioDoc) async {
    final List<MediaItem> mediaItems =
        _getMediaItemsFromPagesInAudioDoc(audioDoc);
    await audioHandler.addQueueItems(mediaItems);
  }

  @override
  Future<void> play() => audioHandler.play();

  @override
  Future<void> pause() => audioHandler.pause();

  @override
  Future<void> seek(Duration position) => audioHandler.seek(position);

  @override
  Future<void> skipToPrevious() => audioHandler.skipToPrevious();

  @override
  Future<void> skipToNext() => audioHandler.skipToNext();

  @override
  Future<void> setSpeed(double speed) => audioHandler.setSpeed(speed);

  @override
  Future<void> stop() => audioHandler.stop();
}
