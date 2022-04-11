import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:tunexx/database/Songdatabe.dart';
import '../database/box.dart';

class buildSheet extends StatefulWidget {
  String playlistName;
  buildSheet({Key? key, required this.playlistName}) : super(key: key);

  @override
  _buildSheetState createState() => _buildSheetState();
}

class _buildSheetState extends State<buildSheet> {
  final box = Boxes.getInstance();

  List<Songsdb> dbSongs = [];
  List<Songsdb> playlistSongs = [];
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
    return Container(
        color: Colors.grey,
        padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
        child: ListView.builder(
          itemCount: dbSongs.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  child: QueryArtworkWidget(
                    id: int.parse(dbSongs[index].id!),
                    type: ArtworkType.AUDIO,
                    artworkBorder: BorderRadius.circular(15),
                    artworkFit: BoxFit.cover,
                    nullArtworkWidget: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        image: DecorationImage(
                          image: AssetImage("assets/defult.jpeg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                title: Text(
                  dbSongs[index].title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                trailing: playlistSongs
                        .where((element) =>
                            element.id.toString() ==
                            dbSongs[index].id.toString())
                        .isEmpty
                    ? IconButton(
                        onPressed: () async {
                          playlistSongs.add(dbSongs[index]);
                          await box.put(widget.playlistName, playlistSongs);

                          setState(() {});
                        },
                        icon: Icon(Icons.add))
                    : IconButton(
                        onPressed: () async {
                          playlistSongs.removeWhere((elemet) =>
                              elemet.id.toString() ==
                              dbSongs[index].id.toString());

                          await box.put(widget.playlistName, playlistSongs);
                          setState(() {});
                        },
                        icon: Icon(Icons.remove)),
              ),
            );
          },
        ));
  }
}
