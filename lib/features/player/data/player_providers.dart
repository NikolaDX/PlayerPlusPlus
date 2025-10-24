import 'package:riverpod/riverpod.dart';
import 'player_controller.dart';
import 'music_player_state.dart';

final playerControllerProvider =
    NotifierProvider<PlayerController, MusicPlayerState>(PlayerController.new);
