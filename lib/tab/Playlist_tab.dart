import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tunexx/database/Songdatabe.dart';
import 'package:tunexx/screens/Playlist_inner.dart';
import '../database/box.dart';
import '../screens/Favourties_screen.dart';
import '../screens/Playlistitem.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  late TextEditingController controller;
  final formkey = GlobalKey<FormState>();

  final excistingPlaylist = SnackBar(
    content: const Text(
      'This playlist name already exists',
      style: TextStyle(color: Colors.greenAccent),
    ),
    backgroundColor: Colors.grey[900],
  );

  final box = Boxes.getInstance();
  List playlists = [];

  String? playlistName = '';
  String? title;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: ListView(
          children: [
            libraryList(
              child: ListTile(
                onTap: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text(
                            "Add new playlist",
                            style: TextStyle(fontSize: 18),
                          ),
                          content: Form(
                            key: formkey,
                            child: TextFormField(
                              controller: controller,
                              autofocus: true,
                              cursorRadius: const Radius.circular(50),
                              cursorColor: Colors.black,
                              onChanged: (value) {
                                title = value.trim();
                              },
                              validator: (value) {
                                List keys = box.keys.toList();
                                if (value!.trim() == "") {
                                  return "name required";
                                }
                                if (keys
                                    .where((element) => element == value.trim())
                                    .isNotEmpty) {
                                  return "this name already exits";
                                }
                                return null;
                              },
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    submit();
                                  }
                                  // submit();
                                },
                                child: Text(
                                  "ADD",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ))
                          ],
                        )),
                leading: Icon(
                  Icons.library_add_outlined,
                  color: Colors.white,
                ),
                title: const Text(
                  "Create Playlist",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            libraryItems(
              title: "Favourites",
              leadIcon: Icons.favorite,
              leadSize: 25,
            ),
            ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, boxes, _) {
                  playlists = box.keys.toList();

                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: playlists.length,
                      itemBuilder: (context, index) => GestureDetector(
                          onTap: () {},
                          child: playlists[index] != "musics" &&
                                  playlists[index] != "favorites"
                              ? libraryList(
                                  child: ListTile(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Playlistinner_screen(
                                                    playlistName:
                                                        playlists[index],
                                                  )),
                                        );
                                      },
                                      leading: CircleAvatar(
                                          backgroundColor: Colors.black,
                                          backgroundImage: AssetImage(
                                              "assets/icons8-music-heart-96.png")),
                                      title: Text(
                                        playlists[index].toString(),
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      trailing: PopupMenuButton(
                                          icon: Icon(
                                            Icons.more_vert,
                                            color: Colors.white,
                                          ),
                                          itemBuilder: (context) => [
                                                PopupMenuItem(
                                                  child:
                                                      Text('Remove playlist'),
                                                  value: "0",
                                                ),
                                              ],
                                          onSelected: (value) {
                                            if (value == "0") {
                                              box.delete(playlists[index]);
                                              setState(() {
                                                playlists = box.keys.toList();
                                              });
                                            }
                                          })),
                                )
                              : Container()));
                }),
          ],
        ),
      ),
    );
  }

  Padding libraryItems(
      {required title,
      leadIcon = Icons.favorite,
      double leadSize = 28,
      tail,
      leadClr = Colors.white}) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 15),
      child: ListTile(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Favoourties_screen())),
          leading: Icon(
            Icons.favorite,
            color: Colors.white,
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
          trailing: IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Favoourties_screen())),
            icon: Icon(
              tail,
              size: 20,
            ),
          )),
    );
  }

  Padding libraryList({required child}) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
      child: child,
    );
  }

  void submit() {
    playlistName = controller.text;
    List<Songsdb> librayry = [];
    List? excistingName = [];
    if (playlists.isNotEmpty) {
      excistingName =
          playlists.where((element) => element == playlistName).toList();
    }

    if (playlistName != '' && excistingName.isEmpty) {
      box.put(playlistName, librayry);
      Navigator.of(context).pop();
      setState(() {
        playlists = box.keys.toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(excistingPlaylist);
    }

    controller.clear();
  }
}
