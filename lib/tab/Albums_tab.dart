import 'package:flutter/material.dart';
import '../screens/Playlist_inner.dart';

class Albumstab extends StatelessWidget {
  const Albumstab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListTile(
              leading: Image.asset('assets/icons8-music-heart-96.png'),
              title: const Text(
                "Music",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              subtitle: const Text(
                "9 songs",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Image.asset('assets/icons8-music-heart-96.png'),
              title: const Text(
                "Beats",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              subtitle: const Text(
                "259 songs",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
                leading: Image.asset('assets/icons8-music-heart-96.png'),
                title: const Text(
                  "Malayalam",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                subtitle: const Text(
                  "99 songs",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {})
          ],
        ),
      ),
    );
  }
}
