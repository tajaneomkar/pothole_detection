class GetPotHoleInformationByAdminUIdRequestModel {
  final String infoID;

  GetPotHoleInformationByAdminUIdRequestModel({
    required this.infoID,
  });

  Map<String, dynamic> toJson() => {"infoID": infoID};
}
