import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import '../tab/Albums_tab.dart';
import '../tab/Playlist_tab.dart';
import '../tab/Songs_tab.dart';
import 'Settings_screen.dart';

class Home_screen extends StatefulWidget {
  Home_screen({Key? key, required this.allsong}) : super(key: key);
  List<Audio> allsong;
  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  Icon myIcon = const Icon(Icons.search);
  Widget myField = const Text(
    'TuneX',
    style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        letterSpacing: 3.0,
        color: Colors.white),
  );
  String searchInput = "";
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: Image.asset(
            'assets/icons8-music-heart-96.png',
            width: 38.0,
            height: 48.0,
          ),
          title: myField,
          // title: Text(
          //   myField',
          //   style: TextStyle(
          //     fontSize: 30.0,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.white,
          //     letterSpacing: 3.0,
          //   ),
          // ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    if (myIcon.icon == Icons.search) {
                      myIcon = const Icon(Icons.clear);
                      myField = TextField(
                        onChanged: (value) {
                          searchInput = value;
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          hintText: 'Search here',
                        ),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 236, 232, 232),
                            fontSize: 18),
                      );
                    } else {
                      setState(() {
                        searchInput = '';
                      });
                      myIcon = const Icon(Icons.search);
                      myField = const Text(
                        'TuneX',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3.0,
                            color: Colors.white),
                      );
                    }
                  });
                },
                icon: myIcon),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings_screen()),
                );
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ],
          bottom: const TabBar(tabs: [
            Tab(
              text: "Songs",
              icon: Icon(Icons.music_note),
            ),
            Tab(
              text: "Albums",
              icon: Icon(Icons.album),
            ),
            Tab(text: "Playist", icon: Icon(Icons.playlist_add))
          ]),
        ),
        body: TabBarView(children: [
          Songstab(
            audiosongs: widget.allsong,
          ),
          const Albumstab(),
          const Playlisttab(),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => Nowplaying_screen()),
            // );
          },
          backgroundColor: Colors.greenAccent,
          child: const Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}
