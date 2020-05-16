import 'package:newsmock/models/categories_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> category = new List<CategoryModel>();

  CategoryModel categoryModel = new CategoryModel();
  categoryModel.categoryName = "business";
  category.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "entertainment";
  category.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "general";
  category.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "health";
  category.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "science";
  category.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "sports";
  category.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "technology";
  category.add(categoryModel);

  return category;
}
