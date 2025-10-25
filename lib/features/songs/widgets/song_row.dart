import 'package:flutter/material.dart';
import 'package:player_plus_plus/features/songs/models/song.dart';

class SongRow extends StatelessWidget {
  const SongRow({super.key, required this.song});

  final Song song;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (song.image != null)
          Image.memory(song.image!, width: 60, fit: BoxFit.cover),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(song.title), Text(song.artist)],
        ),
      ],
    );
  }
}
