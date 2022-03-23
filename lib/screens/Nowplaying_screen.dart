import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:tunexx/database/Songdatabe.dart';

import '../database/box.dart';

class Nowplaying extends StatefulWidget {
  int index;
  List<Audio> audiosongs = [];
  List<Audio> a = [];
  Nowplaying({Key? key, required this.audiosongs, required this.index})
      : super(key: key);

  State<Nowplaying> createState() => NowplayingState();
}

class NowplayingState extends State<Nowplaying> {
  double minimumValue = 0, maximumValue = 0, currentValue = 0;
  String currentTime = '', endTime = '';

  bool isPlaying = false;

  bool _fav = false;

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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/head_image.jpg'), fit: BoxFit.cover),
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
                    child: Image.asset('assets/Arbic.jpg')),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .045,
              ),
              Text(
                "hi",
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
                "the",
                style: TextStyle(
                    color: Color.fromARGB(255, 227, 233, 230),
                    fontSize: 15,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold),
              ),

              Slider(
                inactiveColor: Colors.grey,
                activeColor: Colors.greenAccent,
                min: minimumValue,
                max: maximumValue,
                value: currentValue,
                onChanged: (value) {
                  currentValue = value;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  Text(currentTime,
                      style:
                          TextStyle(color: Color.fromARGB(255, 218, 215, 215))),
                  SizedBox(
                    width: 320,
                  ),
                  Text(
                    endTime,
                    style: TextStyle(color: Color.fromARGB(255, 218, 215, 215)),
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
                    onPressed: () {},
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
                    onPressed: () {},
                  ),

                  GestureDetector(
                    child: Icon(
                        isPlaying
                            ? Icons.pause_circle_filled_rounded
                            : Icons.play_circle_fill_rounded,
                        color: Colors.greenAccent,
                        size: 82),
                    behavior: HitTestBehavior.translucent,
                    onTap: () {},
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(
                        Icons.skip_next,
                        size: 30,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  // SizedBox(
                  //   width: 25,
                  // ),

                  IconButton(
                    color: Colors.white,
                    icon: new Icon(
                      Icons.repeat,
                      size: 30,
                    ),
                    onPressed: () {},
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
              SizedBox(height: 121),
              Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
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
                child: Center(
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
        ),
      ),
    );
  }
}
