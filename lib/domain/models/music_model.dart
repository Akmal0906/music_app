import 'package:hive/hive.dart';
part 'music_model.g.dart';
@HiveType(typeId: 1)
class MusicModel{
  @HiveField(0)
  final String? name;
  @HiveField(1)

  final String? author;
  @HiveField(2)

  final String? path;
  @HiveField(3)

  final String? imgUrl;
  @HiveField(4)
   bool isLike;
  @HiveField(5)
  MusicModel( {this.name, this.author, this.path, this.imgUrl, this.isLike =false});
}