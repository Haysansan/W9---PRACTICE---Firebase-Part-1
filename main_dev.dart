import 'package:provider/provider.dart';

import 'data/repositories/songs/song_repository_firebase.dart';
import 'data/repositories/songs/song_with_artist_repository.dart';
import 'data/repositories/songs/song_with_artist_repository_firebase.dart';
import 'main_common.dart';
import 'data/repositories/settings/app_settings_repository_mock.dart';
import 'data/repositories/songs/song_repository.dart';
import 'ui/states/player_state.dart';
import 'ui/states/settings_state.dart';
import 'data/repositories/artists/artist_repository.dart';
import 'data/repositories/artists/artist_repository_firebase.dart';

/// Configure provider dependencies for dev environment
List<InheritedProvider> get devProviders {
  final appSettingsRepository = AppSettingsRepositoryMock();
  final songRepository = SongRepositoryFirebase();
  final artistRepository = ArtistRepositoryFirebase();

  return [

    // 1 - Inject the song repository
    Provider<SongRepository>(create: (_) => songRepository),

    // 2 - Inject the player state
    ChangeNotifierProvider<PlayerState>(create: (_) => PlayerState()),

    // 3 - Inject the  app setting state
    ChangeNotifierProvider<AppSettingsState>(
      create: (_) => AppSettingsState(repository: appSettingsRepository),
    ),

    // 4 - Inject the artist repository
    Provider<ArtistRepository>(create: (_) => artistRepository),

    // 5 - Inject the song with artist repository
    Provider<SongWithArtistRepository>(
      create: (_) => SongWithArtistRepositoryFirebase(
        songRepository: songRepository,
        artistRepository: artistRepository,
      ),
    ),
  ];
}

void main() {
  mainCommon(devProviders);
}
