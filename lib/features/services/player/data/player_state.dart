import 'package:metadata_god/metadata_god.dart';

class PlayerState {
  final String? filePath;
  final Metadata? metadata;
  final double position;
  final double duration;
  final bool isPlaying;

  const PlayerState({
    this.filePath,
    this.metadata,
    this.position = 0.0,
    this.duration = 0.0,
    this.isPlaying = false,
  });

  PlayerState copyWith({
    String? filePath,
    Metadata? metadata,
    double? position,
    double? duration,
    bool? isPlaying
  }) {
    return PlayerState(
      filePath: filePath ?? this.filePath,
      metadata: metadata ?? this.metadata,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}