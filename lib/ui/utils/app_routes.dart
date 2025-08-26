import 'package:flutter/material.dart';
import 'package:news_app/ui/model/category_dm.dart';
import 'package:news_app/ui/screens/home/home.dart';
import 'package:news_app/ui/screens/news/news.dart';
import '../screens/search_screen/search.dart';
import '../screens/splash/splash.dart';

abstract final class AppRoutes{
static Route get splash=>MaterialPageRoute(builder: (context) => Splash(),);
static Route get home=>MaterialPageRoute(builder: (context) => Home(),);

static Route  news(CategoryDm category)=>MaterialPageRoute(builder: (context) => News(categoryDm: category,),);
static Route search()=>MaterialPageRoute(
  builder: (context) => SearchScreen(),);

}