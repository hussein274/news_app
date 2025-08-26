import 'package:news_app/data/api_manager.dart';
import 'package:news_app/data/model/sources_dm.dart';
import 'package:news_app/data/repositories/data_sources/remote_data_source_impl/news_remote_datasource.dart';

class NewsRemotDataSourcesImpl extends NewsRemotDataSources {
  ApiManager apiManager;
  NewsRemotDataSourcesImpl(this.apiManager);
  @override
  Future<List<SourceDm>?> loudSources(String categoryId) {
    return apiManager.loadSource(categoryId);
  }
}
