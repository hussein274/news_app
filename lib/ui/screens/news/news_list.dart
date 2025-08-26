import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/ui/screens/news/webv_view_screen.dart';

import 'package:flutter/material.dart';
import 'package:news_app/data/api_manager.dart';
import 'package:news_app/data/model/articles.dart';
import 'package:news_app/domain/model/source.dart';
import 'package:news_app/ui/utils/extension/build_context_extension.dart';
import 'package:news_app/ui/widget/erroe_view.dart';
import 'package:news_app/ui/widget/loading_view.dart';

class NewsList extends StatelessWidget {
  final Source source;
  NewsList({super.key, required this.source});
  final ApiManager apiManager = ApiManager();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: apiManager.loadArticles(source.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var articles = snapshot.data;
          return buildArticlesList(articles);
        } else if (snapshot.hasError) {
          var error = snapshot.error;
          return ErrorView(textError: error.toString());
        } else {
          return LoadingView();
        }
      },
    );
  }

  buildArticlesList(List<Article>? articles) {
    return ListView.builder(
      itemCount: articles?.length ?? 0,
      itemBuilder: (context, index) =>
          buildArticleItem(context, articles![index]),
    );
  }

  buildArticleItem(BuildContext context, Article article) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).colorScheme.secondary),
        ),
        child: InkWell(
          onTap: () => buildBottomSheet(context, article),
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: article.urlToImage ?? "",
                fit: BoxFit.cover,
                placeholder: (context, url) => LoadingView(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                height: MediaQuery.of(context).size.height * .25,
              ),
              Text(article.title ?? "", style: context.textTheme.bodyMedium),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      article.author ?? "",
                      style: context.textTheme.labelMedium,
                    ),
                  ),

                  Text(
                    article.publishedAt ?? "",
                    style: context.textTheme.labelMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future buildBottomSheet(BuildContext context, Article article) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(7),

            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(imageUrl: article.urlToImage ?? ""),
                ),
                SizedBox(height: 5),
                Text(article.title ?? "", style: context.textTheme.labelLarge),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebViewScreen(url: article.url!),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * .95,
                      56,
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "View Full Article",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
