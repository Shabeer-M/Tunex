import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:tunexx/database/Songdatabe.dart';
import 'package:tunexx/screens/Nowplaying_screen.dart';
import '../Assetplayer/Asset_player.dart';
import '../database/box.dart';
import '../screens/Playlist_inner.dart';

// class Albumstab extends StatelessWidget {
//   const Albumstab({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           children: [
//             ListTile(
//               leading: Image.asset('assets/icons8-music-heart-96.png'),
//               title: const Text(
//                 "Music",
//                 style: TextStyle(color: Colors.white, fontSize: 20),
//               ),
//               subtitle: const Text(
//                 "9 songs",
//                 style: TextStyle(color: Colors.white),
//               ),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: Image.asset('assets/icons8-music-heart-96.png'),
//               title: const Text(
//                 "Beats",
//                 style: TextStyle(color: Colors.white, fontSize: 20),
//               ),
//               subtitle: const Text(
//                 "259 songs",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//             ListTile(
//                 leading: Image.asset('assets/icons8-music-heart-96.png'),
//                 title: const Text(
//                   "Malayalam",
//                   style: TextStyle(color: Colors.white, fontSize: 20),
//                 ),
//                 subtitle: const Text(
//                   "99 songs",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 onTap: () {})
//           ],
//         ),
//       ),
//     );
//   }
// }
class SearchScreen extends StatefulWidget {
  List<Audio> audiosongs = [];
  SearchScreen({Key? key, required this.audiosongs}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Songsdb> dbSongs = [];
  List<Audio> allSongs = [];

  String search = "";

  final box = Boxes.getInstance();

  @override
  void initState() {
    super.initState();
    getSongs();
  }

  Future<String> debounce() async {
    await Future.delayed(const Duration(seconds: 0));
    return "Waited 1";
  }

  getSongs() {
    dbSongs = box.get("musics") as List<Songsdb>;

    for (var element in dbSongs) {
      allSongs.add(
        Audio.file(
          element.image.toString(),
          metas: Metas(
              title: element.title,
              id: element.id.toString(),
              artist: element.artist),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Audio> searchResult = allSongs
        .where((element) => element.metas.title!.toLowerCase().startsWith(
              search.trim().toLowerCase(),
            ))
        .toList();

    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [BoxShadow(color: Colors.black26)]),
              height: 55,
              width: 340,
              child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14),
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                      hintText: 'search a song',
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey)),
                  onChanged: (value) {
                    setState(() {
                      search = value;
                    });
                  }),
            ),
          ),
          search.isNotEmpty
              ? searchResult.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: searchResult.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder(
                                future: debounce(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return GestureDetector(
                                      onTap: () {
                                        OpenAssetAudio(
                                                allsong: searchResult,
                                                index: index)
                                            .openAsset(
                                                index: index,
                                                audios: searchResult);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Nowplaying(
                                                      index: index,
                                                      audiosongs:
                                                          widget.audiosongs,
                                                    )));
                                      },
                                      child: ListTile(
                                        leading: SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: QueryArtworkWidget(
                                            id: int.parse(
                                                searchResult[index].metas.id!),
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
                                        title: Text(
                                          searchResult[index].metas.title!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.greenAccent),
                                        ),
                                        subtitle: Text(
                                          searchResult[index].metas.artist!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.greenAccent),
                                        ),
                                      ),
                                    );
                                  }
                                  return Container();
                                });
                          }),
                    )
                  : const Padding(
                      padding: EdgeInsets.all(30),
                      child: Text(
                        "No result found",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.greenAccent,
                        ),
                      ),
                    )
              : const SizedBox()
        ],
      ),
    );
  }
}
