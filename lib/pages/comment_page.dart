import 'package:flutter/material.dart';
import 'package:flutter_intesasoft_demo/services/post_provider.dart';
import 'package:provider/provider.dart';

class Comments extends StatelessWidget {
  final String authorId;

  const Comments({required this.authorId});

  @override
  Widget build(BuildContext context) {
    var comment = Provider.of<PostProvider>(context, listen: false)
        .getFirstComment(authorId)
        .comments![0];
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(5),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Column(children: [
          ListTile(
            leading: CircleAvatar(
              child: Image.network(comment.authorProfileImage ?? ''),
            ),
            title: Text(comment.authorName ?? ''),
            subtitle: Text(comment.description ?? ''),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.emoji_emotions_sharp),
              Icon(Icons.emoji_emotions_outlined)
            ],
          )
        ]),
      ),
    );
  }
}
