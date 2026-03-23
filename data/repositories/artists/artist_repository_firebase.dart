import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../model/artists/artist.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';


class ArtistRepositoryFirebase extends ArtistRepository {
  final Uri artistUri = Uri.https(
    'w9-practice-firebase-rest-api-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/artists.json',
  );

  @override
  Future<List<Artist>> fetchArtists() async {
    final http.Response response = await http.get(artistUri);

    if (response.statusCode == 200) {
      Map<String, dynamic> artistJson = json.decode(response.body);
      return artistJson.entries
          .map((artist) => ArtistDto.fromJson(artist.key, artist.value))
          .toList();
    } else {
      throw Exception('Fail to load artist');
    }
  }

  @override
  Future<Artist?> fetchAristsById(String id) async {
    throw UnimplementedError();
  }
}