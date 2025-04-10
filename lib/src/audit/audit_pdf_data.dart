import 'package:dart_pdf_package/dart_pdf_package.dart';
import 'package:pdf/widgets.dart';

/// A class that holds all the data needed to generate an audit PDF.
///
/// This class is designed to be independent of the specific audit entity classes,
/// making it more reusable and decoupled from the data model.
class AuditPdfData {
  String titleForPDF;
  String date;
  String? companyLogo;
  MemoryImage? companyLogoMemoryImage;
  String companyDetails;
  String? companyPhoneEmail;
  List<ProjectDetailsData> projectDetails;
  UserSignatureData userSignature;
  String? referenceNo;
  final int isSubscribed;
  final List<AuditPdfSection> sectionsData;
  String refName;
  int tableStatus;


  AuditPdfData({
    required this.date,
    required this.titleForPDF,
    this.companyLogo,
    required this.companyDetails,
    this.companyLogoMemoryImage,
    this.companyPhoneEmail,
    required this.projectDetails,
    required this.isSubscribed,
    this.referenceNo,
    required this.userSignature,
    required this.sectionsData,
    required this.refName,
    this.tableStatus =0,

  });

  /// Converts this object to a map for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'titleForPDF': titleForPDF,
      'date': date,
      'companyLogo': companyLogo,
      'ref_name': refName,
      "table_status": tableStatus,

      // Note: MemoryImage can't be directly serialized to JSON
      'companyDetails': companyDetails,
      'companyPhoneEmail': companyPhoneEmail,
      'projectDetails': projectDetails.map((x) => x.toJson()).toList(),
      'userSignature': userSignature.toJson(),
      'referenceNo': referenceNo,
      'isSubscribed': isSubscribed,
      'sectionsData': sectionsData.map((x) => x.toJson()).toList(),
    };
  }

  factory AuditPdfData.fromJson(Map<String, dynamic> json) {
    return AuditPdfData(
      titleForPDF: json['titleForPDF'],
      date: json['date'],
      refName:  json['ref_name'],
      companyLogo: json['companyLogo'],
      tableStatus:  json['table_status'],

      
      companyLogoMemoryImage: null, // Can't deserialize MemoryImage
      companyDetails: json['companyDetails'],
      companyPhoneEmail: json['companyPhoneEmail'],
      projectDetails: List<ProjectDetailsData>.from(
          (json['projectDetails'] as List)
              .map((x) => ProjectDetailsData.fromJson(x))),
      userSignature: UserSignatureData.fromJson(json['userSignature']),
      referenceNo: json['referenceNo'],
      isSubscribed: json['isSubscribed'],
      sectionsData: List<AuditPdfSection>.from((json['sectionsData'] as List)
          .map((x) => AuditPdfSection.fromJson(x))),
    );
  }
}

class AuditPdfSection {
  /// The name of the section
  final String? name;

  /// The description of the section
  final String? description;

  /// Images attached to this section
  final List<String>? images;
  final List<MemoryImage>? memoryImages;

  /// Questions contained in this section
  final List<AuditPdfQuestion> questions;

  /// Creates a new [AuditPdfSection]
  AuditPdfSection({
    this.name,
    this.description,
    this.images,
    this.memoryImages,
    this.questions = const [],
  });

  /// Converts this object to a map for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'images': images,
      // Note: MemoryImage can't be directly serialized to JSON
      'questions': questions.map((x) => x.toJson()).toList(),
    };
  }

  /// Creates an [AuditPdfSection] from a JSON map
  ///
  /// Note: This will not restore MemoryImage objects as they can't be serialized
  factory AuditPdfSection.fromJson(Map<String, dynamic> json) {
    return AuditPdfSection(
      name: json['name'],
      description: json['description'],
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      memoryImages: null, // Can't deserialize MemoryImage
      questions: json['questions'] != null
          ? List<AuditPdfQuestion>.from((json['questions'] as List)
              .map((x) => AuditPdfQuestion.fromJson(x)))
          : [],
    );
  }
}

// Represents a question in the audit PDF
class AuditPdfQuestion {
  /// The text of the question
  final String question;

  /// The question number (e.g., "1.2.3")
  final String questionNumber;

  /// Type of question (e.g., statement, question)
  final int questionType;

  final int questionLevel;

  /// The value/answer of the question
  final String answer;

  /// Additional comments for the question
  final String? comment;

  final List<String>? listChainOption;

  /// String representation of all chain options
  final String? chainOptionsString;

  /// Images attached to this question
  final List<String>? images;
  final List<MemoryImage>? memoryImages;

  /// Creates a new [AuditPdfQuestion]
  AuditPdfQuestion({
    this.listChainOption,
    required this.question,
    required this.questionNumber,
    required this.questionType,
    required this.answer,
    this.comment,
    this.chainOptionsString,
    this.images,
    this.memoryImages,
    required this.questionLevel,
  });

  /// Converts this object to a map for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'questionNumber': questionNumber,
      'questionType': questionType,
      'questionLevel': questionLevel,
      'answer': answer,
      'comment': comment,
      'listChainOption': listChainOption,
      'chainOptionsString': chainOptionsString,
      'images': images,
      // Note: MemoryImage can't be directly serialized to JSON
    };
  }

  /// Creates an [AuditPdfQuestion] from a JSON map
  ///
  /// Note: This will not restore MemoryImage objects as they can't be serialized
  factory AuditPdfQuestion.fromJson(Map<String, dynamic> json) {
    return AuditPdfQuestion(
      question: json['question'],
      questionNumber: json['questionNumber'],
      questionType: json['questionType'],
      questionLevel: json['questionLevel'],
      answer: json['answer'],
      comment: json['comment'],
      listChainOption: json['listChainOption'] != null
          ? List<String>.from(json['listChainOption'])
          : null,
      chainOptionsString: json['chainOptionsString'],
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      memoryImages: null, // Can't deserialize MemoryImage
    );
  }
}
