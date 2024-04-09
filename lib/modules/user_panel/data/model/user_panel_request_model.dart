class UserPanelRequestModel {
  final String? userID;
  final String? status;

  UserPanelRequestModel({
    this.userID,
    this.status,
  });

  UserPanelRequestModel.fromJson(Map<String, dynamic> json)
      : userID = json['userID'] as String?,
        status = json['status'] as String?;

  Map<String, dynamic> toJson() => {'userID': userID, 'status': status};
}
