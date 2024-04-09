class GetPotHoleInformationByUIdRequestModel {
  final String infoID;

  GetPotHoleInformationByUIdRequestModel({
    required this.infoID,
  });

  Map<String, dynamic> toJson() => {"infoID": infoID};
}
