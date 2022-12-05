///The model of the user.
class UserModel {
  String? username;
  String? accessToken;

  UserModel({this.username, this.accessToken});

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    return data;
  }
}
