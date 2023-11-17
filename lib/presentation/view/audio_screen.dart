
import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Rx;
import 'package:just_audio/just_audio.dart';
import '../../domain/models/music_model.dart';
import '../../domain/models/postion_data_model.dart';
import '../../utlis/all_colors/all_color_screen.dart';
import '../getx_controllers/favour_controller.dart';
import '../widgets/controls_player.dart';
import '../widgets/music_img_desc_widget.dart';
import 'package:rxdart/rxdart.dart';

class AudioScreen extends StatefulWidget {
  final int index;
  final List<MusicModel> list;

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

  @override
  void initState() {
    super.initState();
    favourController.listMusicModel.value = widget.list;
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
    print('ISSHUFF METHOD WORKING $isTrue');
  }

  int? cs = 1;

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavourController>(
        init: FavourController(),
        builder: (controller) {
          isShuff(controller.isShuffle.value);
          return SafeArea(
            child: Scaffold(
              backgroundColor: AllColors.backColor,
              appBar: AppBar(
                backgroundColor: AllColors.backColor,
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
                    padding: const EdgeInsets.only(bottom: 40),
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            alignment: Alignment.bottomLeft,
                            padding: const EdgeInsets.only(bottom: 16),
                            child: IconButton(
                                onPressed: () {
                                  controller.shuffle();
                                  print(
                                      'AUDIO SCREEN ${controller.isShuffle.value}');
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
                                total: positionData?.duration ?? Duration.zero,
                                buffered: positionData?.befferedPosition ??
                                    Duration.zero,
                                onSeek: audioPlayer.seek,
                              );
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        Controls(
                          audioPlayer: audioPlayer,
                          controller: controller,
                          list: widget.list,
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
          );
        });
  }
}
