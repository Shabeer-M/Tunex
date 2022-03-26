import 'dart:ui';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:tunexx/database/Songdatabe.dart';

import '../database/box.dart';

class Nowplaying extends StatefulWidget {
  int index;
  List<Audio> audiosongs = [];

  Nowplaying({Key? key, required this.audiosongs, required this.index})
      : super(key: key);

  State<Nowplaying> createState() => NowplayingState();
}

class NowplayingState extends State<Nowplaying> {
  double minimumValue = 0, maximumValue = 0, currentValue = 0;
  String currentTime = '', endTime = '';

  bool isPlaying = false;

  final AssetsAudioPlayer assetAudioPlayer = AssetsAudioPlayer.withId("0");

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  late TextEditingController controller;
  final box = Boxes.getInstance();

  List playlists = [];
  List<dynamic>? playlistSongs = [];
  String? playlistName = '';
  List<Songsdb> dbSongs = [];
  List<dynamic>? likedSongs = [];

  @override
  void initState() {
    super.initState();
    dbSongs = box.get("musics") as List<Songsdb>;
    controller = TextEditingController();
  }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  var repeatf = Icons.repeat;
  @override
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: assetAudioPlayer.builderCurrent(
          builder: (context, Playing? playing) {
            final myAudio =
                find(widget.audiosongs, playing!.audio.assetAudioPath);
            final currentSong = dbSongs.firstWhere((element) =>
                element.id.toString() == myAudio.metas.id.toString());
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/head_image.jpg'),
                    fit: BoxFit.cover),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_drop_down,
                            size: 40,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .08,
                  ),
                  Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      shape: BoxShape.rectangle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: QueryArtworkWidget(
                        id: int.parse(myAudio.metas.id!),
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: Image.asset(
                          "assets/abstract-vector-element-music-design-260nw-1031659504.webp",
                          height: 300,
                          width: 300,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .045,
                  ),
                  Text(
                    myAudio.metas.title!,
                    style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 20,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .010,
                  ),
                  Text(
                    myAudio.metas.artist!,
                    style: TextStyle(
                        color: Color.fromARGB(255, 227, 233, 230),
                        fontSize: 15,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold),
                  ),

                  StreamBuilder<Duration>(
                      stream: assetAudioPlayer.currentPosition,
                      builder: (context, snapshot) {
                        return Slider(
                          inactiveColor: Colors.grey,
                          activeColor: Colors.greenAccent,
                          max: playing.audio.duration.inMilliseconds.toDouble(),
                          value: snapshot.data == null
                              ? 0
                              : snapshot.data!.inMilliseconds.toDouble(),
                          onChanged: (value) {
                            assetAudioPlayer
                                .seek(Duration(milliseconds: value.floor()));
                          },
                        );
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Text(currentTime,
                          style: TextStyle(
                              color: Color.fromARGB(255, 218, 215, 215))),
                      SizedBox(
                        width: 320,
                      ),
                      Text(
                        endTime,
                        style: TextStyle(
                            color: Color.fromARGB(255, 218, 215, 215)),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        color: Colors.white,
                        icon: new Icon(
                          Icons.shuffle,
                          size: 30,
                        ),
                        onPressed: () {
                          assetAudioPlayer.toggleShuffle();
                        },
                      ),
                      // SizedBox(
                      //   width: 25,
                      // ),
                      IconButton(
                        color: Colors.white,
                        icon: Icon(
                          Icons.skip_previous,
                          size: 30,
                        ),
                        onPressed: () {
                          assetAudioPlayer.previous();
                        },
                      ),

                      PlayerBuilder.isPlaying(
                        player: assetAudioPlayer,
                        builder: (context, isPlaying) {
                          return IconButton(
                            onPressed: () async {
                              await assetAudioPlayer.playOrPause();
                            },
                            icon: Icon(
                              isPlaying
                                  ? Icons.pause_circle_filled_rounded
                                  : Icons.play_circle_fill_rounded,
                              size: 40,
                              color: Colors.greenAccent,
                            ),
                          );
                        },
                      ),
                      IconButton(
                        color: Colors.white,
                        icon: Icon(
                          Icons.skip_next,
                          size: 30,
                        ),
                        onPressed: () {
                          assetAudioPlayer.next();
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          repeatf,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          assetAudioPlayer.setLoopMode(LoopMode.single);
                        },
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        color: Colors.white,
                        icon: new Icon(
                          Icons.heart_broken,
                          size: 30,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        color: Colors.white,
                        icon: new Icon(
                          Icons.playlist_add,
                          size: 30,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    width: 300,
                    height: 50,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.grey,
                          Colors.black,
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      shape: BoxShape.rectangle,
                    ),
                    child: const Center(
                      child: Text(
                        'Now Playing',
                        style: TextStyle(
                            color: Color.fromARGB(255, 218, 215, 215),
                            fontSize: 30,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
