import 'package:flutter/material.dart';
import 'package:music_app/domain/models/boxes.dart';
import 'package:music_app/presentation/view/audio_screen.dart';
import 'package:music_app/presentation/view/play_list_screen.dart';
import 'package:music_app/presentation/widgets/recommendation_widget.dart';
import 'package:music_app/utlis/all_colors/all_color_screen.dart';
import 'package:music_app/utlis/resources/all_text_screen.dart';
import 'package:music_app/utlis/resources/top_music_list/music_list.dart';
import '../widgets/day_music_widget.dart';
import '../widgets/first_header_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AllColors.backColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FirstHeader(),
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
                itemCount: topSonger.length-4,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PlayListScreen(
                                list: topSonger[index],
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
                itemCount: topSonger.length-4,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PlayListScreen(
                                list: topSonger[index],
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
                                  list: boxMusicsList
                                          .containsKey(dayMusic.first.author)
                                      ? boxMusicsList.get(dayMusic.first.author)
                                      : dayMusic,
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
