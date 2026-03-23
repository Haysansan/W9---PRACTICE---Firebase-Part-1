import '../data/repositories/artists/artist_repository.dart';
import '../data/repositories/artists/artist_repository_firebase.dart';
import '../model/artists/artist.dart';

void main() async {
  //   Instantiate the  song_repository_mock
  ArtistRepository artistRepository = ArtistRepositoryFirebase();

  List<Artist> artists = await artistRepository.fetchArtists();

  for (var artist in artists) {
    print(artist);
  }
}