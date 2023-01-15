class Comment {
  String? createdAt;
  String? authorName;
  String? authorId;
  String? description;
  int? likeCount;
  int? disLikeCount;
  String? authorProfileImage;
  String? id;
  String? postId;

  Comment(
      {this.createdAt,
      this.authorName,
      this.authorId,
      this.description,
      this.likeCount,
      this.disLikeCount,
      this.authorProfileImage,
      this.id,
      this.postId});

  Comment.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    authorName = json['authorName'];
    authorId = json['authorId'];
    description = json['description'];
    likeCount = json['likeCount'];
    disLikeCount = json['disLikeCount'];
    authorProfileImage = json['authorProfileImage'];
    id = json['id'];
    postId = json['postId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['authorName'] = this.authorName;
    data['authorId'] = this.authorId;
    data['description'] = this.description;
    data['likeCount'] = this.likeCount;
    data['disLikeCount'] = this.disLikeCount;
    data['authorProfileImage'] = this.authorProfileImage;
    data['id'] = this.id;
    data['postId'] = this.postId;
    return data;
  }
}
