import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/player_service.dart';

class PlayerScreen extends StatefulWidget {
  static const String routeName = '/player-screen';

  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  double _currentValue = 0.0;
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<AudioPlayerService>(
          builder: (context, playerService, child) {
        return Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF5D3A80), Color(0xFF794CA8)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/song1.png'),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Song Name',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                          Icon(
                            Icons.bookmark,
                            color: Colors.white,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Slider(
                        value: _currentValue,
                        min: 0,
                        max: 100,
                        onChanged: (value) {
                          setState(() {
                            _currentValue = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset('assets/before.png'),
                            !playerService.isPlaying
                                ? const Icon(
                                    Icons.play_circle,
                                    color: Colors.white,
                                    size: 50,
                                  )
                                : const Icon(
                                    Icons.pause,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                            Image.asset('assets/after.png'),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
