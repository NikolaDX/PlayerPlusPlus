import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:player_plus_plus/features/files/data/file_service.dart';
import 'package:player_plus_plus/features/player/data/player_providers.dart';
import 'package:player_plus_plus/screens/albums/album_screen.dart';

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
  List<String> albums = [];

  @override
  Widget build(BuildContext context) {
    final playerState = ref.watch(playerControllerProvider);
    final player = ref.read(playerControllerProvider.notifier);

    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final files = await FileService().selectDirectoryAndScan();
                setState(() {
                  albums = files.map((f) => f.path.toString()).toList();
                });
              },
              child: const Text('Scan directory'),
            ),

            Expanded(child: AlbumScreen(albums: albums)),

            Slider(
              value: playerState.position.clamp(0, playerState.duration),
              max: playerState.duration > 0 ? playerState.duration : 1,
              onChanged: (value) => player.seek(value),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    playerState.isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                  onPressed: player.togglePlayPause,
                ),
                IconButton(
                  icon: const Icon(Icons.stop),
                  onPressed: player.stop,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
