class VerifyPotholeImgRequestModel {
  final String? image;

  VerifyPotholeImgRequestModel({
    this.image,
  });

  VerifyPotholeImgRequestModel.fromJson(Map<String, dynamic> json)
      : image = json['image'] as String?;

  Map<String, dynamic> toJson() => {'image': image};
}
