
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news_app/data/utils/hive_adapter/source_adapter.dart';
import 'package:news_app/ui/provider/theme_provider.dart';
import 'package:news_app/ui/screens/home/home.dart';
import 'package:news_app/ui/utils/app_theme.dart';
import 'package:provider/provider.dart';

import 'di/get_it_modules.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  Hive.initFlutter();
  Hive.registerAdapter(SourceAdabter());
  runApp(MultiProvider(providers:
  [
    ChangeNotifierProvider(create: (context) => ThemeModeProvider(),)
  ],
      child: MyApp(),
  )
  );
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  late ThemeModeProvider themeProvider;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    themeProvider=Provider.of<ThemeModeProvider>(context);
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.currentTheme,
      theme:AppTheme.lightTheme ,
      darkTheme: AppTheme.darkTheme,
     home: Home(),
    );
  }
}

