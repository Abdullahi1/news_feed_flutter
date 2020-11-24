import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:new_feed/features/newslist/data/model/Multimedia.dart';

class MultimediaConverter extends TypeConverter<List<Multimedia>, String> {
  @override
  List<Multimedia> decode(String databaseValue) {
    List<Map<String, dynamic>> decodeData = jsonDecode(databaseValue);
    return decodeData.map((result) => Multimedia.fromJson(result)).toList();
  }

  @override
  String encode(List<Multimedia> value) {
    var jsonData = value.map((result) => result.toJson()).toList();
    return jsonEncode(jsonData);
  }
}
