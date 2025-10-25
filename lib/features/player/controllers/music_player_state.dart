import 'package:player_plus_plus/features/songs/models/song.dart';

class MusicPlayerState {
  final Song? currentSong;
  final double position;
  final double duration;
  final bool isPlaying;

  const MusicPlayerState({
    this.currentSong,
    this.position = 0.0,
    this.duration = 0.0,
    this.isPlaying = false,
  });

  MusicPlayerState copyWith({
    Song? currentSong,
    double? position,
    double? duration,
    bool? isPlaying
  }) {
    return MusicPlayerState(
      currentSong: currentSong ?? this.currentSong,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}