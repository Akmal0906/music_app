import 'package:flutter/material.dart';

import '../../utlis/resources/recommend_list_image.dart';
class RecommendWidget extends StatelessWidget {
  final int index;
  final double width;
  const RecommendWidget({super.key,required this.index,required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(left: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(listImage[index],fit: BoxFit.cover,height: 140,
            width: width,),
          ),
         const SizedBox(height: 16,),
          
         const Text('Night Vocals\ ',maxLines:10,style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'textFont'),),
         const SizedBox(height: 4,),

          Text('30 Songs 1 hour\ ',maxLines:10,style: TextStyle(color: Colors.grey.shade600,fontSize: 16,fontFamily: 'textFont',fontWeight: FontWeight.bold),),
        ],
      ),


    );
  }
}
