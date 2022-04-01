import 'package:flutter/material.dart';

class SnackBars {
  final excistingPlaylist = SnackBar(
    content: const Text(
      'Existing playlist name',
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.grey[900],
  );
  final excistingSong = SnackBar(
    content: const Text(
      'Song already exists',
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.grey[900],
  );
  final songAdded = SnackBar(
    content: const Text(
      'Song added to Playlist',
      style: TextStyle(color: Colors.lightGreenAccent),
    ),
    backgroundColor: Colors.grey[900],
  );
}
