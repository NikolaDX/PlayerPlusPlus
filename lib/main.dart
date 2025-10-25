import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:player_plus_plus/features/files/services/file_service.dart';
import 'package:player_plus_plus/features/player/widgets/mini_player.dart';
import 'package:player_plus_plus/features/songs/models/song.dart';
import 'package:player_plus_plus/features/songs/widgets/songs_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MetadataGod.initialize();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  List<Song> songs = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final files = await FileService().selectDirectoryAndScan();
                    final newSongs = await FileService().filesToSongs(files);
                    if (newSongs.isNotEmpty) {
                      setState(() {
                        songs = newSongs;
                      });
                    }
                  },
                  child: const Text('Scan directory'),
                ),
                Expanded(
                  child: SongsList(songs: songs),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: const MiniPlayer(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
