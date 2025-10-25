import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:player_plus_plus/features/player/controllers/player_providers.dart';
import 'package:player_plus_plus/features/songs/models/song.dart';
import 'package:player_plus_plus/features/songs/widgets/song_row.dart';

class SongsList extends ConsumerWidget {
  const SongsList({super.key, required this.songs});

  final List<Song> songs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.read(playerControllerProvider.notifier);

    return ListView.builder(
      itemCount: songs.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            player.playSong(songs[index]);
          },
          child: SongRow(song: songs[index]),
        );
      },
    );
  }
}
