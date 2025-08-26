import 'package:hive_flutter/adapters.dart';
import 'package:news_app/data/model/sources_dm.dart';
import 'package:news_app/data/repositories/data_sources/local_data_source_impl/news_local_datasource.dart';

class LocalDataSourcesImpl extends LocalDataSources {
  @override
  Future<List<SourceDm>> loadSource(String categoryId) async {
    var box = await Hive.openBox("news");
    var sources = box.get(categoryId);
    return sources;
  }

  @override
  Future<void> saveSource(String category, List<SourceDm> sources) async {
    var box = await Hive.openBox("news");
    box.put(category, sources);
  }
}
