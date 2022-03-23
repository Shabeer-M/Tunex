import 'package:flutter/material.dart';

class Playlistinner_screen extends StatefulWidget {
  const Playlistinner_screen({Key? key}) : super(key: key);

  @override
  State<Playlistinner_screen> createState() => _Playlistinner_screenState();
}

class _Playlistinner_screenState extends State<Playlistinner_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Malayalam",
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
      body: Container(
          child: ListView(
        children: [
          Card(
              color: Color.fromARGB(31, 105, 240, 175),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/Arbic.jpg'),
                ),
                title: Text(
                  "Halamathi Habibo..",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_vert,
                      size: 35,
                      color: Color.fromARGB(255, 243, 242, 242),
                    )),
                subtitle: Text("Deepthi Balasubramaniyan"),
                dense: true,
                selected: true,
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => Nowplaying_screen()),
                  // );
                },
              )),
          Card(
              color: Color.fromARGB(31, 105, 240, 175),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/closer.jpg'),
                ),
                title: Text(
                  "Closer..",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_vert,
                      size: 35,
                      color: Colors.white,
                    )),
                subtitle: Text("The Chainsmoker"),
                dense: true,
                selected: true,
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => Nowplaying_screen()),
                  // );
                },
              )),
          Card(
              color: Color.fromARGB(31, 105, 240, 175),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/billa.jpg'),
                ),
                title: Text(
                  "My Name is Billa..",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_vert,
                      size: 35,
                      color: Colors.white,
                    )),
                subtitle: Text(" S. P Balasubramaniyan"),
                dense: true,
                selected: true,
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => Nowplaying_screen()),
                  // );
                },
              )),
        ],
        padding: EdgeInsets.all(20),
      )),
    );
  }
}
