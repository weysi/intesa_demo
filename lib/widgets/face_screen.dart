import 'package:flutter/material.dart';
import 'post/add_post_screen.dart';
import 'post/posts_screen.dart';

class FaceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pageSize = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.all(8),
        height: pageSize.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddPostScreen(),
              SizedBox(
                height: 15,
              ),
              PostScreen()
            ],
          ),
        ));
  }
}
