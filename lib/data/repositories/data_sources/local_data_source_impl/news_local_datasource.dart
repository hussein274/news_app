import 'package:news_app/data/model/sources_dm.dart';

abstract class LocalDataSources {
  Future<List<SourceDm>> loadSource(String categoryId);

  Future<void> saveSource(String category, List<SourceDm> sources);
}
