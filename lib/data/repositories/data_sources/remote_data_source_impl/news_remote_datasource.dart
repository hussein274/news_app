import 'package:news_app/data/model/sources_dm.dart';

abstract class NewsRemotDataSources {
  Future<List<SourceDm>?> loudSources(String categoryId);
}
