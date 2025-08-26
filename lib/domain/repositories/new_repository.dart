import 'package:news_app/domain/model/source.dart';

abstract class NewsRepository{

  Future<List<Source>?> loudSource(String id );




}