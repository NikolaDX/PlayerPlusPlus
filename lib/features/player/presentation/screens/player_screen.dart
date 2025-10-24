import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/player_providers.dart';

class PlayerView extends ConsumerWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(playerControllerProvider);
    final controller = ref.read(playerControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Audio Player')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (state.metadata != null)
            Text(state.metadata!.title ?? 'Unknown Track'),
          Text(state.isPlaying ? 'Playing' : 'Paused'),
          IconButton(
            icon: Icon(state.isPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: controller.togglePlayPause,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.playFile('/storage/emulated/0/Music/song.mp3'),
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
