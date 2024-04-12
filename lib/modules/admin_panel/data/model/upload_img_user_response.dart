class UploadImgUserResponse {
  final String? message;
  final String? fileId;

  UploadImgUserResponse({
    this.message,
    this.fileId,
  });

  UploadImgUserResponse.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String?,
        fileId = json['file_id'] as String?;

  Map<String, dynamic> toJson() => {'message': message, 'file_id': fileId};
}
