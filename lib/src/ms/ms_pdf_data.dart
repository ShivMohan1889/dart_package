// Model to hold all data needed for MS PDF generation
import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:pdf/widgets.dart';

class MsPdfData {
  String titleForPDF;
  String? companyLogo;
  MemoryImage? companyLogoMemoryImage;
  String companyDetails;
  String? companyPhoneEmail;
  Map<String, List<ProjectDetailsData>> projectDetails;
  String? siteImage;
  MemoryImage? siteMemoryImage;
  List<HeaderRows> headers;
  UserSignatureData userSignature;
  ReviewSignOffSignatureData? reviewSignature;
  List<ReviewSignOffSignatureData>? signOffSignatures;
  String? signOffStatement;
  String? referenceNo;
  int isSubscribed;
  int? numberOfSignOffReview;
  int approvalMode;
  RaPdfData? raPdfData;

  MsPdfData({
    this.siteMemoryImage,
    this.companyLogoMemoryImage,
    required this.titleForPDF,
    this.companyLogo,
    required this.companyDetails,
    this.companyPhoneEmail,
    required this.projectDetails,
    this.siteImage,
    required this.headers,
    required this.userSignature,
    this.reviewSignature,
    this.signOffStatement,
    required this.isSubscribed,
    this.numberOfSignOffReview,
    required this.approvalMode,
    this.referenceNo,
    this.signOffSignatures,
    this.raPdfData,
  });

  Map<String, dynamic> toJson() {
    return {
      'titleForPDF': titleForPDF,
      'companyLogo': companyLogo,
      'companyDetails': companyDetails,
      'companyPhoneEmail': companyPhoneEmail,
      'projectDetails': projectDetails.map((key, value) =>
          MapEntry(key, value.map((item) => item.toJson()).toList())),
      'siteImage': siteImage,
      'headers': headers.map((header) => header.toJson()).toList(),
      'userSignature': userSignature.toJson(),
      'reviewSignature': reviewSignature?.toJson(),
      'signOffStatement': signOffStatement,
      'referenceNo': referenceNo,
      'isSubscribed': isSubscribed,
      'numberOfSignOffReview': numberOfSignOffReview,
      'approvalMode': approvalMode,
      'sign_off_signatures':
          signOffSignatures?.map((signOff) => signOff.toJson()).toList(),
      "raPdfData": raPdfData?.toJson(),
    };
  }

  factory MsPdfData.fromJson(Map<String, dynamic> json) {
    return MsPdfData(
      titleForPDF: json['titleForPDF'],
      companyLogo: json['companyLogo'],
      companyDetails: json['companyDetails'],
      companyPhoneEmail: json['companyPhoneEmail'],
      projectDetails: (json['projectDetails'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(
              key,
              (value as List)
                  .map((item) => ProjectDetailsData.fromJson(item))
                  .toList())),
      siteImage: json['siteImage'],
      headers: (json['headers'] as List)
          .map((item) => HeaderRows.fromJson(item))
          .toList(),
      userSignature: UserSignatureData.fromJson(json['userSignature']),
      reviewSignature: json['reviewSignature'] != null
          ? ReviewSignOffSignatureData.fromJson(json['reviewSignature'])
          : null,
      signOffStatement: json['signOffStatement'],
      referenceNo: json['referenceNo'],
      isSubscribed: json['isSubscribed'],
      numberOfSignOffReview: json['numberOfSignOffReview'],
      approvalMode: json['approvalMode'],
      signOffSignatures: (json['sign_off_signatures'] as List)
          .map((item) => ReviewSignOffSignatureData.fromJson(item))
          .toList(),
      raPdfData: json["raPdfData"] == null
          ? null
          : RaPdfData.fromJson(json["raPdfData"]),
    );
  }
}

class ProjectDetailsData {
  String key;
  String value;

  ProjectDetailsData({
    required this.key,
    required this.value,
  });
  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
    };
  }

  factory ProjectDetailsData.fromJson(Map<String, dynamic> json) {
    return ProjectDetailsData(
      key: json['key'],
      value: json['value'],
    );
  }
}

class HeaderRows {
  String name;
  int level;
  List<HeaderStatementData>? statements;
  List<HazardIconData>? hazardIcons;
  List<HeaderReferenceImageData>? images;
  List<HeaderRows>?headerRows;

