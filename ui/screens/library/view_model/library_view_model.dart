import 'package:flutter/material.dart';
import '../../../../data/repositories/songs/song_with_artist_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song_with_artist.dart';
import '../../../utils/async_value.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongWithArtistRepository songWithArtistRepository;
  final PlayerState playerState;

  AsyncValue<List<SongWithArtist>> songsValue = AsyncValue.loading();

  LibraryViewModel({required this.songWithArtistRepository, required this.playerState}) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    fetchSong();
  }

  void fetchSong() async {
    // 1- Loading state
    songsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch is successfull
      List<SongWithArtist> songsWithArtists = await songWithArtistRepository.fetchSongsWithArtists();
      songsValue = AsyncValue.success(songsWithArtists);
    } catch (e) {
      // 3- Fetch is unsucessfull
      songsValue = AsyncValue.error(e);
    }
     notifyListeners();

  }

  bool isSongPlaying(SongWithArtist songWithArtist) => playerState.currentSong == songWithArtist.song;

  void start(SongWithArtist songWithArtist) => playerState.start(songWithArtist.song);
  void stop(SongWithArtist songWithArtist) => playerState.stop();
}
