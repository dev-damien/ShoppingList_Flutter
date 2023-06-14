import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shoppinglist/04_infrastructure/models/list_preview_model.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final listPreview = ListPreviewModel(
      id: "",
      title: "test title",
      imageId: "1234abcd",
      isFavorite: false, 
      serverTimestamp: "10. März 2023 um 23:39:52 UTC+7");

  group("fromJson factory", () {
    test("should return a valid model", () {
      //* arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture("list_preview.json"));

      //* act
      final result = ListPreviewModel.fromMap(jsonMap);

      //* assert
      expect(result, listPreview);
    });
  });
}
