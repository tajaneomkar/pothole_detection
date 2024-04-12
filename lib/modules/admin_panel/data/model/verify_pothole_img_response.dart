class VerifyPotholeImgResponseModel {
  final String? response;

  VerifyPotholeImgResponseModel({
    this.response,
  });

  VerifyPotholeImgResponseModel.fromJson(Map<String, dynamic> json)
      : response = json['response'] as String?;

  Map<String, dynamic> toJson() => {'response': response};
}
