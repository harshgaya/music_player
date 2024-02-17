import 'package:flutter/material.dart';
import 'package:music_player/screens/home.dart';
import 'package:music_player/screens/player_screen.dart';
import 'package:provider/provider.dart';

import '../providers/player_service.dart';
import 'package:audioplayers/audioplayers.dart';

class BottomNavnBar extends StatefulWidget {
  const BottomNavnBar({super.key});

  @override
  State<BottomNavnBar> createState() => _BottomNavnBarState();
}

class _BottomNavnBarState extends State<BottomNavnBar> {
  int _currentIndex = 0;
  bool isPlaying = false;

  final List<Widget> _screens = [
    HomeScreen(),
    Container(),
    Container(),
    Container(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayerService>(
        builder: (context, playerService, child) {
      // playerService.player.onPlayerStateChanged.listen((state) {
      //   print('state of play $state');
      //   if (state == PlayerState.playing) {
      //     Provider.of<AudioPlayerService>(context, listen: false)
      //         .setPlaying(true);
      //     setState(() {
      //       isPlaying = true;
      //     });
      //   }
      //   if (state == PlayerState.completed) {
      //     Provider.of<AudioPlayerService>(context, listen: false)
      //         .setPlaying(false);
      //     setState(() {
      //       isPlaying = false;
      //     });
      //   }
      //   if (state == PlayerState.disposed) {
      //     Provider.of<AudioPlayerService>(context, listen: false)
      //         .setPlaying(false);
      //     setState(() {
      //       isPlaying = false;
      //     });
      //   }
      //   if (state == PlayerState.paused) {
      //     Provider.of<AudioPlayerService>(context, listen: false)
      //         .setPlaying(false);
      //     setState(() {
      //       isPlaying = false;
      //     });
      //   }
      //   if (state == PlayerState.stopped) {
      //     Provider.of<AudioPlayerService>(context, listen: false)
      //         .setPlaying(false);
      //     setState(() {
      //       isPlaying = false;
      //     });
      //   }
      // });
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            shape: CircleBorder(),
            mini: false,
            backgroundColor: Colors.white,
            child: playerService.isPlaying
                ? const Icon(Icons.pause)
                : const Icon(
                    Icons.play_arrow,
                    color: Color(0xFF5C3A7E),
                  ),
            onPressed: () {
              Navigator.of(context).pushNamed(PlayerScreen.routeName);
            }),
        bottomNavigationBar: BottomAppBar(
            color: const Color(0xFF5C3A7E),
            child: SizedBox(
              height: 56,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: const Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _onTabTapped(0);
                      }),
                  IconButton(
                      icon: const Icon(
                        Icons.bookmark,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _onTabTapped(1);
                      }),
                  const SizedBox(width: 40), // The dummy child
                  IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _onTabTapped(2);
                      }),
                  IconButton(
                      icon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _onTabTapped(3);
                      }),
                ],
              ),
            )),
        body: _screens[_currentIndex],
      );
    });
  }
}
