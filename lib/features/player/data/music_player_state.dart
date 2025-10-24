import 'package:metadata_god/metadata_god.dart';

class MusicPlayerState {
  final String? filePath;
  final Metadata? metadata;
  final double position;
  final double duration;
  final bool isPlaying;

  const MusicPlayerState({
    this.filePath,
    this.metadata,
    this.position = 0.0,
    this.duration = 0.0,
    this.isPlaying = false,
  });

  MusicPlayerState copyWith({
    String? filePath,
    Metadata? metadata,
    double? position,
    double? duration,
    bool? isPlaying
  }) {
    return MusicPlayerState(
      filePath: filePath ?? this.filePath,
      metadata: metadata ?? this.metadata,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}