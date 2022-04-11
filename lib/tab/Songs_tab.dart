import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:tunexx/database/Songdatabe.dart';
import '../Assetplayer/Asset_player.dart';

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
  final TextEditingController _textEditingController = TextEditingController();
  String searchingTerm = "";
  final List<dynamic> file_urlh = [Icon(Icons.abc), Icon(Icons.ad_units)];

  List? dbSongs = [];
  List playlists = [];
  List<dynamic>? favorites = [];
  List<dynamic>? likedSongs = [];

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
    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: Column(
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
                                  "assets/defult.jpeg",
                                ),
                                id: int.parse(widget.audiosongs[index].metas.id
                                    .toString()),
                                type: ArtworkType.AUDIO),
                          ),
                          title: Text(
                            widget.audiosongs[index].metas.title.toString(),
                            maxLines: 1,
                            style: const TextStyle(
                                color: Colors.greenAccent, fontSize: 18),
                          ),
                          subtitle: Text(
                            widget.audiosongs[index].metas.artist.toString(),
                            maxLines: 1,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                          onLongPress: () => showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                  backgroundColor: Colors.blueGrey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            widget.audiosongs[index].metas.title
                                                .toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          ListTile(
                                            title: const Text(
                                              "Add to Playlist",
                                              style: TextStyle(
                                                  color:
                                                      Colors.lightGreenAccent,
                                                  fontSize: 20),
                                            ),
                                            trailing: const Icon(
                                              Icons.add,
                                              color: Colors.red,
                                            ),
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              showModalBottomSheet(
                                                  backgroundColor: Colors.grey,
                                                  shape: const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      20))),
                                                  context: context,
                                                  builder: (context) =>
                                                      BuildSheet(
                                                          song:
                                                              widget.audiosongs[
                                                                  index])
                                                  // buildSheet(song: dbSongs[index]),
                                                  );
                                            },
                                          ),
                                          likedSongs!
                                                  .where((element) =>
                                                      element.id.toString() ==
                                                      dbSongs![index]
                                                          .id
                                                          .toString())
                                                  .isEmpty
                                              ? ListTile(
                                                  title: const Text(
                                                    "Add to Favorites",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .lightGreenAccent,
                                                        fontSize: 20),
                                                  ),
                                                  trailing: const Icon(
                                                    Icons.favorite_rounded,
                                                    color: Colors.red,
                                                  ),
                                                  onTap: () async {
                                                    final songs =
                                                        box.get("musics")
                                                            as List<Songsdb>;
                                                    final temp = songs
                                                        .firstWhere((element) =>
                                                            element.id
                                                                .toString() ==
                                                            widget
                                                                .audiosongs[
                                                                    index]
                                                                .metas
                                                                .id
                                                                .toString());
                                                    favorites = likedSongs;
                                                    favorites?.add(temp);
                                                    box.put("favorites",
                                                        favorites!);

                                                    Navigator.of(context).pop();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            SnackBars()
                                                                .likedAdd);
                                                  },
                                                )
                                              : ListTile(
                                                  title: const Text(
                                                      "Remove from Favorites"),
                                                  trailing: const Icon(
                                                    Icons.favorite_rounded,
                                                    color: Colors.redAccent,
                                                  ),
                                                  onTap: () async {
                                                    likedSongs?.removeWhere(
                                                        (elemet) =>
                                                            elemet.id
                                                                .toString() ==
                                                            dbSongs![index]
                                                                .id
                                                                .toString());
                                                    await box.put("favorites",
                                                        likedSongs!);
                                                    setState(() {});

                                                    Navigator.of(context).pop();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            SnackBars()
                                                                .likedRemove);
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
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.blue,
                                Colors.greenAccent,
                              ],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        margin: const EdgeInsets.only(left: 10, right: 10),
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
                                        image: AssetImage("assets/defult.jpeg"),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            color: Colors.black,
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
                                            await assetAudioPlayer
                                                .playOrPause();
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
      ),
    );
  }
}
