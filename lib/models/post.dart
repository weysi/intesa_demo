import 'package:flutter/material.dart';
import './comment.dart';

class Post {
  String? createdAt;
  String? authorId;
  String? authorName;
  String? description;
  String? media;
  int? likeCount;
  int? disLikeCount;
  String? authorProfileImage;
  String? id;
  List<Comment>? comments;

  Post(
      {this.createdAt,
      this.authorId,
      this.authorName,
      this.description,
      this.media,
      this.likeCount,
      this.disLikeCount,
      this.authorProfileImage,
      this.id,
      this.comments});

  Post.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    authorId = json['authorId'];
    authorName = json['authorName'];
    description = json['description'];
    media = json['media'];
    likeCount = json['likeCount'];
    disLikeCount = json['disLikeCount'];
    authorProfileImage = json['authorProfileImage'];
    id = json['id'];
    if (json['comments'] != null) {
      comments = <Comment>[];
      json['comments'].forEach((v) {
        comments!.add(new Comment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['authorId'] = this.authorId;
    data['authorName'] = this.authorName;
    data['description'] = this.description;
    data['media'] = this.media;
    data['likeCount'] = this.likeCount;
    data['disLikeCount'] = this.disLikeCount;
    data['authorProfileImage'] = this.authorProfileImage;
    data['id'] = this.id;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
