import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:news_app_again/models/author.dart';
import 'package:news_app_again/utilities/api_utilities.dart';

class AuthorAPI{

  Future<List<Author>> fetchAllAuthors() async {
    List<Author> authors = List<Author>();
    String allAuthorsApi = baseApi + allAuthorsApiUtilities;
    var response =  await http.get(allAuthorsApi);
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      var data = jsonData["data"];
      for(var item in data){
        Author author = Author(item["id"].toString(), item["name"].toString(), item["email"].toString(), item["avatar"]);
        authors.add(author);
      }
    }
    return authors;
  }
}