  HeaderRows({
    required this.name,
    required this.level,
    this.statements,
     this.hazardIcons,
    required this.images,
     this.headerRows,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'level': level,
      'statements': statements?.map((statement) => statement.toJson()).toList(),
      'hazardIcons': hazardIcons?.map((icon) => icon.toJson()).toList(),
      'images': images?.map((image) => image.toJson()).toList(),
      'headerRows': headerRows?.map((header) => header.toJson()).toList(),
    };
  }

  factory HeaderRows.fromJson(Map<String, dynamic> json) {
    return HeaderRows(
      name: json['name'] as String,
      level: json['level'] as int,
      statements: (json['statements'] as List<dynamic>?)
          ?.map((item) =>
              HeaderStatementData.fromJson(item as Map<String, dynamic>))
          .toList(),
      hazardIcons: (json['hazardIcons'] as List<dynamic>?)
         ?.map((item) => HazardIconData.fromJson(item as Map<String, dynamic>))
          .toList(),
      images: (json['images'] as List<dynamic>?)
          ?.map((item) =>
              HeaderReferenceImageData.fromJson(item as Map<String, dynamic>))
          .toList(),
      headerRows: json['headerRows'] != null
          ? (json['headerRows'] as List<dynamic>?)
              ?.map((item) => HeaderRows.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
    );
  }
}

class HeaderStatementData {
  String text;
  List<MemoryImage>? memoryImages;
  List<StatementImageData>? images;

  HeaderStatementData({
    required this.text,
    this.images,
    this.memoryImages,
  });

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'images': images,
    };
  }

  factory HeaderStatementData.fromJson(Map<String, dynamic> json) {
    return HeaderStatementData(
        text: json['text'],
        // images: List<String>.from(json['images']),
        images: (json['images'] as List<dynamic>?)
            ?.map((item) =>
                StatementImageData.fromJson(item as Map<String, dynamic>))
            .toList()
        // images:  json['images'] != null
        //     ? (json['images'] as List<)
        //         .map((item) =>
        //             StatementImageData.fromJson(item as Map<String, dynamic>))
        //         .toList()
        //     : null,
        );
  }
}

class HazardIconData {
  MemoryImage? iconMemoryImage;
  String? icon;
  String text;

  HazardIconData({
    this.icon,
    required this.text,
    this.iconMemoryImage,
  });
  Map<String, dynamic> toJson() {
    return {
      'icon': icon,
      'text': text,
    };
  }

  factory HazardIconData.fromJson(Map<String, dynamic> json) {
    return HazardIconData(
      icon: json['icon'],
      text: json['text'],
    );
  }
}

class HeaderReferenceImageData {
  MemoryImage? memoryImage;
  String? image;
  String? referenceNo;

  HeaderReferenceImageData({
    this.image,
    this.referenceNo,
    this.memoryImage,
  });
  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'referenceNo': referenceNo,
    };
  }

  factory HeaderReferenceImageData.fromJson(Map<String, dynamic> json) {
    return HeaderReferenceImageData(
      image: json['image'],
      referenceNo: json['referenceNo'] as String? ,
    );
  }
}

class StatementImageData {
  MemoryImage? memoryImage;
  String? image;

  StatementImageData({
    this.image,
    this.memoryImage,
  });
  Map<String, dynamic> toJson() {
    return {
      'image': image,
    };
  }

  factory StatementImageData.fromJson(Map<String, dynamic> json) {
    return StatementImageData(
      image: json['image'],
    );
  }
}

class UserSignatureData {
  String name;
  String position;
  String date;
  MemoryImage? signatureMemoryImage;
  String? signature;

  UserSignatureData({
    required this.name,
    required this.position,
    required this.date,
    this.signature,
    this.signatureMemoryImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'position': position,
      'date': date,
      'signature':
          signature, // Note: MemoryImage can't be serialized, need to use path
    };
  }

  factory UserSignatureData.fromJson(Map<String, dynamic> json) {
    return UserSignatureData(
      name: json['name'],
      position: json['position'],
      date: json['date'],
      signature: json["signature"]  // Need to reload this from the path
    );
  }
}

class ReviewSignOffSignatureData {
  String name;
  String date;
  MemoryImage? signatureMemoryImage;
  String? signature;

  ReviewSignOffSignatureData(
      {required this.name,
      required this.date,
      this.signature,
      this.signatureMemoryImage});
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date,
      'signature':
          signature, // Note: MemoryImage can't be serialized, need to use path
    };
  }

  factory ReviewSignOffSignatureData.fromJson(Map<String, dynamic> json) {
    return ReviewSignOffSignatureData(
      name: json['name'],
      date: json['date'],
      signature: json["signature"], // Need to reload this from the path
    );
  }
}
