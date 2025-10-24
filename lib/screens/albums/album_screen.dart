import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:player_plus_plus/features/player/data/player_providers.dart';

class AlbumScreen extends ConsumerWidget {
  const AlbumScreen({super.key, required this.albums});

  final List<String> albums;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.read(playerControllerProvider.notifier);

    return ListView.builder(
      itemCount: albums.length,
      itemBuilder: (context, index) {
        final path = albums[index];
        return ElevatedButton(
          onPressed: () async {
            await player.playFile(path);
          },
          child: Text(path),
        );
      },
    );
  }
}
