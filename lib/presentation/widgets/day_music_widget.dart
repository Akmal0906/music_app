import 'package:flutter/material.dart';

import '../../utlis/resources/recommend_list_image.dart';
import '../../utlis/resources/top_music_list/music_list.dart';
class DayMusicWidget extends StatelessWidget {
  final int index;
  const DayMusicWidget({
    super.key,required this.index
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 22, bottom: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              listImage[index],
              fit: BoxFit.cover,
              height: 100,
              width: 100,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dayMusic[index].name,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'textFont',
                    fontSize: 20),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                dayMusic[index].author,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'textFont',
                    fontSize: 20),
              ),
            ],
          )
        ],
      ),
    );
  }
}