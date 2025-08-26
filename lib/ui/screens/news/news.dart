import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/api_manager.dart';
import 'package:news_app/di/get_it_modules.dart';
import 'package:news_app/domain/model/source.dart';
import 'package:news_app/ui/model/category_dm.dart';
import 'package:news_app/ui/screens/news/news_list.dart';
import 'package:news_app/ui/screens/news/news_view_model.dart';
import 'package:news_app/ui/widget/custom_app_scaffold.dart';
import 'package:news_app/ui/widget/erroe_view.dart';
import 'package:news_app/ui/widget/loading_view.dart';

class News extends StatefulWidget {
  late CategoryDm categoryDm;
  News({super.key, required this.categoryDm});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  final ApiManager apiManager = ApiManager();
  NewViewModel viewModel = getIt();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.loadSource(widget.categoryDm.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: AppScaffold(
        titleAppBar: widget.categoryDm.id,
        body: Builder(
          builder: (context) {
            return BlocBuilder<NewViewModel, NewsState>(
              builder: (context, state) {
                if (state.errorMessage.isNotEmpty) {
                  return ErrorView(textError: state.errorMessage);
                } else if (state.sources.isNotEmpty) {
                  return buildTaps(state.sources, context);
                } else {
                  return Center(child: LoadingView());
                }
              },
            );
          },
        ),
      ),
    );
  }
}

Widget buildTaps(List<Source>? sources, BuildContext context) {
  return DefaultTabController(
    length: sources!.length,
    child: Column(
      children: [
        TabBar(
          isScrollable: true,
          indicatorColor: Theme.of(context).colorScheme.secondary,
          tabAlignment: TabAlignment.start,
          dividerColor: Colors.transparent,
          unselectedLabelStyle: Theme.of(context).textTheme.bodySmall,
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          tabs: sources.map((sources) => souraToMap(sources)).toList(),
        ),
        Expanded(
          child: TabBarView(
            children: sources
                .map((sources) => NewsList(source: sources))
                .toList(),
          ),
        ),
      ],
    ),
  );
}

Widget souraToMap(Source source) {
  return Tab(child: Text(source.name));
}
