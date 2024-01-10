import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/domain/models/music_model.dart';

class FavourController extends GetxController {
  var listMusicModel =[].obs;
  var indexx = AudioPlayer().currentIndex.obs;
  var isShuffle = false.obs;

  void isFavour(int index) {
    listMusicModel[index].isLike = !listMusicModel[index].isLike;
    update();
  }

  void updateIndexx(int index) {
    indexx.value = index;
    update();
  }

  shuffle() {
    isShuffle.value = !isShuffle.value;
    update();
  }

  @override
  void onReady() {
    super.onReady();
    listMusicModel.refresh();
  }
}
