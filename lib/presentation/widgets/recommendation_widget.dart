import 'package:flutter/material.dart';
import 'package:music_app/utlis/resources/top_music_list/music_list.dart';

import '../../utlis/resources/recommend_list_image.dart';

class RecommendWidget extends StatelessWidget {
  final int index;
  final double width;

  const RecommendWidget({super.key, required this.index, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              listImage[index],
              fit: BoxFit.cover,
              height: 140,
              width: width,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            '${topSonger[index].first.author}\ ',
            maxLines: 10,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontFamily: 'textFont'),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            '${topSonger[index].length} Songs\ ',
            maxLines: 10,
            style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
                fontFamily: 'textFont',
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
