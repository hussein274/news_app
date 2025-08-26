
import 'package:flutter/material.dart';
import 'package:news_app/ui/model/category_dm.dart';
import 'package:news_app/ui/provider/theme_provider.dart';
import 'package:news_app/ui/utils/app_routes.dart';
import 'package:news_app/ui/utils/extension/build_context_extension.dart';
import 'package:news_app/ui/widget/custom_app_scaffold.dart';
import 'package:provider/provider.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
late ThemeModeProvider themeModeProvider;
@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    themeModeProvider=Provider.of<ThemeModeProvider>(context);
  }
  @override
  Widget build(BuildContext context) {
    var category=CategoryDm.getCategory(themeModeProvider.isDarkMode);
    return AppScaffold(titleAppBar: "Home",
        body: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text("Good Morning",style: Theme.of(context).textTheme.titleMedium,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text("Here is Some News For You",
                style: Theme.of(context).textTheme.titleMedium,),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount:category .length,
                  itemBuilder:(context, index) {
                    return buildWidgetListView(category,index);
                  },),
            )
          ],
        ));
  }

  buildWidgetListView(List<CategoryDm> category, int index) {
  return InkWell(
    onTap: (){
      Navigator.push(context, AppRoutes.news(category[index]));
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
      image: DecorationImage(image: AssetImage(category[index].imagePath),fit:BoxFit.fill )),
      height: MediaQuery.of(context).size.height*.2,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: index %2==0? CrossAxisAlignment.end:CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(category[index].text,style:
            Theme.of(context).textTheme.titleLarge ,),

           Container(
             height: 55,
             width:157,
             decoration: BoxDecoration(color: Theme.of(context).primaryColor.withAlpha(122),
                 borderRadius:BorderRadius.circular(84) ),
             child:
             index%2==0?
             Row(
               mainAxisAlignment:index %2==0? MainAxisAlignment.end:MainAxisAlignment.start,
               children: [
                 SizedBox(width: 5,),
                 Text("ViewAll",style: Theme.of(context).textTheme.titleLarge,),

                 Spacer(),
                 CircleAvatar(
                   backgroundColor: context.primaryColor,
                   radius: 25,
                   child: Icon(Icons.arrow_forward,color: Theme.of(context).colorScheme.secondary,),),


               ],):
             Row(
               mainAxisAlignment:index %2==0? MainAxisAlignment.end:MainAxisAlignment.start,
               children: [

                 CircleAvatar(
                   backgroundColor: context.primaryColor,
                   radius: 25,
                   child: Icon(Icons.arrow_back,color: Theme.of(context).colorScheme.secondary,),),


                 Spacer(),
                 Text("ViewAll",style: Theme.of(context).textTheme.titleLarge,),

                 SizedBox(width: 5,),
               ],)





           )

          ],
        ),
      ),
    ),
  );
  }
}
