import 'package:news_app/domain/model/source.dart';
import 'package:news_app/domain/repositories/new_repository.dart';
class GetSourcesByCategoryUseCase{
  NewsRepository newsRepository;
  GetSourcesByCategoryUseCase(this.newsRepository);

 Future<List<Source>?> execute(String category){
   return newsRepository.loudSource(category);
  }


}