import 'package:flutter/material.dart';
import '../../../../data/repositories/artists/artist_repository.dart';
import '../../../../model/artists/artist.dart';
import '../../../../ui/states/player_state.dart';
import '../../../../ui/utils/async_value.dart';

class ArtistViewModel extends ChangeNotifier {
  final ArtistRepository artistRepository;
  final PlayerState playerState;

  AsyncValue<List<Artist>> artistValue = AsyncValue.loading();

  ArtistViewModel({required this.artistRepository, required this.playerState}) {
    playerState.addListener(notifyListeners);

    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    fetchArtists();
  }

  void fetchArtists() async {
    artistValue = AsyncValue.loading();
    notifyListeners();

    try {
      List<Artist> artists = await artistRepository.fetchArtists();
      artistValue = AsyncValue.success(artists);
    } catch (e) {
      artistValue = AsyncValue.error(e);
    }
    notifyListeners();
  }
}