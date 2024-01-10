import 'package:flutter/material.dart';

import '../../domain/models/music_model.dart';
import '../../utlis/resources/recommend_list_image.dart';
class SearchScreenWidget extends StatelessWidget {
  final int index;
  const SearchScreenWidget({
    super.key,
    required this.list,
    required this.index
  });

  final List<List<MusicModel>> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Image.asset(
            listImage2[index],
            fit: BoxFit.cover,
            height: 100,
            width: 100,
          ),
        ),
        Text(
          list[index][0].author,
          style:  TextStyle(

              color:index<4? Colors.white:Colors.white70,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'textFont'),
        ),
        Text(
          index < 4
              ? '${list[index].length} music'
              : 'No musics',
          style:  TextStyle(
              color:index<4? Colors.white:Colors.white54,
              fontFamily: 'textFont',
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),

      ],
    );
  }
}
