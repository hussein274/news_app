import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news_app/data/repositories/data_sources/local_data_source_impl/news_local_datasource.dart';
import 'package:news_app/domain/model/source.dart';
import '../mapper/source_mapper.dart';
import 'data_sources/remote_data_source_impl/news_remote_datasource.dart';
import 'package:news_app/domain/repositories/new_repository.dart';

class NewsRepositoryImpl extends NewsRepository {
  NewsRemotDataSources newsRemotDataSources;
  LocalDataSources localDataSources;
  Connectivity connectivity;
  SourceMapper sourceMapper;
  NewsRepositoryImpl({
    required this.sourceMapper,
    required this.localDataSources,
    required this.newsRemotDataSources,
    required this.connectivity,
  });
  @override
  Future<List<Source>?> loudSource(String id) async {
    var result = await connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.mobile) ||
        (result.contains(ConnectivityResult.wifi))) {
      var sources = await newsRemotDataSources.loudSources(id);
      localDataSources.saveSource(id, sources ?? []);
      return sourceMapper.fromDataModels(sources ?? []);
    } else {
      return sourceMapper.fromDataModels(await localDataSources.loadSource(id));
    }
  }
}
