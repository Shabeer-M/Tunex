import 'package:flutter/material.dart';

import '../custom/Settings_custom.dart';

class Settings_screen extends StatefulWidget {
  Settings_screen({Key? key}) : super(key: key);

  @override
  State<Settings_screen> createState() => _Settings_screenState();
}

class _Settings_screenState extends State<Settings_screen> {
  bool isSwitch = true;

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
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/download (1).jpg'), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            ListTile(
              iconColor: Colors.white,
              dense: true,
              title: const Text("Notifications",
                  style: TextStyle(
                      fontSize: 25, color: Color.fromARGB(255, 231, 238, 243))),
              horizontalTitleGap: 2,
              trailing: Switch(
                  value: isSwitch,
                  inactiveThumbColor: Color.fromARGB(255, 81, 91, 100),
                  inactiveTrackColor: Colors.white,
                  activeTrackColor: Color.fromARGB(255, 246, 248, 250),
                  activeColor: Color.fromARGB(255, 30, 75, 138),
                  onChanged: (val) {
                    setState(() {
                      isSwitch = val;
                    });
                  }),
              contentPadding: const EdgeInsets.fromLTRB(19, 0, 7, 0),
              leading: const Icon(
                Icons.notification_add,
                size: 22,
              ),
            ),
            Settings_custom(
              icon: const Icon(
                Icons.lock_outlined,
                size: 22,
              ),
              left: 16,
              gap: 5,
              titletext: "Privacy Policy",
            ),
            Settings_custom(
                icon: const Icon(
                  Icons.panorama_wide_angle_outlined,
                  size: 22,
                ),
                left: 16,
                gap: 5,
                titletext: "Terms & Conditions"),
            Settings_custom(
              icon: const Icon(Icons.share_outlined, size: 22),
              titletext: "Share The App",
              left: 19,
            ),
            Settings_custom(
              icon: const Icon(Icons.messenger_outline, size: 22),
              titletext: "About",
              left: 19,
            ),
          ],
        ),
      ),
    );
  }
}
