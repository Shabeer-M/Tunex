import 'package:hive_flutter/adapters.dart';

String boxname = "songs";

class Boxes {
  static Box<List>? _box;

  static Box<List> getInstance() {
    return _box ??= Hive.box(boxname);
  }
}
