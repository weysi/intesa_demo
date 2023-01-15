import 'package:flutter/material.dart';
import '../models/post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostProvider with ChangeNotifier {
  final _baseUrl =
      'https://63347899ea0de5318a039283.mockapi.io/intesa/mobil/post';
  List<Post> _posts = [];
  List<Post> get posts {
    return [..._posts];
  }

  Future<List<Post>> getPosts() async {
    var response = await http.get(Uri.parse(_baseUrl));
    List<Post> loadedData = [];
    try {
      if (response.statusCode == 200) {
        var postData = json.decode(response.body) as List<dynamic>;

        if (postData != null) {
          postData.forEach((value) {
            loadedData.add(Post.fromJson(value));
          });
        }
        print(loadedData[0].authorId);
        _posts = loadedData;
        notifyListeners();
        return _posts;
      } else {
        return _posts;
      }
    } catch (e) {
      throw (e);
    }
  }

  Post getFirstComment(String id) {
    return _posts.firstWhere((element) => element.authorId == id);
  }

  Future<void> pustComment(Post post) async {
    var url = Uri.parse(
        'https://63347899ea0de5318a039283.mockapi.io/intesa/mobil/post');
    try {
      final response = await http.post(url, body: json.encode(post));
      if (response.statusCode == 200) {
        _posts.add(post);
        print('....');
        notifyListeners();
      }
    } catch (e) {}
  }
}
