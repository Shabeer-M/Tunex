import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tunexx/database/Songdatabe.dart';
import 'package:tunexx/screens/Playlist_inner.dart';

import '../database/box.dart';
import '../screens/Favourties_screen.dart';
import '../screens/Playlistitem.dart';

// class Playlisttab extends StatelessWidget {
//   const Playlisttab({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           children: [
//             ListTile(
//               leading: Icon(
//                 Icons.heart_broken_outlined,
//                 color: Colors.white,
//                 size: 30,
//               ),
//               title: Text(
//                 "Favourites",
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold),
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Favoourties_screen()),
//                 );
//               },
//             ),
//             GestureDetector(
//               onTap: (() {
//                 showDialog(
//                     context: context,
//                     builder: (ctx) {
//                       return Dialog(
//                         backgroundColor: Color.fromARGB(255, 41, 73, 58),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(40),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(40.0),
//                           child: Container(
//                             width: 300,
//                             height: 135,
//                             child: Column(
//                               children: [
//                                 TextField(
//                                     style: const TextStyle(color: Colors.white),
//                                     decoration: InputDecoration(
//                                       border: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(30),
//                                           borderSide: const BorderSide(
//                                               color: Colors.white)),
//                                       enabledBorder: OutlineInputBorder(
//                                           borderSide: const BorderSide(
//                                               color: Colors.white, width: 2),
//                                           borderRadius:
//                                               BorderRadius.circular(30)),
//                                       hintStyle: const TextStyle(
//                                           color: Color.fromARGB(
//                                               255, 202, 202, 202)),
//                                       hintText: 'Create a Playlist',
//                                       // fillColor: Color.fromARGB(255, 177, 174, 174),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(30),
//                                         borderSide: const BorderSide(
//                                           color: Color.fromARGB(
//                                               255, 155, 122, 122),
//                                           width: 2.0,
//                                         ),
//                                       ),
//                                     )),
//                                 const SizedBox(
//                                   height: 30,
//                                 ),
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       SizedBox(
//                                         width: 100,
//                                         child: ElevatedButton(
//                                             style: ElevatedButton.styleFrom(
//                                                 primary: Colors.white,
//                                                 shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             50))),
//                                             onPressed: () {
//                                               Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         Playlistitem()),
//                                               );
//                                             },
//                                             child: const Text(
//                                               'Create',
//                                               style: TextStyle(
//                                                   color: Colors.black),
//                                             )),
//                                       ),
//                                       SizedBox(
//                                         width: 80,
//                                         child: ElevatedButton(
//                                             style: ElevatedButton.styleFrom(
//                                                 primary: Colors.white,
//                                                 shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             20))),
//                                             onPressed: () {
//                                               Navigator.pop(context);
//                                             },
//                                             child: const Text(
//                                               'Cancel',
//                                               style: TextStyle(
//                                                   color: Colors.black),
//                                             )),
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     });
//               }),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children:const [
//                   Text(
//                     "+",
//                     style: TextStyle(color: Colors.greenAccent, fontSize: 30),
//                   ),
//                   Text(
//                     " Create playlist",
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  late TextEditingController controller;

  final excistingPlaylist = SnackBar(
    content: const Text(
      'This playlist name already exists',
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.grey[900],
  );

  final box = Boxes.getInstance();
  List playlists = [];
  //List<Songs> library = [];
  String? playlistName = '';

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
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          libraryList(
            child: ListTile(
              onTap: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text(
                          "Add new playlist",
                          style: TextStyle(fontSize: 18),
                        ),
                        content: TextField(
                          controller: controller,
                          autofocus: true,
                          cursorRadius: const Radius.circular(50),
                          cursorColor: Colors.black,
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                submit();
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
                                                child: Text('Remove playlist'),
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

          // ...playlists
          //     .map((e) => e != "musics" && e != "favorites"
          //         ? libraryList(
          //             child: ListTile(
          //                 onTap: () {
          //                   Navigator.push(
          //                     context,
          //                     MaterialPageRoute(
          //                         builder: (context) => PlaylistScreen(
          //                               playlistName: e,
          //                             )),
          //                   );
          //                 },
          //                 leading: Icon(
          //                   Icons.playlist_play,
          //                   color: Colors.white,
          //                   size: 30,
          //                 ),
          //                 title: Text(
          //                   e.toString(),
          //                   style: const TextStyle(
          //                       fontSize: 20, color: Colors.white),
          //                 ),
          //                 trailing: PopupMenuButton(
          //                     icon: Icon(
          //                       Icons.more_vert,
          //                       color: Colors.white,
          //                     ),
          //                     itemBuilder: (context) => [
          //                           PopupMenuItem(
          //                             child: Text('Remove playlist'),
          //                             value: "0",
          //                           ),
          //                         ],
          //                     onSelected: (value) {
          //                       if (value == "0") {
          //                         box.delete(e);
          //                         setState(() {
          //                           playlists = box.keys.toList();
          //                         });
          //                       }
          //                     })),
          //           )
          //         : Container())
          //     .toList()
        ],
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
