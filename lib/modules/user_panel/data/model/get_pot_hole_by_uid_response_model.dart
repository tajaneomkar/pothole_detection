class GetPotHoleInformationByUIdResponseModel {
  final String? id;
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
  final String? image;

  GetPotHoleInformationByUIdResponseModel({
    this.id,
    this.userId,
    this.name,
    this.email,
    this.phoneNo,
    this.date,
    this.description,
    this.address,
    this.status,
    this.assignee,
    this.fileID,
    this.image,
  });

  GetPotHoleInformationByUIdResponseModel.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        userId = json['userId'] as String?,
        name = json['name'] as String?,
        email = json['email'] as String?,
        phoneNo = json['phoneNo'] as String?,
        date = json['date'] as String?,
        description = json['description'] as String?,
        address = json['address'] as String?,
        status = json['status'] as String?,
        assignee = json['assignee'] as String?,
        fileID = json['fileID'] as String?,
        image = json['image'] as String?;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'userId': userId,
        'name': name,
        'email': email,
        'phoneNo': phoneNo,
        'date': date,
        'description': description,
        'address': address,
        'status': status,
        'assignee': assignee,
        'fileID': fileID,
        'image': image
      };
}
