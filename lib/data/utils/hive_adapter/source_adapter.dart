import 'package:hive_flutter/adapters.dart';
import 'package:news_app/data/model/sources_dm.dart';

class SourceAdabter extends TypeAdapter<SourceDm> {
  @override
  SourceDm read(BinaryReader reader) {
    var json = reader.readMap();
    return SourceDm.fromJson(json);
    // TODO: implement read
  }

  @override
  // TODO: implement typeId
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, SourceDm obj) {
    // TODO: implement write
    writer.writeMap(obj.toJson());
  }
}
