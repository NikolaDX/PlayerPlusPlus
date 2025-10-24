import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;

const List<String> commonAudioExtensions = [
  'mp3', 'flac', 'wav', 'aiff', 'aif', 'm4a', 'aac', 
  'ogg', 'opus', 'alac', 'wma', 'mpc', 'ape', 'wv'
];

class FileService {
  Future<List<File>> scanAudioFilesRecursively(String rootPath) async {
    final List<File> audioFiles = [];
    final Directory rootDir = Directory(rootPath);

    if (!await rootDir.exists()) {
      print('Error: Directory not found at $rootPath');
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
        print('Starting scan in: $selectedDirectory');
        List<File> allAudio = await scanAudioFilesRecursively(selectedDirectory);
        print('Found ${allAudio.length} audio files.');
        return allAudio;
      } else {
        print('Directory scan cancelled.');
        return [];
      }
  }
}