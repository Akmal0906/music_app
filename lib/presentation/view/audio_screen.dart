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
  bool isLiked = false;
  int index = 0;
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
    audioPlayer = AudioPlayer();
    final playList = ConcatenatingAudioSource(
        children: List.generate(widget.list.length, (index) {
          return AudioSource.asset(widget.list[index].path);
        }).toList());
    init(playList);
    audioPlayer.play();WidgetsBinding.instance.addPostFrameCallback((_) {
    });

  }

  Future init(AudioSource playList) async {
    await audioPlayer.setLoopMode(LoopMode.all);
    await audioPlayer.setAudioSource(playList);
    await audioPlayer.seek(Duration.zero, index: widget.index);
  }

  int? cs;

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('BUILDCONTEXT WORKING');
    return SafeArea(
      child: Scaffold(
        backgroundColor: AllColors.backColor,
        appBar: AppBar(
          backgroundColor: AllColors.backColor,
          title: const Text(
            'Music',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'textFont',
                letterSpacing: 1),
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                favourController.isFavour();
                print('FAVOURCONTROLLER ${favourController.isLiked}');

              },
              child: Obx(() => Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: favourController.isLiked.value
                      ? const Icon(
                    Icons.favorite,
                    size: 30,
                    color: Colors.red,
                  )
                      : const Icon(
                    Icons.favorite_border,
                    size: 30,
                  ))),
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
                  index = state ?? 0;
                  cs ??= state ?? 0;
                  if (cs ==state) {
                  } else {
                    cs = state;
                    favourController.isLiked.value = false;
                    favourController.update();
                    print('ELSE WORKING ${favourController.isLiked.value}');
                  }

                  return MusicImgWidget(
                    musicList: widget.list,
                    index: state,
                  );
                }),
            Expanded(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 40),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      StreamBuilder(
                          stream: _positionDataStream,
                          builder: (context, snapshot) {
                            final positionData = snapshot.data;
                            return ProgressBar(
                              barHeight: 8,
                              baseBarColor: Colors.grey.shade600,
                              bufferedBarColor: Colors.grey,
                              progressBarColor: Colors.white,
                              thumbColor: const Color(0xff0F1014),
                              timeLabelTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              progress: positionData?.position ?? Duration.zero,
                              total: positionData?.duration ?? Duration.zero,
                              buffered:
                              positionData?.befferedPosition ?? Duration.zero,
                              onSeek: audioPlayer.seek,
                            );
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      Controls(audioPlayer: audioPlayer),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
