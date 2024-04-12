class UploadImgUserRequestModel {
  final String? fileName;
  final String? fileType;
  final String? fileBytes;

  UploadImgUserRequestModel({
    this.fileName,
    this.fileType,
    this.fileBytes,
  });

  Map<String, dynamic> toJson() {
    return {
      'fileName': fileName,
      'fileType': fileType,
      'fileBytes': fileBytes,
    };
  }
}
