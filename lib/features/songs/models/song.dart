import 'dart:typed_data';

import 'package:metadata_god/metadata_god.dart';

class Song {
  final String path;
  final String title;
  final String album;
  final String artist;
  final Uint8List? image;

  Song({
    required this.path,
    required this.title,
    required this.album,
    required this.artist,
    this.image,
  });

  static Song buildFromMetadata(String path, Metadata metadata) {
    return Song(
      path: path,
      title: metadata.title ?? path,
      album: metadata.album ?? 'Unknown Album',
      artist: metadata.artist ?? 'Unknown Artist',
      image: metadata.picture?.data,
    );
  }
}
