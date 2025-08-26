import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:news_app/ui/provider/theme_provider.dart';
import 'package:news_app/ui/utils/app_colors.dart';
import 'package:news_app/ui/utils/app_routes.dart';
import 'package:news_app/ui/utils/extension/build_context_extension.dart';
import 'package:provider/provider.dart';

class AppScaffold extends StatefulWidget {
  final String titleAppBar;
  final Widget body;
  const AppScaffold({super.key, required this.titleAppBar, required this.body});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  late ThemeModeProvider providerTheme;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    providerTheme = Provider.of<ThemeModeProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Icon(
                Icons.menu,
                color: Theme.of(context).colorScheme.secondary,
              ),
            );
          },
        ),

        title: Text(widget.titleAppBar),
        actions: [InkWell(
            onTap: () => Navigator.push(context, AppRoutes.search()),
            child: Icon(Icons.search, color: context.secondaryColor))],
      ),
      drawer: buildDrawer(),
      body: widget.body,
    );
  }

  Widget buildDrawer() {
    return Container(
      width: context.width * .75,

      color: AppColor.black,
      child: Column(
        children: [
          Container(
            height: context.height * .15,
            width: context.width,
            color: Colors.white,
            child: Center(
              child: Text(
                "News App",
                style: context.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context, AppRoutes.home);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.home_outlined, color: AppColor.white, size: 24),

                      SizedBox(width: 5),
                      Text(
                        "go to home",
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColor.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Divider(color: AppColor.white),
                SizedBox(height: 10),
                Row(children: [
                  Icon(Icons.dark_mode_outlined,color: AppColor.white,),
                  SizedBox(width: 3,),
                  Text("Theme", style: context.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColor.white,
                  ))
                ],),
                SizedBox(height: 10,),
                buildDropDown(),
                SizedBox(height: 15,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildDropDown() {
    return DropdownButton2<ThemeMode>(
      buttonStyleData: ButtonStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColor.white),
        ),
      ),
      iconStyleData: IconStyleData(
        iconDisabledColor: AppColor.white,
        iconEnabledColor: AppColor.white,
      ),
      underline: Container(),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          color: AppColor.black,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColor.white),
        ),
      ),
      isExpanded: true,
      hint: Text(
        providerTheme.currentTheme == ThemeMode.dark ? "Dark" : "Light",
        style: const TextStyle(
          color: AppColor.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),

      value: providerTheme.currentTheme,
      items: [
        DropdownMenuItem(
          value: ThemeMode.light,
          child: Text("Light", style: TextStyle(color: AppColor.white,fontWeight: FontWeight.bold)),
        ),
        DropdownMenuItem(
          value: ThemeMode.dark,
          child: Text("Dark", style: TextStyle(color: AppColor.white,fontWeight: FontWeight.bold)),
        ),
      ],

      onChanged: (value) {
        if (value != null) {
          providerTheme.changeTheme(value);
        }
      },
    );
  }
}
