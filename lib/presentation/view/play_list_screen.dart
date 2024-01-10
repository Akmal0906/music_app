import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/domain/models/boxes.dart';
import 'package:music_app/presentation/getx_controllers/favour_controller.dart';
import 'package:music_app/utlis/all_colors/all_color_screen.dart';
import '../../domain/models/music_model.dart';
import 'audio_screen.dart';

// class PlayListScreen extends StatefulWidget {
//   final List<MusicModel> list;
//
//   const PlayListScreen({super.key, required this.list});
//
//   @override
//   State<PlayListScreen> createState() => _PlayListScreenState();
// }
//
// class _PlayListScreenState extends State<PlayListScreen> {
//   FavourController favourController = Get.put(FavourController());
//
//   check() {
//     if (!boxMusicsList.containsKey(widget.list.first.author)) {
//       print('IF 1 WORKING');
//       favourController.listMusicModel.value = widget.list;
//       boxMusicsList.put(widget.list.first.author, widget.list);
//     } else {
//       print('IF 2 WORKING');
//
//       var list = boxMusicsList.get(widget.list.first.author);
//       favourController.listMusicModel.value = list;
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     check();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AllColors.backColor,
//       body: GetBuilder(
//         init: FavourController(),
//         builder: (FavourController controller) {
//           return ListView.builder(
//             scrollDirection: Axis.vertical,
//             shrinkWrap: false,
//             itemCount: widget.list.length,
//             itemBuilder: (context, index) {
//               return Card(
//                 color: AllColors.topColor,
//                 child: ListTile(
//                   visualDensity: const VisualDensity(vertical: 2),
//                   title: Padding(
//                     padding: const EdgeInsets.only(bottom: 4.0),
//                     child: Text(
//                       widget.list[index].author.toString(),
//                       style: const TextStyle(
//                           height: 1,
//                           fontSize: 16,
//                           fontFamily: 'textFonts',
//                           letterSpacing: 1),
//                     ),
//                   ),
//                   subtitle: Padding(
//                     padding: const EdgeInsets.only(bottom: 4.0),
//                     child: Text(
//                       widget.list[index].name.toString(),
//                       style: const TextStyle(
//                           color: Colors.white60,
//                           letterSpacing: 1,
//                           fontFamily: 'textFonts',
//                           fontSize: 14),
//                       textAlign: TextAlign.left,
//                     ),
//                   ),
//                   trailing: IconButton(
//                     icon: const Icon(
//                       Icons.play_circle,
//                       color: AllColors.iconWhiteColor,
//                     ),
//                     onPressed: () {
//                       if (widget.list.isEmpty) {
//                         if (!boxMusicsList
//                             .containsKey(controller.listMusicModel.first.author)) {
//                              print('IF 1 BUTTON WORKING');
//                           boxMusicsList.put(
//                               controller.listMusicModel.first.author, widget.list);
//                         } else {
//                           print('IF 2 BUTTON WORKING');
//
//                           var list = boxMusicsList.get(controller.listMusicModel.first.author);
//                           controller.listMusicModel.value = list;
//                         }
//                       }
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => AudioScreen(
//                               index: index,
//                               list:
//                               controller.listMusicModel.value
//                           )));
//                     },
//                   ),
//                   titleAlignment: ListTileTitleAlignment.center,
//                   titleTextStyle: const TextStyle(
//                       color: AllColors.iconWhiteColor, letterSpacing: 1),
//                   leading: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       index + 1 < 10
//                           ? Text(
//                               '${index + 1} ',
//                               style: const TextStyle(
//                                   color: AllColors.iconWhiteColor,
//                                   fontSize: 15,
//                                   fontFamily: 'textfonts'),
//                             )
//                           : Text('${index + 1}',
//                               style: const TextStyle(
//                                   color: AllColors.iconWhiteColor,
//                                   fontSize: 15,
//                                   fontFamily: 'textfonts')),
//                       const SizedBox(
//                         width: 8,
//                       ),
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.asset(
//                           widget.list[index].imgUrl.toString(),
//                           fit: BoxFit.cover,
//                           height: 50,
//                           width: 50,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }








class PlayListScreen extends StatelessWidget {
  final List<MusicModel> list;

  const PlayListScreen({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    FavourController favourController = Get.put(FavourController());
    if (!boxMusicsList.containsKey(list.first.author)) {
      favourController.listMusicModel.value = list;
      boxMusicsList.put(list.first.author, list);
      print('IF ONE WORKING');
    } else {
      print('IF TWO WORKING');
      var list1 = boxMusicsList.get(list.first.author);
      favourController.listMusicModel.value = list1;
    }

    return Scaffold(
      backgroundColor: AllColors.backColor,
      body: GetBuilder(
        init: FavourController(),
        builder: (FavourController controller) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: false,
            itemCount:list.length,
            itemBuilder: (context, index) {
              return Card(
                color: AllColors.topColor,
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
                          color: Colors.white60,
                          letterSpacing: 1,
                          fontFamily: 'textFonts',
                          fontSize: 14),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.play_circle,
                      color: AllColors.iconWhiteColor,
                    ),
                    onPressed: () {
                      // if (list.isEmpty) {
                      //   if (!boxMusicsList
                      //       .containsKey(controller.listMusicModel.first.author)) {
                      //        print('IF  Button working');
                      //     boxMusicsList.put(
                      //         controller.listMusicModel.first.author,list);
                      //   } else {
                      //     var list = boxMusicsList.get(controller.listMusicModel.first.author);
                      //     controller.listMusicModel.value = list;
                      //     print('IF  Button working 2');
                      //
                      //   }
                      // }
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AudioScreen(
                              index: index,
                              list:
                              controller.listMusicModel.value
                          )));
                    },
                  ),
                  titleAlignment: ListTileTitleAlignment.center,
                  titleTextStyle: const TextStyle(
                      color: AllColors.iconWhiteColor, letterSpacing: 1),
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
                         list[index].imgUrl.toString(),
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }


}

