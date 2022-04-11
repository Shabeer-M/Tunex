import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings_screen extends StatefulWidget {
  Settings_screen({Key? key}) : super(key: key);

  @override
  State<Settings_screen> createState() => _Settings_screenState();
}

class _Settings_screenState extends State<Settings_screen> {
  bool notify = true;

  @override
  void initState() {
    super.initState();
    getSwitchValues();
  }

  getSwitchValues() async {
    notify = await getSwitchState();
    setState(() {});
  }

  Future<bool> saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("switchState", value);
    return prefs.setBool("switchState", value);
  }

  Future<bool> getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? notify = prefs.getBool("switchState");

    return notify ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Settings",
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
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.black,
            Colors.greenAccent,
          ],
        )),
        child: Column(
          children: [
            ListTile(
              leading:
                  const Icon(Icons.notifications, color: Colors.greenAccent),
              title: const Text(
                "Notifications",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              trailing: IconButton(
                  icon: Switch(
                      value: notify,
                      inactiveThumbColor: Colors.greenAccent,
                      inactiveTrackColor: Colors.white,
                      activeTrackColor:
                          const Color.fromARGB(255, 246, 248, 250),
                      activeColor: const Color.fromARGB(255, 30, 75, 138),
                      onChanged: (bool value) {
                        setState(() {
                          notify = value;
                          saveSwitchState(value);
                        });
                      }),
                  onPressed: () {}),
            ),
            ListTile(
              leading: const Icon(
                Icons.share,
                color: Colors.greenAccent,
              ),
              onTap: () {
                Share.share(
                    "Hey, I'm sharing this offline Music player I hope, it will also help you.  Download it!!!");
              },
              title: const Text(
                'Share The App',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.lock,
                color: Colors.greenAccent,
              ),
              onTap: () {},
              title: const Text(
                'Privacy Policies',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.receipt,
                color: Colors.greenAccent,
              ),
              title: Text(
                'Terms and Conditions',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.info,
                color: Colors.greenAccent,
              ),
              onTap: () => showAboutDialog(
                  applicationIcon: Image.asset(
                    'assets/95ba9ecd-18db-49bc-b6e2-c739cd5caac7.png',
                    width: 70,
                    height: 40,
                  ),
                  context: context,
                  applicationName: 'TuneX',
                  applicationVersion: '1.0',
                  children: [
                    Text(
                        "         TuneX is a Music Player Created by Shabeer M."),
                  ]),
              title: Text(
                'About',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            const SizedBox(height: 250),
          ],
        ),
      ),
    );
  }
}
