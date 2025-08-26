import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/ui/screens/news/webv_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data/api_manager.dart';
import 'package:news_app/data/model/articles.dart';
import 'package:news_app/ui/utils/extension/build_context_extension.dart';
import 'package:news_app/ui/widget/erroe_view.dart';
import 'package:news_app/ui/widget/loading_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiManager apiManager = ApiManager();
  final TextEditingController searchController = TextEditingController();
  String query = "";
  late Future<List<Article>?> futureArticles;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureArticles = apiManager.searchArticles(query: query);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            buildSearch(),
            FutureBuilder(
              future: futureArticles,
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
            ),
          ],
        ),
      ),
    );
  }

  buildArticlesList(List<Article>? articles) {
    return Expanded(
      child: ListView.builder(
        itemCount: articles?.length ?? 0,
        itemBuilder: (context, index) =>
            buildArticleItem(context, articles![index]),
      ),
    );
  }

  buildArticleItem(BuildContext context, Article article) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary,
              ),
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
                  Text(
                    article.title ?? "",
                    style: context.textTheme.bodyMedium,
                  ),
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
        ],
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

  buildSearch() {
    var border = (OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
    ));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        controller: searchController,
        onChanged: (value) {
          query = value;
          setState(() {
            futureArticles = apiManager.searchArticles(query: query);
          });
        },
        decoration: InputDecoration(
          enabledBorder: border,
          suffixIcon: InkWell(
            onTap: () {
              query = "";
              searchController.clear();
              setState(() {
                futureArticles = apiManager.searchArticles(query: query);
              });
            },
            child: Icon(
              Icons.close,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.secondary,
          ),
          focusedBorder: border,
          border: border,

          hintText: "Search",
          hintStyle: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(fontSize: 20),
        ),
      ),
    );
  }
}
