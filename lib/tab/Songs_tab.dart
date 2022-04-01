import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:tunexx/database/Songdatabe.dart';

import '../Assetplayer/Asset_player.dart';
import '../custom/Songlist_custom.dart';
import '../custom/buildsheet.dart';
import '../custom/snakbar.dart';
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
  List playlists = [];

  String? playlistName = '';
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
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              ListView.builder(
                  itemCount: widget.audiosongs.length,
                  itemBuilder: (BuildContext context, int index) => ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: QueryArtworkWidget(
                              nullArtworkWidget: Image.asset(
                                "assets/abstract-vector-element-music-design-260nw-1031659504.webp",
                              ),
                              id: int.parse(
                                  widget.audiosongs[index].metas.id.toString()),
                              type: ArtworkType.AUDIO),
                        ),
                        title: Text(
                          widget.audiosongs[index].metas.title.toString(),
                          style: const TextStyle(
                              color: Colors.greenAccent, fontSize: 20),
                        ),
                        subtitle: Text(
                          widget.audiosongs[index].metas.artist.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                        onLongPress: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // likedSongs = box.get("favorites");
                            return Dialog(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ListTile(
                                          title: const Text(
                                            "Add to Playlist",
                                            style: TextStyle(
                                                color: Colors.greenAccent,
                                                fontSize: 20),
                                          ),
                                          // trailing: const Icon(Icons.add),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            showModalBottomSheet(
                                                backgroundColor: Colors.grey,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.vertical(
                                                                top: Radius
                                                                    .circular(
                                                                        20))),
                                                context: context,
                                                builder: (context) =>
                                                    BuildSheet(
                                                        song: widget
                                                            .audiosongs[index])
                                                // buildSheet(song: dbSongs[index]),
                                                );
                                          },
                                        ),
                                      ]),
                                ));
                          },
                        ),
                        onTap: () async {
                          await OpenAssetAudio(allsong: [], index: index)
                              .openAsset(
                                  index: index, audios: widget.audiosongs);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Nowplaying(
                                    index: index,
                                    audiosongs: widget.audiosongs,
                                  )));
                        },
                      )),
              assetAudioPlayer.builderCurrent(
                  builder: (BuildContext context, Playing? playing) {
                final myAudio =
                    find(widget.audiosongs, playing!.audio.assetAudioPath);
                return Column(children: [
                  Expanded(
                      child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 75,
                      decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Nowplaying(
                                      index: 0,
                                      audiosongs: widget.audiosongs,
                                    )),
                          );
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              height: 60,
                              width: 60,
                              child: QueryArtworkWidget(
                                id: int.parse(myAudio.metas.id!),
                                type: ArtworkType.AUDIO,
                                artworkBorder: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10)),
                                artworkFit: BoxFit.cover,
                                nullArtworkWidget: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/abstract-vector-element-music-design-260nw-1031659504.webp"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 12,
                                  top: 12,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      myAudio.metas.title!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 7),
                                    Text(
                                      myAudio.metas.artist!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    assetAudioPlayer.previous();
                                  },
                                  child: const Icon(
                                    Icons.skip_previous_rounded,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                PlayerBuilder.isPlaying(
                                    player: assetAudioPlayer,
                                    builder: (context, isPlaying) {
                                      return GestureDetector(
                                        onTap: () async {
                                          await assetAudioPlayer.playOrPause();
                                        },
                                        child: Icon(
                                          isPlaying
                                              ? Icons.pause_rounded
                                              : Icons.play_arrow_rounded,
                                          size: 35,
                                          color: Colors.white,
                                        ),
                                      );
                                    }),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    assetAudioPlayer.next();
                                  },
                                  child: const Icon(
                                    Icons.skip_next_rounded,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 15),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ))
                ]);
              }),
            ],
          ),
        ),
      ],
    );
  }
}
