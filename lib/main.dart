import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_player/providers/player_service.dart';
import 'package:music_player/screens/bottom_navigation.dart';
import 'package:music_player/screens/home.dart';
import 'package:music_player/screens/player_screen.dart';
import 'package:music_player/utils/database_helper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:provider/provider.dart';

import 'models/music_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await loadAssetsToDB();

  runApp(const MyApp());
}

loadAssetsToDB() async {
  final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
// This returns a List<String> with all your images
  final imageAssetsList = assetManifest
      .listAssets()
      .where((string) => string.startsWith("assets/Today_Hit/"))
      .toList();
  print(imageAssetsList);
  imageAssetsList.forEach((element) async {
    final Music music = Music(title: element, type: 'today_hit', isFavorite: 0);
    try {
      await DatabaseHelper.addMusicToDb(music);
    } catch (e) {
      print('error adding to db $e');
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AudioPlayerService>(create: (_) {
          return AudioPlayerService();
        }),
      ],
      child: MaterialApp(
        routes: {PlayerScreen.routeName: (_) => PlayerScreen()},
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const BottomNavnBar(),
      ),
    );
  }
}
