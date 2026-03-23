import '../../../model/songs/song_with_artist.dart';
import '../artists/artist_repository.dart';
import '../songs/song_repository.dart';
import 'song_with_artist_repository.dart';

class SongWithArtistRepositoryFirebase extends SongWithArtistRepository {
  final SongRepository songRepository;
  final ArtistRepository artistRepository;

  SongWithArtistRepositoryFirebase({
    required this.songRepository,
    required this.artistRepository,
  });

@override
Future<List<SongWithArtist>> fetchSongsWithArtists() async {
  final songsAndArtists = await Future.wait([
    songRepository.fetchSongs(),
    artistRepository.fetchArtists(),
  ]);

  final songs = songsAndArtists[0] as List;
  final artists = songsAndArtists[1] as List;

  // 1 - Join songs with artists
  return _joinSongsWithArtists(songs, artists);
}

List<SongWithArtist> _joinSongsWithArtists(List songs, List artists) {
  final artistMap = {for (var artist in artists) artist.id: artist};

  return songs
      .map((song) => _createSongWithArtist(song, artistMap))
      .toList();
}

SongWithArtist _createSongWithArtist(song, Map artistMap) {
  final artist = artistMap[song.artistId];
  if (artist == null) {
    throw Exception('Artist with id ${song.artistId} not found');
  }
  return SongWithArtist(song: song, artist: artist);
}
}
