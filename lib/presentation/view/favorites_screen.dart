import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/domain/models/boxes.dart';
import 'package:music_app/domain/models/music_model.dart';
import 'package:music_app/presentation/getx_controllers/favour_controller.dart';
import 'package:music_app/presentation/view/audio_screen.dart';
import 'package:music_app/utlis/resources/all_text_screen.dart';
import 'package:music_app/utlis/toast_message/toast_class.dart';
import 'package:music_app/utlis/toast_message/toast_message_screen.dart';

import '../../utlis/all_colors/all_color_screen.dart';

class FavourScreen extends StatefulWidget {
  const FavourScreen({super.key});

  @override
  State<FavourScreen> createState() => _FavourScreenState();
}

class _FavourScreenState extends State<FavourScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColors.backColor,
      body: GetBuilder(
        init: FavourController(),
        builder: (FavourController controller) {
          print('Working');
          List<MusicModel> musicModel = [];
          return boxMusics.values.isEmpty
              ? const Center(
                  child: Text(
                    AllText.emptyMusic,
                    style: TextStyle(color: AllColors.iconWhiteColor),
                  ),
                )
              : ListView.builder(
                  itemCount: boxMusics.length,
                  itemBuilder: (BuildContext context, int index) {
                    final MusicModel musicModel1 = (boxMusics.getAt(index));
                    musicModel.add(musicModel1);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AudioScreen(
                                    index: index, list: musicModel)));
                      },
                      child: Card(
                        color: AllColors.topColor,
                        child: ListTile(
                          visualDensity: const VisualDensity(vertical: 2),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              musicModel[index].author.toString(),
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
                              musicModel[index].name.toString(),
                              style: const TextStyle(
                                  color: Colors.white60,
                                  letterSpacing: 1,
                                  fontFamily: 'textFonts',
                                  fontSize: 14),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: AllColors.iconWhiteColor,
                            ),
                            onPressed: () {
                              setState(() {
                                boxMusics.deleteAt(index);
                                if(boxMusicsList.containsKey(musicModel[index].author)){
                                  List aList=boxMusicsList.get(musicModel[index].author);
                                  for (var element in aList) {
                                    if(element.name==musicModel[index].name){
                                      element.isLike=false;
                                      boxMusicsList.put(aList.first.author, aList);
                                      break;
                                    }
                                  }
                                }
                              });
                              toastMessage(ToastClass.del);



                            },
                          ),
                          titleAlignment: ListTileTitleAlignment.center,
                          titleTextStyle: const TextStyle(
                              color: AllColors.iconWhiteColor,
                              letterSpacing: 1),
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              index + 1 < 10
                                  ? Text(
                                      '${index + 1} ',
                                      style: const TextStyle(
                                          color: AllColors.iconWhiteColor,
                                          fontSize: 15,
                                          fontFamily: 'textfonts'),
                                    )
                                  : Text('${index + 1}',
                                      style: const TextStyle(
                                          color: AllColors.iconWhiteColor,
                                          fontSize: 15,
                                          fontFamily: 'textfonts')),
                              const SizedBox(
                                width: 8,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  musicModel[index].imgUrl.toString(),
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
                  });
        },
      ),
    );
  }
}
