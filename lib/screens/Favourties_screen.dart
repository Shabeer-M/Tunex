import 'package:flutter/material.dart';

class Favoourties_screen extends StatefulWidget {
  const Favoourties_screen({Key? key}) : super(key: key);

  @override
  State<Favoourties_screen> createState() => _Favoourties_screenState();
}

class _Favoourties_screenState extends State<Favoourties_screen> {
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
      body: Container(
          child: ListView(
        children: [
          Card(
              color: Color.fromARGB(73, 105, 168, 240),
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
                      Icons.delete,
                      size: 30,
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
              color: Color.fromARGB(73, 105, 168, 240),
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
                      Icons.delete,
                      size: 30,
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
              color: Color.fromARGB(73, 105, 168, 240),
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
                      Icons.delete,
                      size: 30,
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
