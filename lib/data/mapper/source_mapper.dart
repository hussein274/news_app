import 'package:news_app/data/model/sources_dm.dart';
import 'package:news_app/domain/model/source.dart';

class SourceMapper {
  Source fromDataModel(SourceDm source) {
    return Source(id: source.id ?? "", name: source.name ?? "");
  }

  List<Source> fromDataModels(List<SourceDm> sources) {
    return sources.map(fromDataModel).toList();
  }
}
