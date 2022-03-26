import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Assetplayer/Asset_player.dart';
import '../custom/Songlist_custom.dart';
import '../database/box.dart';
import '../screens/Nowplaying_screen.dart';

class Songstab extends StatefulWidget {
  Songstab({Key? key, required this.audiosongs}) : super(key: key);
  List<Audio> audiosongs = [];
  @override
  State<Songstab> createState() => _SongstabState();
}

class _SongstabState extends State<Songstab> {
  final List<dynamic> file_urlh = [Icon(Icons.abc), Icon(Icons.ad_units)];

  List? dbSongs = [];

  final box = Boxes.getInstance();

  final AssetsAudioPlayer assetAudioPlayer = AssetsAudioPlayer.withId("0");

  final audioQuery = OnAudioQuery();

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  void initState() {
    dbSongs = box.get("musics");
  }

  @override
  Widget build(BuildContext context) {
    var audiosongss;
    return ListView.builder(
        itemCount: widget.audiosongs.length,
        itemBuilder: (BuildContext context, int index) => ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: QueryArtworkWidget(
                    nullArtworkWidget: Image.asset(
                      "assets/abstract-vector-element-music-design-260nw-1031659504.webp",
                    ),
                    id: int.parse(widget.audiosongs[index].metas.id.toString()),
                    type: ArtworkType.AUDIO),
              ),
              title: Text(
                widget.audiosongs[index].metas.title.toString(),
                style: TextStyle(color: Colors.greenAccent, fontSize: 20),
              ),
              subtitle: Text(
                widget.audiosongs[index].metas.artist.toString(),
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              onTap: () async {
                await OpenAssetAudio(allsong: [], index: index)
                    .openAsset(index: index, audios: widget.audiosongs);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Nowplaying(
                          index: index,
                          audiosongs: widget.audiosongs,
                        )));
              },
            ));
  }
}
