import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/presentation/getx_controllers/favour_controller.dart';

import '../../domain/models/music_model.dart';

class Controls extends StatelessWidget {
  final AudioPlayer audioPlayer;
final FavourController controller;
final List list;
  const Controls({super.key, required this.audioPlayer,required this.controller,required this.list});


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            onPressed: () {
              audioPlayer.seekToPrevious();
              print('CONTROL SCREEN ${controller.isShuffle.value}');
             if(controller.isShuffle.value){
               var rng =  Random();
               var a=rng.nextInt(list.length);
               controller.updateIndexx(rng.nextInt(list.length));

             }else
              if(audioPlayer.currentIndex==0){
                controller.updateIndexx(list.length-1);

              }else{
                controller.updateIndexx(audioPlayer.currentIndex!-1);

              }
              audioPlayer.play();

            },
            icon: const Icon(
              Icons.skip_previous,
              color: Colors.white,
            )),
        StreamBuilder(
            stream: audioPlayer.playerStateStream,
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              final processingState = playerState?.processingState;
              final playing = playerState?.playing;
              if (!(playing ?? false)) {
                return IconButton(
                    onPressed: () {
                      audioPlayer.play();
                    },
                    icon: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ));
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                    onPressed: () {
                      audioPlayer.pause();
                    },
                    icon: const Icon(
                      Icons.pause_rounded,
                      color: Colors.white,
                    ));
              }
              return const Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
              );
            }),
        IconButton(
            onPressed: () {
              print('Controller index ${audioPlayer.currentIndex}');
              print('CONTROL SCREEN ${controller.isShuffle.value}');
              if(controller.isShuffle.value){
                var rng =  Random();
                var a=rng.nextInt(list.length);
                print('RANDOM NUMBER = ${a}');
                audioPlayer.seekToNext();
                controller.updateIndexx(a);

              }else
              if(audioPlayer.currentIndex==list.length-1){
                controller.updateIndexx(0);
                audioPlayer.seekToNext();


              }else{
                controller.updateIndexx(audioPlayer.currentIndex!+1);
                audioPlayer.seekToNext();


              }
              audioPlayer.play();



            },
            icon: const Icon(
              Icons.skip_next,
              color: Colors.white,
            )),
      ],
    );
  }
}
