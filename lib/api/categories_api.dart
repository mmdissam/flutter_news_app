import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:news_app_again/models/category.dart';
import 'package:news_app_again/utilities/api_utilities.dart';

class CategoriesAPI{

  Future<List<Category>> fetchCategories() async {
    List<Category> categories = List<Category>();
    String categoriesUrl = baseApi + allCategoriesApiUtilities;

    var response = await http.get(categoriesUrl);

    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      var data = jsonData["data"];
      for(var item in data){
        Category category = Category(item["id"].toString(), item["title"].toString());
        categories.add(category);
      }
    }
    return categories;
  }
}