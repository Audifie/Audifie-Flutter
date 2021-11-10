import 'package:equatable/equatable.dart';

class PlaybackStateInfo extends Equatable {
  final ProcessingStateEnum processingState;
  final bool isPlaying;
  final Duration bufferedPosition;

  /// For efficiency, the [updatePosition] should NOT be updated continuously in
  /// real time. Instead, it should be updated only when the normal continuity
  /// of time is disrupted, such as during a seek, buffering and seeking.
  final Duration updatePosition;
  final Duration position;
  final double speed;
  final int? queueIndex;
  final String? errorMessage;

  PlaybackStateInfo({
    required this.processingState,
    required this.isPlaying,
    required this.bufferedPosition,
    required this.updatePosition,
    required this.position,
    required this.speed,
    required this.queueIndex,
    this.errorMessage
  });

  @override
  List<Object?> get props => [
        processingState,
        isPlaying,
        bufferedPosition,
        updatePosition,
        position,
        speed,
        queueIndex,
      ];
}

enum ProcessingStateEnum { idle, loading, ready, completed, error }
