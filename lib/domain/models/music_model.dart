import 'package:hive/hive.dart';
part 'music_model.g.dart';
@HiveType(typeId: 1)
class MusicModel{
  @HiveField(0)
  final String name;
  @HiveField(1)

  final String author;
  @HiveField(2)

  final String path;
  @HiveField(3)

  final String imgUrl;
  @HiveField(4)

  MusicModel({required this.name,required this.author,required this.path,required this.imgUrl});
}