import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../custom/Settings_custom.dart';

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
    return
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         centerTitle: true,
//         elevation: 0,
//         title: const Text(
//           "Settings",
//           style: TextStyle(),
//         ),
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: const Icon(
//             Icons.arrow_back_outlined,
//             size: 30,
//           ),
//         ),
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage('assets/download (1).jpg'), fit: BoxFit.cover),
//         ),
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 10,
//             ),
//             ListTile(
//               iconColor: Colors.white,
//               dense: true,
//               title: const Text("Notifications",
//                   style: TextStyle(
//                       fontSize: 25, color: Color.fromARGB(255, 231, 238, 243))),
//               horizontalTitleGap: 2,
//               trailing: Switch(
//                   value: isSwitch,
//                   inactiveThumbColor: Color.fromARGB(255, 81, 91, 100),
//                   inactiveTrackColor: Colors.white,
//                   activeTrackColor: Color.fromARGB(255, 246, 248, 250),
//                   activeColor: Color.fromARGB(255, 30, 75, 138),
//                   onChanged: (val) {
//                     setState(() {
//                       isSwitch = val;
//                     });
//                   }),
//               contentPadding: const EdgeInsets.fromLTRB(19, 0, 7, 0),
//               leading: const Icon(
//                 Icons.notification_add,
//                 size: 22,
//               ),
//             ),
//             Settings_custom(
//               icon: const Icon(
//                 Icons.lock_outlined,
//                 size: 22,
//               ),
//               left: 16,
//               gap: 5,
//               titletext: "Privacy Policy",
//             ),
//             Settings_custom(
//                 icon: const Icon(
//                   Icons.panorama_wide_angle_outlined,
//                   size: 22,
//                 ),
//                 left: 16,
//                 gap: 5,
//                 titletext: "Terms & Conditions"),
//             Settings_custom(
//               icon: const Icon(Icons.share_outlined, size: 22),
//               titletext: "Share The App",
//               left: 19,
//             ),
//             Settings_custom(
//               icon: const Icon(Icons.messenger_outline, size: 22),
//               titletext: "About",
//               left: 19,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
        Scaffold(
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
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.notifications, color: Colors.greenAccent),
            title: const Text(
              "Notifications",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            trailing: IconButton(
                icon: Switch(
                    value: notify,
                    inactiveThumbColor: Colors.greenAccent,
                    inactiveTrackColor: Colors.white,
                    activeTrackColor: Color.fromARGB(255, 246, 248, 250),
                    activeColor: Color.fromARGB(255, 30, 75, 138),
                    onChanged: (bool value) {
                      setState(() {
                        notify = value;
                        saveSwitchState(value);
                      });
                    }),
                onPressed: () {}),
          ),
          ListTile(
            leading: Icon(
              Icons.share,
              color: Colors.greenAccent,
            ),
            onTap: () {},
            title: Text(
              'Share The App',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.lock,
              color: Colors.greenAccent,
            ),
            onTap: () {},
            title: Text(
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
            title: Text(
              'About',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
          const SizedBox(height: 250),
        ],
      ),
    );
  }
}
