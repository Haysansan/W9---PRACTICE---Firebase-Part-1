import 'package:flutter/material.dart';
import '../../../data/repositories/artists/artist_repository.dart';
import '../../../ui/screens/artists/view_model/artist_view_model.dart';
import 'widgets/artist_content.dart';
import '../../../ui/states/player_state.dart';
import 'package:provider/provider.dart';

class ArtistScreen extends StatelessWidget {
  const ArtistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ArtistViewModel(
        artistRepository: context.read<ArtistRepository>(),
        playerState: context.read<PlayerState>(),
      ),
      child: ArtistContent(),
    );
  }
}