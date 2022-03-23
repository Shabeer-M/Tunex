import 'package:flutter/material.dart';

class Settings_custom extends StatelessWidget {
  final Widget icon;
  final String titletext;
  double left;
  double? gap;
  Widget? trailingthing;
  Settings_custom(
      {Key? key,
      this.trailingthing,
      this.gap,
      required this.icon,
      required this.titletext,
      required this.left})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      iconColor: Colors.white,
      dense: true,
      leading: icon,
      title: Text(titletext,
          style: TextStyle(
              fontSize: 25, color: Color.fromARGB(255, 231, 238, 243))),
      contentPadding: EdgeInsets.fromLTRB(left, 0, 29, 0),
      horizontalTitleGap: gap ?? 5,
      visualDensity: const VisualDensity(vertical: .3),
      trailing: trailingthing,
    );
  }
}
