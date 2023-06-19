import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/04_infrastructure/local/theme_local_storage.dart';

class ImageMapper {

  final ThemeLocalDatasource themeLocalDatasource;

  ImageMapper({required this.themeLocalDatasource});

  final Map<String, Map<String, Icon>> string2icon = {
    "square_list": {
      "light": const Icon(CupertinoIcons.square_list),
      "dark": const Icon(CupertinoIcons.square_list_fill)
    },
    "airplane": {
      "light": const Icon(CupertinoIcons.airplane),
      "dark": const Icon(CupertinoIcons.airplane)
    },
    "bag": {
      "light": const Icon(CupertinoIcons.bag),
      "dark": const Icon(CupertinoIcons.bag_fill)
    },
    "bandage": {
      "light": const Icon(CupertinoIcons.bandage),
      "dark": const Icon(CupertinoIcons.bandage_fill)
    },
    "bitcoin_circle": {
      "light": const Icon(CupertinoIcons.bitcoin_circle),
      "dark": const Icon(CupertinoIcons.bitcoin_circle_fill)
    },
    "book": {
      "light": const Icon(CupertinoIcons.book),
      "dark": const Icon(CupertinoIcons.book_fill)
    },
    "camera": {
      "light": const Icon(CupertinoIcons.camera),
      "dark": const Icon(CupertinoIcons.camera_fill)
    },
    "cart": {
      "light": const Icon(CupertinoIcons.cart),
      "dark": const Icon(CupertinoIcons.cart_fill)
    },
    "car": {
      "light": const Icon(CupertinoIcons.car),
      "dark": const Icon(CupertinoIcons.car_fill)
    },
    "cube_box": {
      "light": const Icon(CupertinoIcons.cube_box),
      "dark": const Icon(CupertinoIcons.cube_box_fill)
    },
    "laptop": {
      "light": const Icon(CupertinoIcons.device_laptop),
      "dark": const Icon(CupertinoIcons.device_laptop)
    },
    "document": {
      "light": const Icon(CupertinoIcons.doc),
      "dark": const Icon(CupertinoIcons.doc_fill)
    },
    "music": {
      "light": const Icon(CupertinoIcons.double_music_note),
      "dark": const Icon(CupertinoIcons.double_music_note)
    },
    "film": {
      "light": const Icon(CupertinoIcons.film),
      "dark": const Icon(CupertinoIcons.film_fill)
    },
    "gamecontroller": {
      "light": const Icon(CupertinoIcons.gamecontroller),
      "dark": const Icon(CupertinoIcons.gamecontroller_fill)
    },
    "gift": {
      "light": const Icon(CupertinoIcons.gift),
      "dark": const Icon(CupertinoIcons.gift_fill)
    },
    "group": {
      "light": const Icon(CupertinoIcons.group),
      "dark": const Icon(CupertinoIcons.group_solid)
    },
    "hammer": {
      "light": const Icon(CupertinoIcons.hammer),
      "dark": const Icon(CupertinoIcons.hammer_fill)
    },
    "house": {
      "light": const Icon(CupertinoIcons.house),
      "dark": const Icon(CupertinoIcons.house_fill)
    },
    "lab": {
      "light": const Icon(CupertinoIcons.lab_flask),
      "dark": const Icon(CupertinoIcons.lab_flask_solid)
    },
    "paw": {
      "light": const Icon(CupertinoIcons.paw),
      "dark": const Icon(CupertinoIcons.paw_solid)
    },
    "sport": {
      "light": const Icon(CupertinoIcons.sportscourt),
      "dark": const Icon(CupertinoIcons.sportscourt_fill)
    },
    "stopwatch": {
      "light": const Icon(CupertinoIcons.stopwatch),
      "dark": const Icon(CupertinoIcons.stopwatch_fill)
    },
    "tickets": {
      "light": const Icon(CupertinoIcons.tickets),
      "dark": const Icon(CupertinoIcons.tickets_fill)
    },
  };

  Future<Icon> toIcon(String id) async{
    final theme = await themeLocalDatasource.getCachedThemeData();
    final icon = string2icon[id]?[theme];
    if (icon!=null) return icon;
    return string2icon["square_list"]![theme]!;
  }

  String toID(IconData id) {
    //TODO implement from icon to id (might not be neccessary)
    throw UnimplementedError();
  }

}
