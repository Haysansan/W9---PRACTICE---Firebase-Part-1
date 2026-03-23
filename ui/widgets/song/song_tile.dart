import 'package:flutter/material.dart';

import '../../../model/songs/song_with_artist.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.songWithArtist,
    required this.isPlaying,
    required this.onTap,
  });

  final SongWithArtist songWithArtist;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
        ),
        child: ListTile(
          onTap: onTap,
          leading: ClipOval(
            child: Image.network(
              '${songWithArtist.artist.imageUrl}',
              width: 45,
              height: 45,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(songWithArtist.song.title),
          subtitle: Text(
            '${songWithArtist.song.duration.inMinutes} mins ${songWithArtist.artist.name} - ${songWithArtist.artist.genre}',
            style: TextStyle(fontSize: 12, color: Colors.grey),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(
            isPlaying ? "Playing" : "",
            style: TextStyle(color: Colors.amber),
          ),
        ),
      ),
    );
  }
}
