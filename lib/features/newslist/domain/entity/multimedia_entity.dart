import 'package:equatable/equatable.dart';

class MultimediaEntity extends Equatable {
  String caption;
  String copyright;
  String format;
  int height;
  String subtype;
  String type;
  String url;
  int width;

  MultimediaEntity(
      {this.caption,
      this.copyright,
      this.format,
      this.height,
      this.subtype,
      this.type,
      this.url,
      this.width});

  @override
  List<Object> get props =>
      [caption, copyright, format, height, subtype, type, url, width];
}
