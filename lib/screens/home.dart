import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/providers/player_service.dart';
import 'package:music_player/utils/database_helper.dart';
import 'package:provider/provider.dart';

import '../models/music_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> key = GlobalKey();

  getAllMusic() async {
    await DatabaseHelper.getAllMusics();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<AudioPlayerService>(
          builder: (context, playerService, child) {
        return Scaffold(
          key: key,
          drawer: const Drawer(),
          body: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF5D3A80), Color(0xFF794CA8)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        key.currentState!.openDrawer();
                      },
                      child: Image.asset('assets/hemburger.png')),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome',
                          style: GoogleFonts.inter(
                              fontSize: 14, color: Colors.white),
                        ),
                        Text(
                          'Enjoy Your Favorite Music',
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              Image.asset('assets/search.png'),
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                'Search',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Today's Hit",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "View More",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: FutureBuilder<List<Music>>(
                                    future: DatabaseHelper.getAllMusics(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text('');
                                      }
                                      if (snapshot.hasError) {
                                        print(
                                            'error ${snapshot.error.toString()}');
                                        return Text('Error');
                                      }
                                      return SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                40,
                                        height: 200,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: snapshot.data!.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      child: Image.asset(
                                                        'assets/song1.png',
                                                        height: 205,
                                                        width: 173,
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: 10,
                                                      left: 0,
                                                      child: InkWell(
                                                        onTap: () {
                                                          // AudioPlayer
                                                          //     audioPlayer =
                                                          //     AudioPlayer();
                                                          // audioPlayer.play(
                                                          //     AssetSource(snapshot
                                                          //         .data![index]
                                                          //         .title
                                                          //         .replaceFirst(
                                                          //             'assets/',
                                                          //             '')));

                                                          playerService
                                                              .playPause(snapshot
                                                                  .data![index]
                                                                  .title
                                                                  .replaceFirst(
                                                                      'assets/',
                                                                      ''));
                                                        },
                                                        child: Container(
                                                          width: 153,
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 10,
                                                            right: 10,
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15),
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.8),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                '${snapshot.data![index].title}',
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              Image.asset(
                                                                  'assets/play_small.png')
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                      );
                                    }),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
