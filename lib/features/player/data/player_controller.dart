import 'dart:async';
import 'dart:io';
import 'package:metadata_god/metadata_god.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod/riverpod.dart';
import './music_player_state.dart';

class PlayerController extends Notifier<MusicPlayerState> {
  late final AudioPlayer _player;
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<PlayerState>? _playerStateSubscription;
  StreamSubscription<Duration?>? _durationSubscription;

  @override
  MusicPlayerState build() {
    _player = AudioPlayer();
    
    _positionSubscription = _player.onPositionChanged.listen((position) {
      state = state.copyWith(position: position.inMilliseconds.toDouble());
    });

    _playerStateSubscription = _player.onPlayerStateChanged.listen((playerState) {
      final isPlaying = playerState == PlayerState.playing;
      
      if (playerState == PlayerState.completed) {
        state = state.copyWith(isPlaying: false, position: state.duration);
      } else {
        state = state.copyWith(isPlaying: isPlaying);
      }
    });

    _durationSubscription = _player.onDurationChanged.listen((duration) {
      state = state.copyWith(duration: duration.inMilliseconds.toDouble());
    });

    ref.onDispose(() {
      _positionSubscription?.cancel();
      _playerStateSubscription?.cancel();
      _durationSubscription?.cancel();
      _player.dispose();
    });
    
    return const MusicPlayerState();
  }

  Future<void> playFile(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) return;

    final metadata = await MetadataGod.readMetadata(file: filePath);

    try {
      await _player.play(DeviceFileSource(filePath));

      state = state.copyWith(
        filePath: filePath,
        metadata: metadata,
        position: 0,
        isPlaying: true,
      );
    } catch (e) {
      print('Error playing file: $e');
    }
  }

  Future<void> togglePlayPause() async {
    if (state.isPlaying) {
      await _player.pause();
    } else {
      await _player.resume();
    }
  }

  Future<void> stop() async {
    await _player.stop();
    state = state.copyWith(isPlaying: false, position: 0);
  }

  Future<void> seek(double positionMs) async {
    await _player.seek(Duration(milliseconds: positionMs.toInt()));
  }
}