import 'package:flutter/cupertino.dart';
import 'package:shoppinglist/constants/default_values.dart';

class ImageMapper {
  static const Map<String, Map<String, Icon>> _string2icon = {
    "square_list": {
      "default": Icon(CupertinoIcons.square_list),
      "filled": Icon(CupertinoIcons.square_list_fill)
    },
    "airplane": {
      "default": Icon(CupertinoIcons.airplane),
      "filled": Icon(CupertinoIcons.airplane)
    },
    "bag": {
      "default": Icon(CupertinoIcons.bag),
      "filled": Icon(CupertinoIcons.bag_fill)
    },
    "bandage": {
      "default": Icon(CupertinoIcons.bandage),
      "filled": Icon(CupertinoIcons.bandage_fill)
    },
    "bitcoin_circle": {
      "default": Icon(CupertinoIcons.bitcoin_circle),
      "filled": Icon(CupertinoIcons.bitcoin_circle_fill)
    },
    "book": {
      "default": Icon(CupertinoIcons.book),
      "filled": Icon(CupertinoIcons.book_fill)
    },
    "camera": {
      "default": Icon(CupertinoIcons.camera),
      "filled": Icon(CupertinoIcons.camera_fill)
    },
    "cart": {
      "default": Icon(CupertinoIcons.cart),
      "filled": Icon(CupertinoIcons.cart_fill)
    },
    "car": {
      "default": Icon(CupertinoIcons.car),
      "filled": Icon(CupertinoIcons.car_fill)
    },
    "cube_box": {
      "default": Icon(CupertinoIcons.cube_box),
      "filled": Icon(CupertinoIcons.cube_box_fill)
    },
    "laptop": {
      "default": Icon(CupertinoIcons.device_laptop),
      "filled": Icon(CupertinoIcons.device_laptop)
    },
    "document": {
      "default": Icon(CupertinoIcons.doc),
      "filled": Icon(CupertinoIcons.doc_fill)
    },
    "music": {
      "default": Icon(CupertinoIcons.double_music_note),
      "filled": Icon(CupertinoIcons.double_music_note)
    },
    "film": {
      "default": Icon(CupertinoIcons.film),
      "filled": Icon(CupertinoIcons.film_fill)
    },
    "gamecontroller": {
      "default": Icon(CupertinoIcons.gamecontroller),
      "filled": Icon(CupertinoIcons.gamecontroller_fill)
    },
    "gift": {
      "default": Icon(CupertinoIcons.gift),
      "filled": Icon(CupertinoIcons.gift_fill)
    },
    "group": {
      "default": Icon(CupertinoIcons.group),
      "filled": Icon(CupertinoIcons.group_solid)
    },
    "hammer": {
      "default": Icon(CupertinoIcons.hammer),
      "filled": Icon(CupertinoIcons.hammer_fill)
    },
    "house": {
      "default": Icon(CupertinoIcons.house),
      "filled": Icon(CupertinoIcons.house_fill)
    },
    "lab": {
      "default": Icon(CupertinoIcons.lab_flask),
      "filled": Icon(CupertinoIcons.lab_flask_solid)
    },
    "paw": {
      "default": Icon(CupertinoIcons.paw),
      "filled": Icon(CupertinoIcons.paw_solid)
    },
    "sport": {
      "default": Icon(CupertinoIcons.sportscourt),
      "filled": Icon(CupertinoIcons.sportscourt_fill)
    },
    "stopwatch": {
      "default": Icon(CupertinoIcons.stopwatch),
      "filled": Icon(CupertinoIcons.stopwatch_fill)
    },
    "tickets": {
      "default": Icon(CupertinoIcons.tickets),
      "filled": Icon(CupertinoIcons.tickets_fill)
    },
  };

  static Map<IconData, String> _icon2string = _reverseMap();

  static Icon toIcon(String id) {
    return _string2icon[id]?['default'] ?? const Icon(CupertinoIcons.nosign);
  }

  static String toID(IconData icon) {
    return _icon2string[icon] ?? 'Invalid IconData';
  }

  static Map<IconData, String> _reverseMap() {
    Map<IconData, String> _icon2string = {};
    _string2icon.forEach((id, styles) {
      styles.forEach((style, icon) {
        _icon2string[icon.icon!] = id;
      });
    });
    return _icon2string;
  }
}
