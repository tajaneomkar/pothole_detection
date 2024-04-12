class AdminPanelRequestModel {
  final String? userID;
  final String? status;

  AdminPanelRequestModel({
    this.userID,
    this.status,
  });

  AdminPanelRequestModel.fromJson(Map<String, dynamic> json)
      : userID = json['userID'] as String?,
        status = json['status'] as String?;

  Map<String, dynamic> toJson() => {'userID': userID, 'status': status};
}
