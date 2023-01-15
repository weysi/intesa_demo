import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../../services/post_provider.dart';
import 'package:intl/intl.dart';
import '../../models/post.dart';
import '/pages/comment_page.dart';

class PostScreen extends StatefulWidget {
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  TextEditingController _addComment = TextEditingController();

  @override
  void dispose() {
    //
    super.dispose();
    _addComment.dispose();
  }

  ListTile _listTile(String media, String name, String createdPost) => ListTile(
        leading: CircleAvatar(
            child: Image.network(
          media,
          fit: BoxFit.cover,
        )),
        title: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(createdPost),
      );

  TextField _textField(String media) => TextField(
        controller: _addComment,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          labelText: "Lütfen bir şeyler giriniz...",
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.send, color: Colors.orange),
            onPressed: null,
          ),
          prefixIcon: Image.network(media),
          prefixIconConstraints: BoxConstraints(maxHeight: 18),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
        cursorColor: Colors.black,
      );

  Row _likeButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.emoji_emotions),
          Icon(Icons.emoji_emotions_outlined),
          Icon(Icons.access_alarm_rounded),
        ],
      );

  Future<void> refreshPosts(BuildContext context) async {
    await Provider.of<PostProvider>(context, listen: false).getPosts();
  }

  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<PostProvider>(context, listen: false).posts;
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
          height: size.height * 0.65,
          child: FutureBuilder(
              future: refreshPosts(context),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return Consumer<PostProvider>(
                    builder: (ctx, postData, _) => ListView.builder(
                          itemCount: postData.posts.length,
                          itemBuilder: (ctx, index) => Container(
                            margin: EdgeInsets.only(bottom: 8),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                    width: 2,
                                    color: Colors.orange,
                                    style: BorderStyle.solid)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _listTile(
                                    postData.posts[index].media!,
                                    postData.posts[index].authorName!,
                                    DateFormat('dd/MM/yyyy').format(
                                      DateTime.parse(
                                          postData.posts[index].createdAt!),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(postData.posts[index].description!),
                                  //Resim girilecek...
                                  Container(
                                    height: 110,
                                    width: double.infinity,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Image.network(
                                        postData.posts[index].authorProfileImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  _likeButtons(),
                                  if (postData
                                      .posts[index].comments!.isNotEmpty)
                                    Comments(
                                      authorId: postData.posts[index].authorId!,
                                    ),
                                  if (postData.posts[index].comments!.isEmpty)
                                    Text('Lütfen Yorum Giriniz ...'),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  _textField(postData.posts[index].media!),
                                ]),
                          ),
                        ));
              })),
    );
  }
}
