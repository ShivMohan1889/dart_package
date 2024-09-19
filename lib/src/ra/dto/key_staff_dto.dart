import '../../utils/utils.dart';

class KeyStaffDto {
  int? id;
  String? name;
  String? contractorName;
  int? isContractor = 0;
  String? uniqueKey;
  String? assessmentUniqueKey;
  int? companyId;
  bool? isSelected = false;

  /// determines if a user is downloaded from cloud (server) or not
  int? isCloud;
  String? keyStaffUniqueKey;

  KeyStaffDto({
    this.id,
    this.name,
    this.contractorName,
    this.isContractor,
    this.uniqueKey,
    this.companyId,
    this.isSelected,
    this.isCloud,
    this.assessmentUniqueKey,
    this.keyStaffUniqueKey,
  });

  Map<String, dynamic> jsonToUpload() {
    var dict = {
      "unique_key": (uniqueKey ?? "").isNotEmpty ? uniqueKey : Utils.uuid(),
      "contractorName": contractorName,
      "fitterName": name,
      "isContractor": isContractor
    };
    return dict;
  }

  factory KeyStaffDto.fromJson(Map<String, dynamic> json) {
    return KeyStaffDto(
      id: json['id'] as int?, // Can be null, no default needed
      name: json['name'] as String?, // Can be null
      contractorName: json['contractorName'] as String?, // Can be null
      isContractor: json['isContractor'] as int?, // Can be null
      uniqueKey: json['uniqueKey'] as String?, // Can be null
      assessmentUniqueKey:
          json['assessmentUniqueKey'] as String?, // Can be null
      companyId: json['companyId'] as int?, // Can be null
      isSelected: json['isSelected'] as bool?, // Can be null
      isCloud: json['isCloud'] as int?, // Can be null
      keyStaffUniqueKey: json['keyStaffUniqueKey'], // Can be null
    );
  }
}
