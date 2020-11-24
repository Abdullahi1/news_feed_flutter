import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:new_feed/features/newslist/data/model/Result.dart';

class ResultConverter extends TypeConverter<List<Result>, String> {
  @override
  List<Result> decode(String databaseValue) {
    var data = jsonDecode(databaseValue);
    List decodeData = data;
    return decodeData.map((result) => Result.fromJson(result)).toList();
  }

  @override
  String encode(List<Result> value) {
    var jsonData = value.map((result) => result.toJson()).toList();
    return jsonEncode(jsonData);
  }
}
