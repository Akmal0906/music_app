import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Controls extends StatelessWidget {
  final AudioPlayer audioPlayer;

  const Controls({super.key, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(onPressed: (){
          audioPlayer.seekToPrevious();
        }, icon: const Icon(Icons.skip_previous,color: Colors.white,)),
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
                    icon: const Icon(Icons.play_arrow,color: Colors.white,));
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                    onPressed: () {
                      audioPlayer.pause();
                    },
                    icon: const Icon(Icons.pause_rounded,color: Colors.white,));
              }
              return const Icon(Icons.play_arrow_rounded,color: Colors.white,);
            }),
        IconButton(onPressed: (){
          audioPlayer.seekToNext();
        }, icon: const Icon(Icons.skip_next,color: Colors.white,)),

      ],
    );
  }
}
