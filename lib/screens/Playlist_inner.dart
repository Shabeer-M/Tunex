import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:tunexx/database/Songdatabe.dart';
import 'package:tunexx/screens/Nowplaying_screen.dart';
import '../Assetplayer/Asset_player.dart';
import '../custom/bottomsheet.dart';
import '../database/box.dart';

class Playlistinner_screen extends StatefulWidget {
  Playlistinner_screen({Key? key, required this.playlistName})
      : super(key: key);
  String playlistName;
  @override
  State<Playlistinner_screen> createState() => _Playlistinner_screenState();
}

class _Playlistinner_screenState extends State<Playlistinner_screen> {
  List<Songsdb>? dbSongs = [];

  List<Songsdb>? playlistSongs = [];
  List<Audio> playPlaylist = [];

  final box = Boxes.getInstance();

  @override
  void initState() {
    super.initState();
    getSongs();
  }

  getSongs() {
    dbSongs = box.get("musics") as List<Songsdb>;
    playlistSongs = box.get(widget.playlistName)!.cast<Songsdb>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        title: Text(
          widget.playlistName,
          style: const TextStyle(),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_outlined,
            size: 30,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(50),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return buildSheet(
                        playlistName: widget.playlistName,
                      );
                    });
              },
              child: const Text(
                '+',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, boxes, _) {
                final playlistSongs = box.get(widget.playlistName)!;
                // print(widget.playlistName);
                return playlistSongs.isEmpty
                    ? SizedBox(
                        child: Center(
                          child: Text(
                            "No songs here!",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: playlistSongs.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            for (var element in playlistSongs) {
                              playPlaylist.add(
                                Audio.file(
                                  element.image!,
                                  metas: Metas(
                                    title: element.title,
                                    id: element.id.toString(),
                                    artist: element.artist,
                                  ),
                                ),
                              );
                            }
                            OpenAssetAudio(allsong: playPlaylist, index: index)
                                .openAsset(index: index, audios: playPlaylist);

                            LoopMode.playlist;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Nowplaying(
                                  audiosongs: playPlaylist,
                                  index: index,
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: SizedBox(
                              height: 50,
                              width: 50,
                              child: QueryArtworkWidget(
                                id: int.parse(playlistSongs[index].id!),
                                type: ArtworkType.AUDIO,
                                artworkBorder: BorderRadius.circular(15),
                                artworkFit: BoxFit.cover,
                                nullArtworkWidget: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    image: DecorationImage(
                                      image: AssetImage("assets/defult.jpeg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              playlistSongs[index].title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            subtitle: Text(
                              playlistSongs[index].artist!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            trailing: GestureDetector(
                              child: Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                              onTap: () async {
                                // playlistSongs.removeWhere((elemet) =>
                                //     elemet.id.toString() ==
                                //     dbSongs![index].id.toString());

                                // await box.put("song", playlistSongs);
                                // setState(() {});
                                setState(() {
                                  playlistSongs.removeAt(index);
                                  // box.put("songs", playlistSongs);
                                });
                              },
                            ),
                          ),
                        ),
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}
