import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/data/api_manager.dart';
import 'package:news_app/data/mapper/source_mapper.dart';
import 'package:news_app/data/repositories/data_sources/local_data_source_impl/news_local_datasource.dart';
import 'package:news_app/data/repositories/data_sources/local_data_source_impl/news_local_datasource_impl.dart';
import 'package:news_app/data/repositories/data_sources/remote_data_source_impl/news_remote_datasource.dart';
import 'package:news_app/data/repositories/data_sources/remote_data_source_impl/news_remote_datasource_impl.dart';
import 'package:news_app/data/repositories/new_repository_impl.dart';
import 'package:news_app/domain/usecases/get_sources_bycategory.dart';

import '../domain/repositories/new_repository.dart';
import '../ui/screens/news/news_view_model.dart';

var getIt = GetIt.instance;
void configureDependencies() {
  getIt.registerSingleton(Connectivity());
  getIt.registerSingleton(SourceMapper());
  getIt.registerSingleton(ApiManager());
  getIt.registerSingleton<LocalDataSources>(LocalDataSourcesImpl());
  getIt.registerSingleton<NewsRemotDataSources>(
    NewsRemotDataSourcesImpl(getIt()),
  );
  getIt.registerSingleton<NewsRepository>(
    NewsRepositoryImpl(
      sourceMapper: getIt(),
      localDataSources: getIt(),
      newsRemotDataSources: getIt(),
      connectivity: getIt(),
    ),
  );
  getIt.registerSingleton(GetSourcesByCategoryUseCase(getIt()));
  getIt.registerSingleton(NewViewModel(getIt()));
}
