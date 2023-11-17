import 'package:flutter/material.dart';
import 'package:music_app/utlis/all_colors/all_color_screen.dart';

import '../../domain/models/music_model.dart';
import '../view/audio_screen.dart';

class PlayListScreen extends StatelessWidget {
  final List<MusicModel> list;

  const PlayListScreen({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AudioScreen(index: index, list: list)));
            },
            child: Card(
              color: Colors.grey,
              child: ListTile(
                visualDensity: const VisualDensity(vertical: 2),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    list[index].author.toString(),
                    style: const TextStyle(
                        height: 1,
                        fontSize: 16,
                        fontFamily: 'textFonts',
                        letterSpacing: 1),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    list[index].name.toString(),
                    style: const TextStyle(
                        color: AllColors.iconWhiteColor,
                        letterSpacing: 1,
                        fontFamily: 'textFonts',
                        fontSize: 14),textAlign: TextAlign.left,
                  ),
                ),
                trailing: const Text('3.14'),
                titleAlignment: ListTileTitleAlignment.center,
                titleTextStyle: const TextStyle(
                    color: AllColors.iconWhiteColor, letterSpacing: 1),
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    index + 1 < 10
                        ? Text('${index + 1} ')
                        : Text('${index + 1}'),
                    const SizedBox(
                      width: 8,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        list[index].imgUrl.toString(),
                        fit: BoxFit.cover,
                        height: 50,
                        width: 50,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
