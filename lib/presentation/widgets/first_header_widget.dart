import 'package:flutter/material.dart';

import '../../utlis/all_colors/all_color_screen.dart';
import '../../utlis/resources/all_text_screen.dart';
class FirstHeader extends StatelessWidget {
  const FirstHeader({
    super.key,

  });


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(
          bottom: 23, left: 22, right: 22, top: 40),
      width: size.width,
      decoration: const BoxDecoration(
          color: AllColors.topColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: const TextSpan(children: [
                      TextSpan(
                          text: AllText.topText,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'textFont',
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: AllText.topText2,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'textFont',
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                    ])),
                const SizedBox(height: 8),
                const Text(AllText.topText3,
                    maxLines: 6,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'textFont',
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(
            width: 48,
          ),
          const Image(
            image: AssetImage(
              'assets/images/img.png',
            ),
            fit: BoxFit.cover,
            height: 48,
            width: 48,
          )
        ],
      ),
    );
  }
}