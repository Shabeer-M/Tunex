import 'package:flutter/material.dart';

import 'Favourties_screen.dart';
import 'Settings_screen.dart';

class Playlistitem extends StatelessWidget {
  const Playlistitem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: Image.asset(
            'assets/icons8-music-heart-96.png',
            width: 38.0,
            height: 48.0,
          ),
          title: const Text(
            "TuneX",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 3.0,
            ),
          ),
          actions: [
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
          bottom: TabBar(tabs: [
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
        body: Container(
            color: Colors.black,
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  ListTile(
                    leading: Icon(
                      Icons.heart_broken_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    title: Text(
                      "Favourites",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Favoourties_screen()),
                      );
                    },
                  ),
                ]))),
      ),
    );
  }
}
