import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../database/Songdatabe.dart';
import '../database/box.dart';
import 'Home_screen.dart';

class Splash_screen extends StatefulWidget {
  Splash_screen({Key? key}) : super(key: key);

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  void initState() {
    gotoLogin();
    super.initState();
    fetchSongs();
  }

  final box = Boxes.getInstance();
  final assetAudioPlayer = AssetsAudioPlayer.withId("0");
  List<Audio> audiosongs = [];
  final _audioQuery = OnAudioQuery();
  List<Songsdb> mappedSongs = [];
  List<Songsdb> dbSongs = [];
  List<SongModel> fetchedSongs = [];
  @override
  List<SongModel> allsong = [];
  fetchSongs() async {
    bool permissionStatus = await _audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await _audioQuery.permissionsRequest();
    }
    allsong = await _audioQuery.querySongs();

    mappedSongs = allsong
        .map((e) => Songsdb(
            title: e.title,
            id: e.id.toString(),
            image: e.uri!,
            duration: e.duration.toString(),
            artist: e.artist))
        .toList();
    await box.put("musics", mappedSongs);
    dbSongs = box.get("musics") as List<Songsdb>;

    dbSongs.forEach((element) {
      audiosongs.add(Audio.file(element.image.toString(),
          metas: Metas(
              title: element.title,
              id: element.id.toString(),
              artist: element.artist)));
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height.toString());
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  "assets/Disk Jockey Design Star Bass Background.jpg"),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .44),
            Text("Tunex",
                style: TextStyle(
                  color: Color.fromARGB(244, 230, 206, 206),
                  fontSize: 74.0,
                  letterSpacing: 8.0,
                  fontWeight: FontWeight.bold,
                )),
            Text(
              "Enjoy Music",
              style: TextStyle(
                color: Color.fromARGB(255, 11, 8, 230),
                fontSize: 18.0,
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .38,
            ),
            Lottie.asset('assets/97959-music-visualizer.json')
          ],
        ),
      ),
    );
  }

  gotoLogin() async {
    await Future.delayed(Duration(seconds: 4));

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx1) => Home_screen(
          allsong: audiosongs,
        ),
      ),
    );
  }
}
