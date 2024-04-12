class AdminUpdateStatusRequestModel {
  final String? infoID;
  final String? status;
  final String? assignee;

  AdminUpdateStatusRequestModel({
    this.assignee,
    this.status,
    this.infoID,
  });

  Map<String, dynamic> toJson() => {
        "infoID": infoID,
        "status": status,
        "assignee": assignee,
      };
}
