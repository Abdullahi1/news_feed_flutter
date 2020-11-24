import 'package:new_feed/core/mapper/mapper.dart';
import 'package:new_feed/features/newslist/data/model/Multimedia.dart';
import 'package:new_feed/features/newslist/domain/entity/multimedia_entity.dart';

class MultimediaMapper implements Mapper<MultimediaEntity, Multimedia> {
  @override
  Multimedia from(MultimediaEntity entity) => Multimedia(
      caption: entity.caption,
      copyright: entity.copyright,
      format: entity.format,
      height: entity.height,
      subtype: entity.subtype,
      type: entity.type,
      url: entity.url,
      width: entity.width);

  @override
  MultimediaEntity to(Multimedia domain) => MultimediaEntity(
      caption: domain.caption,
      copyright: domain.copyright,
      format: domain.format,
      height: domain.height,
      subtype: domain.subtype,
      type: domain.type,
      url: domain.url,
      width: domain.width);
}
