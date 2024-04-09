class LoginRequestModel {
  final String? userName;
  final String? password;

  LoginRequestModel({
    this.userName,
    this.password,
  });

  LoginRequestModel.fromJson(Map<String, dynamic> json)
      : userName = json['userName'] as String?,
        password = json['password'] as String?;

  Map<String, dynamic> toJson() => {'userName': userName, 'password': password};
}
