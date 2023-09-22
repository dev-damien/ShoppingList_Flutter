import 'package:flutter/cupertino.dart';

class ImageMapper {
  //! ========== images for LISTS ================
  static const Map<String, Map<String, IconData>> string2iconDataList = {
    "square_list": {
      "default": CupertinoIcons.square_list,
      "filled": CupertinoIcons.square_list_fill,
    },
    "airplane": {
      "default": CupertinoIcons.airplane,
      "filled": CupertinoIcons.airplane,
    },
    "bag": {
      "default": CupertinoIcons.bag,
      "filled": CupertinoIcons.bag_fill,
    },
    "bandage": {
      "default": CupertinoIcons.bandage,
      "filled": CupertinoIcons.bandage_fill,
    },
    "bitcoin_circle": {
      "default": CupertinoIcons.bitcoin_circle,
      "filled": CupertinoIcons.bitcoin_circle_fill,
    },
    "book": {
      "default": CupertinoIcons.book,
      "filled": CupertinoIcons.book_fill,
    },
    "camera": {
      "default": CupertinoIcons.camera,
      "filled": CupertinoIcons.camera_fill,
    },
    "cart": {
      "default": CupertinoIcons.cart,
      "filled": CupertinoIcons.cart_fill,
    },
    "car": {
      "default": CupertinoIcons.car,
      "filled": CupertinoIcons.car_fill,
    },
    "cube_box": {
      "default": CupertinoIcons.cube_box,
      "filled": CupertinoIcons.cube_box_fill,
    },
    "laptop": {
      "default": CupertinoIcons.device_laptop,
      "filled": CupertinoIcons.device_laptop,
    },
    "document": {
      "default": CupertinoIcons.doc,
      "filled": CupertinoIcons.doc_fill,
    },
    "music": {
      "default": CupertinoIcons.double_music_note,
      "filled": CupertinoIcons.double_music_note,
    },
    "film": {
      "default": CupertinoIcons.film,
      "filled": CupertinoIcons.film_fill,
    },
    "gamecontroller": {
      "default": CupertinoIcons.gamecontroller,
      "filled": CupertinoIcons.gamecontroller_fill,
    },
    "gift": {
      "default": CupertinoIcons.gift,
      "filled": CupertinoIcons.gift_fill,
    },
    "group": {
      "default": CupertinoIcons.group,
      "filled": CupertinoIcons.group_solid,
    },
    "hammer": {
      "default": CupertinoIcons.hammer,
      "filled": CupertinoIcons.hammer_fill,
    },
    "house": {
      "default": CupertinoIcons.house,
      "filled": CupertinoIcons.house_fill,
    },
    "lab": {
      "default": CupertinoIcons.lab_flask,
      "filled": CupertinoIcons.lab_flask_solid,
    },
    "paw": {
      "default": CupertinoIcons.paw,
      "filled": CupertinoIcons.paw_solid,
    },
    "sport": {
      "default": CupertinoIcons.sportscourt,
      "filled": CupertinoIcons.sportscourt_fill,
    },
    "stopwatch": {
      "default": CupertinoIcons.stopwatch,
      "filled": CupertinoIcons.stopwatch_fill,
    },
    "tickets": {
      "default": CupertinoIcons.tickets,
      "filled": CupertinoIcons.tickets_fill,
    },
  };

  //! ========== images for USERS ================

  static const Map<String, Map<String, IconData>> string2iconDataUser = {
    "profile_circled": {
      "default": CupertinoIcons.profile_circled,
      "filled": CupertinoIcons.profile_circled,
    },
    "ant": {
      "default": CupertinoIcons.ant,
      "filled": CupertinoIcons.ant_fill,
    },
    "eye": {
      "default": CupertinoIcons.eye,
      "filled": CupertinoIcons.eye_fill,
    },
    "person_alt_circle": {
      "default": CupertinoIcons.person_alt_circle,
      "filled": CupertinoIcons.person_alt_circle_fill,
    },
  };

  static final Map<IconData, String> iconData2stringList =
      _reverseMap(string2iconDataList);

  static final Map<IconData, String> iconData2stringUser =
      _reverseMap(string2iconDataUser);

  static IconData toIconData(String id) {
    return string2iconDataList[id]?['default'] ??
        string2iconDataUser[id]?['default'] ??
        CupertinoIcons.nosign;
  }

  static String toID(IconData icon) {
    return iconData2stringList[icon] ??
        iconData2stringUser[icon] ??
        'Invalid IconData';
  }

  static Map<IconData, String> _reverseMap(
      Map<String, Map<String, IconData>> map) {
    Map<IconData, String> iconData2string = {};
    map.forEach((id, styles) {
      styles.forEach((style, icon) {
        iconData2stringList[icon] = id;
      });
    });
    return iconData2string;
  }
}
