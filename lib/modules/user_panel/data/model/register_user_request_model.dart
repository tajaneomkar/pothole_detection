class RegisterUserRequestModel {
  final String? userId;
  final String? name;
  final String? email;
  final String? phoneNo;
  final String? date;
  final String? description;
  final String? address;
  final String? status;
  final String? assignee;
  final String? fileID;

  RegisterUserRequestModel({
    this.address,
    this.assignee,
    this.date,
    this.description,
    this.email,
    this.fileID,
    this.name,
    this.phoneNo,
    this.status,
    this.userId,
  });

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "email": email,
        "phoneNo": phoneNo,
        "date": date,
        "description": description,
        "address": address,
        "status": status,
        "assignee": assignee,
        "fileID": fileID
      };
}
