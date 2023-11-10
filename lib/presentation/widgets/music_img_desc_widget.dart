import 'package:flutter/material.dart';

import '../../domain/models/music_model.dart';
class MusicImgWidget extends StatelessWidget {
  const MusicImgWidget({
    super.key,
    required this.musicList,
    required this.index,
  });

  final int? index;
  final List<MusicModel> musicList;

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 36),
          height: size.height * 0.4,
          width: size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              image: DecorationImage(
                image: AssetImage(musicList[index ?? 0].imgUrl),
                fit: BoxFit.cover,
              ),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(4, 8),
                  color: Colors.white12,
                  blurRadius: 1,
                )
              ]
          ),
        ),
        const SizedBox(height: 38,),
        Text(
          musicList[index ?? 0].author,
          style:const  TextStyle(
              color: Colors.white,
              fontFamily: 'textFont',
              fontSize: 22,
              letterSpacing: 1),
        ),
        const SizedBox(height: 7,),
        Text(
          musicList[index ?? 0].name,
          style:const  TextStyle(
              color: Colors.white70,
              fontFamily: 'textFont',
              fontSize: 20,
              letterSpacing: 1),
        ),
      ],
    );
  }
}