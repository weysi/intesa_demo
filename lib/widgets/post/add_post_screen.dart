import 'package:flutter/material.dart';

import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_intesasoft_demo/services/post_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../../models/post.dart';

class AddPostScreen extends StatefulWidget {
  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  XFile? image;
  String? description;
  String? authorId;
  var _postController = new TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _postController.dispose();
  }

  void takePicture() async {
    final _picker = ImagePicker();

    image = await _picker.pickImage(
        source: ImageSource.camera, maxHeight: 400, maxWidth: 400);

    print(image!.path);
  }

  void submit() async {
    if (image != null &&
        (_postController.value != null || _postController.value != '')) {
      try {
        image!.saveTo('assets/photos/');
        await Provider.of<PostProvider>(context, listen: false)
            .pustComment(
          Post(
              authorId: this.authorId,
              authorName: 'faruk',
              authorProfileImage: image!.path.toString(),
              comments: null,
              createdAt: DateTime.now().toString(),
              description: this.description,
              disLikeCount: 0,
              likeCount: 0,
              media: ''),
        )
            .catchError((e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Container(
                child: Center(
                  child: Text(e.toString()),
                ),
              ),
            ),
          );
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              child: Center(
                child: Text(e.toString()),
              ),
            ),
          ),
        );
      }
    }
  }

  ListTile _listTile() => ListTile(
        leading: CircleAvatar(
          child: FlutterLogo(
            size: 24,
          ),
        ),
        title: Text(
          'Faruk Topal',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
            Icon(Icons.drive_folder_upload_outlined),
            SizedBox(
              width: 5,
            ),
            Text(
              'Gönderi',
            ),
            SizedBox(
              width: 5,
            ),
            Text('25'),
            SizedBox(
              width: 40,
            ),
            Icon(Icons.message),
            SizedBox(
              width: 5,
            ),
            Text('Yorum'),
            SizedBox(
              width: 5,
            ),
            Text('10'),
          ],
        ),
      );

  TextField _textField() => TextField(
        controller: _postController,
        onChanged: (value) {
          if (value.length < 5) {
            authorId = Guid.newGuid.toString();
            description = value;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please input at least 5 character'),
              ),
            );
          }
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          labelText: "Lütfen bir şeyler giriniz...",
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
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

  @override
  Widget build(BuildContext context) {
    final pageSize = MediaQuery.of(context).size;
    return Container(
      height: pageSize.height * 0.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _listTile(),
          SizedBox(
            height: 10,
          ),
          _textField(),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: takePicture,
                icon: Icon(Icons.drive_folder_upload_rounded),
                label: Text('Fotoğraf/Video Yükle'),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.grey),
              ),
              TextButton.icon(
                onPressed: submit,
                icon: Icon(Icons.share, color: Colors.black),
                label: Text(
                  'Paylaş',
                  style: TextStyle(color: Colors.black),
                ),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
