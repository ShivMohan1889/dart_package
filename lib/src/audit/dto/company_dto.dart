import 'package:pdf/widgets.dart';

class CompanyDto {
  String? id;
  String? name;
  String? houseNo;
  String? address1;
  String? address2;
  String? address3;
  String? town;
  String? county;
  String? countryId;
  String? city;
  String? postcode;
  String? companyLogo;

  String? companyLogoImageName;
  MemoryImage? companyLogoMemoryImage;
  String? created;
  String? modified;
  int? isStandard;
  int? defaultFolder;
  String? defaultFolderName;
  String? dropboxFolderPath;
  String? boxFolderPath;
  String? driveFolderPath;
  String? procoreFolderPath;
  String? oneDriveFolderName;
  String? dropboxFolderId;
  String? boxFolderId;
  String? driveFolderId;
  String? procoreFolderId;
  String? procoreProjectId;
  String? procoreCompanyId;
  String? oneDriveFolderId;
  String? boxAutouploadFlag;
  String? dropboxAutouploadFlag;
  String? cloudFolderFlag;
  String? driveAutouploadFlag;
  String? procoreAutouploadFlag;
  String? oneDriveAutouploadFlag;
  int? companyId;
  String? roleId;
  String? administratorId;
  String? companyName;
  String? email;
  String? phone;
  int? isMain;
  bool? inAppActivateStatus;
  int? subscriptionStatus;
  int? signOffStatus;
  String? signOffStatementApp;
  String? signOffStatementReport;
  String? approvalStatementApp;
  String? approvalStatementReport;
  String? uniqueKey;
  int? approvalStatus;
  int? isCloud;

  int? isSelected = 0;
  String? imagePath;

  CompanyDto({
    this.id,
    this.name,
    this.houseNo,
    this.address1,
    this.address2,
    this.address3,
    this.town,
    this.county,
    this.countryId,
    this.city,
    this.postcode,
    this.companyLogo,
    this.created,
    this.modified,
    this.isStandard,
    this.defaultFolder,
    this.defaultFolderName,
    this.dropboxFolderPath,
    this.boxFolderPath,
    this.driveFolderPath,
    this.procoreFolderPath,
    this.oneDriveFolderName,
    this.dropboxFolderId,
    this.boxFolderId,
    this.driveFolderId,
    this.procoreFolderId,
    this.procoreProjectId,
    this.procoreCompanyId,
    this.oneDriveFolderId,
    this.boxAutouploadFlag,
    this.dropboxAutouploadFlag,
    this.cloudFolderFlag,
    this.driveAutouploadFlag,
    this.procoreAutouploadFlag,
    this.oneDriveAutouploadFlag,
    this.companyId,
    this.roleId,
    this.administratorId,
    this.companyName,
    this.email,
    this.phone,
    this.isMain,
    this.inAppActivateStatus,
    this.subscriptionStatus,
    this.signOffStatus,
    this.signOffStatementApp,
    this.signOffStatementReport,
    this.approvalStatementApp,
    this.approvalStatementReport,
    this.uniqueKey,
    this.approvalStatus,
    this.isCloud,
    this.isSelected = 0,
    this.companyLogoImageName,
    this.companyLogoMemoryImage,
    this.imagePath,
  });

