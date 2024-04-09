class LoginResponseModel {
  final String? accessToken;
  final String? tokenType;
  final UserData? userData;

  LoginResponseModel({
    this.accessToken,
    this.tokenType,
    this.userData,
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json)
      : accessToken = json['access_token'] as String?,
        tokenType = json['token_type'] as String?,
        userData = (json['user_data'] as Map<String, dynamic>?) != null
            ? UserData.fromJson(json['user_data'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
        'token_type': tokenType,
        'user_data': userData?.toJson()
      };
}

class UserData {
  final String? email;
  final String? username;
  final String? id;

  UserData({
    this.email,
    this.username,
    this.id,
  });

  UserData.fromJson(Map<String, dynamic> json)
      : email = json['email'] as String?,
        username = json['username'] as String?,
        id = json['id'] as String?;

  Map<String, dynamic> toJson() =>
      {'email': email, 'username': username, 'id': id};
}
