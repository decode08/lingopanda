
class CommentsModel {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  CommentsModel({this.postId, this.id, this.name, this.email, this.body});

  CommentsModel.fromJson(Map<String, dynamic> json) {
    postId = json["postId"];
    id = json["id"];
    name = json["name"];
    email = json["email"];
    body = json["body"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["postId"] = postId;
    _data["id"] = id;
    _data["name"] = name;
    _data["email"] = email;
    _data["body"] = body;
    return _data;
  }
}