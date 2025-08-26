import 'package:flutter/material.dart';
import 'package:news_app/ui/provider/theme_provider.dart';
import 'package:news_app/ui/utils/app_routes.dart';
import 'package:news_app/ui/utils/app_assets.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late ThemeModeProvider provider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.push(context, AppRoutes.home);
      });
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    provider = Provider.of<ThemeModeProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        provider.currentTheme == ThemeMode.light
            ? AppAssets.splashLight
            : AppAssets.splashDark,
        fit: BoxFit.fill,
        width: MediaQuery.sizeOf(context).width,
      ),
    );
  }
}
