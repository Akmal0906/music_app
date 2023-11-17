import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_app/domain/models/boxes.dart';
import 'package:music_app/splash_screen.dart';
import 'domain/models/music_model.dart';

Future main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(MusicModelAdapter());
   boxMusics=await Hive.openBox<MusicModel>('favour_musics');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(cardColor: Colors.blue),
      home: const SplashScreen(),
    );
  }
}
