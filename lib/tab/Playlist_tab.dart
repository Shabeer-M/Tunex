import 'package:flutter/material.dart';

import '../screens/Favourties_screen.dart';
import '../screens/Playlistitem.dart';

class Playlisttab extends StatelessWidget {
  const Playlisttab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.heart_broken_outlined,
                color: Colors.white,
                size: 30,
              ),
              title: Text(
                "Favourites",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Favoourties_screen()),
                );
              },
            ),
            GestureDetector(
              onTap: (() {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return Dialog(
                        backgroundColor: Color.fromARGB(255, 41, 73, 58),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Container(
                            width: 300,
                            height: 135,
                            child: Column(
                              children: [
                                TextField(
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      hintStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 202, 202, 202)),
                                      hintText: 'Create a Playlist',
                                      // fillColor: Color.fromARGB(255, 177, 174, 174),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 155, 122, 122),
                                          width: 2.0,
                                        ),
                                      ),
                                    )),
                                SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50))),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Playlistitem()),
                                              );
                                            },
                                            child: Text(
                                              'Create',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )),
                                      ),
                                      SizedBox(
                                        width: 80,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20))),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "+",
                    style: TextStyle(color: Colors.greenAccent, fontSize: 30),
                  ),
                  Text(
                    " Create playlist",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
