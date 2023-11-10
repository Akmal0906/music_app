import 'package:flutter/material.dart';
import 'package:music_app/domain/models/boxes.dart';
import 'package:music_app/domain/models/music_model.dart';

import '../../data/local_storage/liked_musics_storage.dart';

class FavourScreen extends StatefulWidget {
  const FavourScreen({super.key});

  @override
  State<FavourScreen> createState() => _FavourScreenState();
}

class _FavourScreenState extends State<FavourScreen> {
  @override
  void initState() {
    super.initState();
    Storage().storeMusic(
      MusicModel(
          name: 'Muhabbat',
          author: 'Rayhon',
          path: 'assets/musics/Love_On_Me.mp3',
          imgUrl: 'assets/images/recommend_music2.jpg'),
    );
    Storage().storeMusic(
      MusicModel(
          name: 'Sevgi',
          author: 'Rayhon',
          path: 'assets/musics/Love_On_Me.mp3',
          imgUrl: 'assets/images/recommend_music2.jpg'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: boxMusics.length,
      itemBuilder: (BuildContext context, int index) {
        MusicModel musicModel = boxMusics.getAt(index);
        return ListTile(
          title: Text(musicModel.author),
          subtitle: Text(musicModel.name),
          leading: IconButton(
            onPressed: () {
              setState(() {
                Storage().deleteMusic(index);
              });
            },
            icon: const Icon(Icons.remove),
          ),
        );
      },
    );
  }
}
