import 'package:music_app/domain/models/boxes.dart';
import '../../domain/models/music_model.dart';

class Storage{
void storeMusic(MusicModel musicModel){
  boxMusics.put(musicModel.name, musicModel);


}
void deleteMusic(int index){
  boxMusics.deleteAt(index);
}
}