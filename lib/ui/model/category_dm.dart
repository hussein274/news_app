import 'package:news_app/ui/utils/app_assets.dart';

class CategoryDm {
  String id;
  String text;
  String imagePath;
  CategoryDm(this.id, this.text, this.imagePath);

  static List<CategoryDm> getCategory(bool isDark) {
    return [
      CategoryDm(
        "general",
        "general",
        !isDark ? AppAssets.generalDark : AppAssets.generalLight,
      ),
      CategoryDm(
        "business",
        "business",
        !isDark ? AppAssets.busninessDark : AppAssets.busniessLight,
      ),
      CategoryDm(
        "entertainment",
        "entertainment",
        !isDark ? AppAssets.entertainmentDark : AppAssets.entertainmentLight,
      ),
      CategoryDm(
        "health",
        "health",
        !isDark ? AppAssets.healthDark : AppAssets.helthLight,
      ),
      CategoryDm(
        "science",
        "science",
        !isDark ? AppAssets.scienceDark : AppAssets.scienceLight,
      ),
      CategoryDm(
        "technology",
        "technology",
        !isDark ? AppAssets.technologyDark : AppAssets.technologyLight,
      ),
      CategoryDm(
        "sports",
        "sports",
        !isDark ? AppAssets.sportsDark : AppAssets.sportLight,
      ),
    ];
  }
}
