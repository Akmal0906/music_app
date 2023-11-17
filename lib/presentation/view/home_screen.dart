import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:music_app/presentation/view/audio_screen.dart';
import 'package:music_app/presentation/widgets/recommendation_widget.dart';
import 'package:music_app/utlis/all_colors/all_color_screen.dart';
import 'package:music_app/utlis/resources/all_text_screen.dart';
import 'package:music_app/utlis/resources/recommend_list_image.dart';
import 'package:music_app/utlis/resources/top_music_list/music_list.dart';
import '../widgets/day_music_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print('Home Screen working');
    return Scaffold(
      extendBody: true,
      backgroundColor: AllColors.backColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
                        // const SizedBox(height: 8,),
                        const Gap(8),
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
            ),
            const SizedBox(
              height: 27,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22, bottom: 8),
              child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    AllText.recomend,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'textFont',
                        fontSize: 20,
                        letterSpacing: 1),
                  )),
            ),
            SizedBox(
              height: 260,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listImage.length,
                itemBuilder: (context, index) {
                  return RecommendWidget(
                    index: index,
                    width: 220,
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 22.0, bottom: 12),
              child: Text(
                AllText.topMusic,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'textFont',
                    letterSpacing: 1,
                    fontSize: 20),
              ),
            ),
            SizedBox(
              height: 260,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listImage.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AudioScreen(
                                index: index,
                                list: dayMusic,
                              )));
                    },
                    child: RecommendWidget(
                      index: index,
                      width: 160,
                    ),
                  );
                },
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dayMusic.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AudioScreen(
                                  index: index,
                                  list: dayMusic,
                                )));
                      },
                      child: DayMusicWidget(
                        index: index,
                      ));
                })
          ],
        ),
      ),
    );
  }
}
