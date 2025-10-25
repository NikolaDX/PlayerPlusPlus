import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glass/glass.dart';
import 'package:player_plus_plus/features/player/controllers/player_providers.dart';

class MiniPlayer extends ConsumerWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var playerState = ref.watch(playerControllerProvider);
    final player = ref.read(playerControllerProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 150,
      child: Column(
        children: [
          Row(
            children: [
              if (playerState.currentSong != null)
                if (playerState.currentSong!.image != null)
                  Image.memory(
                    playerState.currentSong!.image!,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
              SizedBox(width: 25),
              if (playerState.currentSong != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(playerState.currentSong!.title),
                    Text(playerState.currentSong!.artist),
                  ],
                ),
            ],
          ),
          Slider(
            value: playerState.position.clamp(0, playerState.duration),
            max: playerState.duration > 0 ? playerState.duration : 1,
            onChanged: (value) => player.seek(value),
          ),
        ],
      ),
    ).asGlass(
      clipBorderRadius: BorderRadius.circular(15.0)
    );
  }
}