  // Factory constructor to create an instance from JSON
  factory CompanyDto.fromJson(Map<String, dynamic> json) {
    return CompanyDto(
      id: json["id"],
      name: json['companyName'],
      houseNo: json['house_no'],
      address1: json['address1'],
      address2: json['address2'],
      address3: json['address3'],
      town: json['town'],
      county: json['county'],
      countryId: json['country_id'],
      city: json['city'],
      postcode: json['postcode'],
      companyLogo: json['company_logo'],
      created: json['created'],
      modified: json['modified'],
      isStandard: json['is_standard'],
      defaultFolder: json['default_folder'],
      defaultFolderName: json['default_folder_name'],
      dropboxFolderPath: json['dropbox_folder_path'],
      boxFolderPath: json['box_folder_path'],
      driveFolderPath: json['drive_folder_path'],
      procoreFolderPath: json['procore_folder_path'],
      oneDriveFolderName: json['one_drive_folder_name'],
      dropboxFolderId: json['dropbox_folder_id'],
      boxFolderId: json['box_folder_id'],
      driveFolderId: json['drive_folder_id'],
      procoreFolderId: json['procore_folder_id'],
      procoreProjectId: json['procore_project_id'],
      procoreCompanyId: json['procore_company_id'],
      oneDriveFolderId: json['one_drive_folder_id'],
      boxAutouploadFlag: json['box_autoupload_flag'],
      dropboxAutouploadFlag: json['dropbox_autoupload_flag'],
      cloudFolderFlag: json['cloud_folder_flag'],
      driveAutouploadFlag: json['drive_autoupload_flag'],
      procoreAutouploadFlag: json['procore_autoupload_flag'],
      oneDriveAutouploadFlag: json['one_drive_autoupload_flag'],
      companyId: json['company_id'],
      roleId: json['role_id'],
      administratorId: json['administrator_id'],
      companyName: json['company_name'],
      email: json['email'],
      phone: json['phone'],
      isMain: json['is_main'],
      inAppActivateStatus: json['in_app_activate_status'],
      subscriptionStatus: json['subscription_status'],
      signOffStatus: json['sign_off_status'],
      signOffStatementApp: json['sign_off_statement_app'],
      signOffStatementReport: json['sign_off_statement_report'],
      approvalStatementApp: json['approval_statement_app'],
      approvalStatementReport: json['approval_statement_report'],
      uniqueKey: json['unique_key'],
      approvalStatus: json['approval_status'],
      isCloud: json['is_cloud'],
      isSelected: json['is_selected'],
      companyLogoImageName: json['company_logo_image_name'],
      companyLogoMemoryImage: json['memory_image'],
      imagePath: json["image_path"],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'house_no': houseNo,
      'address1': address1,
      'address2': address2,
      'address3': address3,
      'town': town,
      'county': county,
      'country_id': countryId,
      'city': city,
      'postcode': postcode,
      'company_logo': companyLogo,
      'created': created,
      'modified': modified,
      'is_standard': isStandard,
      'default_folder': defaultFolder,
      'default_folder_name': defaultFolderName,
      'dropbox_folder_path': dropboxFolderPath,
      'box_folder_path': boxFolderPath,
      'drive_folder_path': driveFolderPath,
      'procore_folder_path': procoreFolderPath,
      'one_drive_folder_name': oneDriveFolderName,
      'dropbox_folder_id': dropboxFolderId,
      'box_folder_id': boxFolderId,
      'drive_folder_id': driveFolderId,
      'procore_folder_id': procoreFolderId,
      'procore_project_id': procoreProjectId,
      'procore_company_id': procoreCompanyId,
      'one_drive_folder_id': oneDriveFolderId,
      'box_autoupload_flag': boxAutouploadFlag,
      'dropbox_autoupload_flag': dropboxAutouploadFlag,
      'cloud_folder_flag': cloudFolderFlag,
      'drive_autoupload_flag': driveAutouploadFlag,
      'procore_autoupload_flag': procoreAutouploadFlag,
      'one_drive_autoupload_flag': oneDriveAutouploadFlag,
      'company_id': companyId,
      'role_id': roleId,
      'administrator_id': administratorId,
      'company_name': companyName,
      'email': email,
      'phone': phone,
      'is_main': isMain,
      'in_app_activate_status': inAppActivateStatus,
      'subscription_status': subscriptionStatus,
      'sign_off_status': signOffStatus,
      'sign_off_statement_app': signOffStatementApp,
      'sign_off_statement_report': signOffStatementReport,
      'approval_statement_app': approvalStatementApp,
      'approval_statement_report': approvalStatementReport,
      'unique_key': uniqueKey,
      'approval_status': approvalStatus,
      'is_cloud': isCloud,
      'is_selected': isSelected,
      'company_logo_image_name': companyLogoImageName,
    };
  }
}
