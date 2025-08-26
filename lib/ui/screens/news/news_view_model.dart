import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/domain/usecases/get_sources_bycategory.dart';

import '../../../domain/model/source.dart';

class NewViewModel extends Cubit<NewsState> {
  GetSourcesByCategoryUseCase getSourcesUseCase;
  NewViewModel(this.getSourcesUseCase)
    : super(NewsState(sources: [], isLoading: false, errorMessage: ""));

  loadSource(String categoryId) async {
    try {
      // isLoading=true;
      emit(NewsState(sources: [], isLoading: true, errorMessage: ""));
      var sources = (await getSourcesUseCase.execute(categoryId))!;
      emit(NewsState(sources: sources, isLoading: false, errorMessage: ""));
      // isLoading=false;
      // notifyListeners();
    } catch (e) {
      emit(
        NewsState(sources: [], isLoading: false, errorMessage: e.toString()),
      );
      // errorMessage=e.toString();
      // notifyListeners();
    }
  }
}

class NewsState {
  List<Source> sources = [];
  var isLoading = false;
  var errorMessage = "";
  NewsState({
    required this.sources,
    required this.isLoading,
    required this.errorMessage,
  });
}

// class NewViewModel extends ChangeNotifier{
//   GetSourcesByCategoryUseCase getSourcesUseCase;
//   NewViewModel(this.getSourcesUseCase);
//   List<Source> sources=[];
//   var isLoading=false;
//   var errorMessage="";
//
//   loadSoure(String categoryId)async{
//     try{
//       isLoading=true;
//       notifyListeners();
//       sources=(await getSourcesUseCase.execute(categoryId))!;
//       isLoading=false;
//       notifyListeners();
//     }catch(e){
//       errorMessage=e.toString();
//       notifyListeners();
//     }
//   }
// }
