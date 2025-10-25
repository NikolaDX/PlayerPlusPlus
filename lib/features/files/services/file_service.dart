import 'dart:io';
import 'dart:developer' as developer;
import 'package:file_picker/file_picker.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:path/path.dart' as p;
import 'package:player_plus_plus/features/songs/models/song.dart';

const List<String> commonAudioExtensions = [
  'mp3', 'flac', 'wav', 'aiff', 'aif', 'm4a', 'aac', 
  'ogg', 'opus', 'alac', 'wma', 'mpc', 'ape', 'wv'
];

class FileService {
  Future<List<File>> scanAudioFilesRecursively(String rootPath) async {
    final List<File> audioFiles = [];
    final Directory rootDir = Directory(rootPath);

    if (!await rootDir.exists()) {
      developer.log('Error: Directory not found at $rootPath');
      return audioFiles;
    }

    await for (var entity in rootDir.list(recursive: true, followLinks: false)) {
      if (entity is File) {
        final String extension = p.extension(entity.path).toLowerCase();
        final String cleanedExtension = extension.replaceFirst('.', '');

        if (commonAudioExtensions.contains(cleanedExtension)) {
          audioFiles.add(entity);
        }
      }
    }

    return audioFiles;
  }

  Future<List<File>> selectDirectoryAndScan() async {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

      if (selectedDirectory != null) {
        developer.log('Starting scan in: $selectedDirectory');
        List<File> allAudio = await scanAudioFilesRecursively(selectedDirectory);
        developer.log('Found ${allAudio.length} audio files.');
        return allAudio;
      } else {
        developer.log('Directory scan cancelled.');
        return [];
      }
  }

  Future<List<Song>> filesToSongs(List<File> files) async {
    final List<Song> songs = [];
    for (var file in files) {
      final metadata = await MetadataGod.readMetadata(file: file.path);
      final song = Song.buildFromMetadata(file.path, metadata);
      songs.add(song);
    }
    return songs;
  }
}