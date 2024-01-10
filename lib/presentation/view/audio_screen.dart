
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Rx;
import 'package:just_audio/just_audio.dart';
import 'package:music_app/data/local_storage/liked_musics_storage.dart';
import 'package:music_app/domain/models/boxes.dart';
import 'package:music_app/domain/models/music_model.dart';
import 'package:music_app/utlis/toast_message/toast_class.dart';
import 'package:music_app/utlis/toast_message/toast_message_screen.dart';

import '../../domain/models/postion_data_model.dart';
import '../../utlis/all_colors/all_color_screen.dart';
import '../getx_controllers/favour_controller.dart';
import '../widgets/controls_player.dart';
import '../widgets/music_img_desc_widget.dart';
import 'package:rxdart/rxdart.dart';

class AudioScreen extends StatefulWidget {
  final int index;
  final List list;

  const AudioScreen({super.key, required this.index, required this.list});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen>
    with SingleTickerProviderStateMixin {
  late AudioPlayer audioPlayer = AudioPlayer();
  FavourController favourController = Get.put(FavourController());

  Stream<PositionModel> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionModel>(
          audioPlayer.positionStream,
          audioPlayer.bufferedPositionStream,
          audioPlayer.durationStream,
          (position, bufferedPosition, duration) => PositionModel(
              position: position,
              befferedPosition: bufferedPosition,
              duration: duration ?? const Duration(seconds: 0)));
  bool isSave = false;

  @override
  void initState() {
    super.initState();
    favourController.listMusicModel.value = widget.list;
    favourController.indexx.value = widget.index;
    if (boxMusics.isNotEmpty && boxMusics.length == widget.list.length) {
      List eptyList = [];

      for (int i = 0; i < boxMusics.length; i++) {
        final MusicModel model = boxMusics.getAt(i);
        eptyList.add(model);
      }

      if (eptyList.every((element) => widget.list.contains(element))) {

        isSave = true;
      } else {


        isSave = false;
      }
    } else {

      isSave = false;
    }

    audioPlayer = AudioPlayer();
    final playList = ConcatenatingAudioSource(
        shuffleOrder: DefaultShuffleOrder(),
        useLazyPreparation: true,
        children: List.generate(widget.list.length, (index) {
          return AudioSource.asset(widget.list[index].path.toString());
        }).toList());
    init(playList);
    audioPlayer.play();
  }

  Future init(AudioSource playList) async {
    await audioPlayer.setLoopMode(LoopMode.all);
    await audioPlayer.setAudioSource(playList);
    await audioPlayer.seek(Duration.zero, index: widget.index);
  }

  Future isShuff(bool isTrue) async {
    await audioPlayer.setShuffleModeEnabled(isTrue);
  }

  int? cs = 1;

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          if (!isSave) {
            boxMusicsList.put(widget.list.first.author,
                favourController.listMusicModel.value);
          } else {
            for (int i = 0; i < favourController.listMusicModel.length; i++) {
              if (boxMusicsList
                  .containsKey(favourController.listMusicModel[i].author)) {
                List aList = boxMusicsList
                    .get(favourController.listMusicModel[i].author);
                for (var element in aList) {
                  if (element.name == favourController.listMusicModel[i].name) {
                    element.isLike = favourController.listMusicModel[i].isLike;
                    boxMusicsList.put(aList.first.author, aList);
                    break;
                  }
                }
              }
            }
          }
        }
      },
      child: GetBuilder<FavourController>(
          init: FavourController(),
          builder: (FavourController controller) {
            isShuff(controller.isShuffle.value);
            return SafeArea(
              child: Scaffold(
                backgroundColor: AllColors.backColor,
                appBar: AppBar(
                  backgroundColor: AllColors.backColor,
                  leading: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: AllColors.iconWhiteColor),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  title: const Text(
                    'Music',
                    style: TextStyle(
                        color: AllColors.iconWhiteColor,
                        fontSize: 20,
                        fontFamily: 'textFont',
                        letterSpacing: 1),
                  ),
                  centerTitle: true,
                  elevation: 0,
                  actions: [
                    IconButton(
                      icon: Icon(
                          controller
                                  .listMusicModel[
                                      controller.indexx.value ?? widget.index]
                                  .isLike
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: (controller
                                  .listMusicModel[
                                      controller.indexx.value ?? widget.index]
                                  .isLike
                              ? Colors.red
                              : Colors.deepPurpleAccent)),
                      onPressed: () {
                        controller
                            .isFavour(controller.indexx.value ?? widget.index);
                        if (controller
                            .listMusicModel[
                                controller.indexx.value ?? widget.index]
                            .isLike) {
                          Storage().storeMusic(controller.listMusicModel[
                              controller.indexx.value ?? widget.index]);
                          toastMessage(ToastClass.ad);
                        } else {
                          boxMusics.delete(controller
                              .listMusicModel
                              .value[controller.indexx.value ?? widget.index]
                              .name);
                          toastMessage(ToastClass.del);
                        }

                      },
                    )
                  ],
                ),
                body: Column(
                  children: [
                    const SizedBox(
                      height: 44,
                    ),
                    StreamBuilder(
                        stream: audioPlayer.currentIndexStream,
                        builder: (context, snapshot) {
                          final state = snapshot.data;

                          return MusicImgWidget(
                            musicList: widget.list,
                            index: state ?? 0,
                          );
                        }),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        margin: const EdgeInsets.symmetric(horizontal: 14),
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                alignment: Alignment.bottomLeft,
                                padding: const EdgeInsets.only(bottom: 16),
                                child: IconButton(
                                    onPressed: () {
                                      controller.shuffle();
                                    },
                                    icon: Icon(
                                      Icons.shuffle_outlined,
                                      color: controller.isShuffle.value
                                          ? Colors.blue
                                          : AllColors.iconWhiteColor,
                                      size: 22,
                                    ))),
                            StreamBuilder(
                                stream: _positionDataStream,
                                builder: (context, snapshot) {
                                  final positionData = snapshot.data;
                                  return ProgressBar(
                                    barHeight: 8,
                                    baseBarColor: Colors.grey.shade600,
                                    bufferedBarColor: Colors.grey,
                                    progressBarColor: AllColors.iconWhiteColor,
                                    thumbColor: const Color(0xff0F1014),
                                    timeLabelTextStyle: const TextStyle(
                                        color: AllColors.iconWhiteColor,
                                        fontWeight: FontWeight.bold),
                                    progress:
                                        positionData?.position ?? Duration.zero,
                                    total:
                                        positionData?.duration ?? Duration.zero,
                                    buffered: positionData?.befferedPosition ??
                                        Duration.zero,
                                    onSeek: audioPlayer.seek,
                                  );
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            Controls(
                              audioPlayer: audioPlayer,
                              controller: controller,
                              list: widget.list,
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            );
          }),
    );
  }
}
