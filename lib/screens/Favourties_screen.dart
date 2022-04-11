import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:tunexx/database/Songdatabe.dart';
import 'package:tunexx/screens/Nowplaying_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../Assetplayer/Asset_player.dart';
import '../database/box.dart';

class Favoourties_screen extends StatefulWidget {
  const Favoourties_screen({Key? key}) : super(key: key);

  @override
  State<Favoourties_screen> createState() => _Favoourties_screenState();
}

class _Favoourties_screenState extends State<Favoourties_screen> {
  List<Songsdb>? dbSongs = [];
  List<Audio> playLiked = [];
  List<Songsdb>? likedSongs = [];
  final box = Boxes.getInstance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "Favourites",
            style: TextStyle(),
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
          children: [
            Expanded(
                child: ValueListenableBuilder(
                    valueListenable: box.listenable(),
                    builder: (context, boxes, _) {
                      final likedSongs = box.get("favorites");
                      return ListView.builder(
                          itemCount: likedSongs!.length,
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  for (var element in likedSongs) {
                                    playLiked.add(
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
                                  OpenAssetAudio(
                                          allsong: playLiked, index: index)
                                      .openAsset(
                                          index: index, audios: playLiked);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Nowplaying(
                                                audiosongs: playLiked,
                                                index: index,
                                              )));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Card(
                                    color:
                                        const Color.fromARGB(73, 105, 168, 240),
                                    child: ListTile(
                                      leading: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: QueryArtworkWidget(
                                          id: int.parse(likedSongs[index].id!!),
                                          type: ArtworkType.AUDIO,
                                          artworkBorder:
                                              BorderRadius.circular(15),
                                          artworkFit: BoxFit.cover,
                                          nullArtworkWidget: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/defult.jpeg"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            likedSongs.removeAt(index);
                                            box.put("favorites", likedSongs);
                                          });
                                        },
                                        icon: Icon(Icons.delete,
                                            color: Colors.white),
                                      ),
                                      title: Text(
                                        likedSongs[index].title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.greenAccent),
                                      ),
                                      subtitle: Text(
                                        likedSongs[index].artist,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                      dense: true,
                                      selected: true,
                                    ),
                                  ),
                                ),
                              ));
                    })),
          ],
        ));
  }

  // body: Container(
  //     child: ListView(
  //   children: [
  //     Card(
  //         color: const Color.fromARGB(73, 105, 168, 240),
  //         child: ListTile(
  //           leading: const CircleAvatar(
  //             backgroundImage: AssetImage('assets/Arbic.jpg'),
  //           ),
  //           title: const Text(
  //             "Halamathi Habibo..",
  //             style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
  //           ),
  //           trailing: IconButton(
  //               onPressed: () {},
  //               icon: const Icon(
  //                 Icons.delete,
  //                 size: 30,
  //                 color: Color.fromARGB(255, 243, 242, 242),
  //               )),
  //           subtitle: const Text("Deepthi Balasubramaniyan"),
  //           dense: true,
  //           selected: true,
  //           onTap: () {
  //             // Navigator.push(
  //             //   context,
  //             //   MaterialPageRoute(
  //             //       builder: (context) => Nowplaying_screen()),
  //             // );
  //           },
  //         )),
  //     Card(
  //         color: const Color.fromARGB(73, 105, 168, 240),
  //         child: ListTile(
  //           leading: const CircleAvatar(
  //             backgroundImage: AssetImage('assets/closer.jpg'),
  //           ),
  //           title: const Text(
  //             "Closer..",
  //             style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
  //           ),
  //           trailing: IconButton(
  //               onPressed: () {},
  //               icon: const Icon(
  //                 Icons.delete,
  //                 size: 30,
  //                 color: Colors.white,
  //               )),
  //           subtitle: Text("The Chainsmoker"),
  //           dense: true,
  //           selected: true,
  //           onTap: () {
  //             // Navigator.push(
  //             //   context,
  //             //   MaterialPageRoute(
  //             //       builder: (context) => Nowplaying_screen()),
  //             // );
  //           },
  //         )),
  //     Card(
  //         color: const Color.fromARGB(73, 105, 168, 240),
  //         child: ListTile(
  //           leading: const CircleAvatar(
  //             backgroundImage: AssetImage('assets/billa.jpg'),
  //           ),
  //           title: const Text(
  //             "My Name is Billa..",
  //             style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
  //           ),
  //           trailing: IconButton(
  //               onPressed: () {},
  //               icon: const Icon(
  //                 Icons.delete,
  //                 size: 30,
  //                 color: Colors.white,
  //               )),
  //           subtitle: const Text(" S. P Balasubramaniyan"),
  //           dense: true,
  //           selected: true,
  //           onTap: () {
  //             // Navigator.push(
  //             //   context,
  //             //   MaterialPageRoute(
  //             //       builder: (context) => Nowplaying_screen()),
  //             // );
  //           },
  //         )),
  //   ],
  //   padding: EdgeInsets.all(20),
  // )),
}
