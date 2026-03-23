import '../../../model/songs/song_with_artist.dart';

abstract class SongWithArtistRepository {
  Future<List<SongWithArtist>> fetchSongsWithArtists();
}
