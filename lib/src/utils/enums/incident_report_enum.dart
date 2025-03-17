/// use to check what type of Incident Report we have
/// 0 for injury type,1 for illHeath,2 for  Near Miss
abstract class IncidentReport {
  static const int injuryType = 0;
  static const int illHealthType = 2;
  static const int nearMissType = 1;
}

abstract class IrConnectionType {
  static const int colleague = 3;
  static const int firstAider = 1;
  static const int witness = 0;
  static const int other = 4;
}

abstract class IrReasonForPresenceType {
  static const int customer = 2;
  static const int deliveryDriver = 1;
  static const int subContractor = 0;
  static const int vistor = 3;
  static const int other = 4;
}

abstract class IrOffWorkNeedType {
  static const int lessThan3days = 1;
  static const int moreThan3days = 0;
  static const int moreThan7days = 2;
}

abstract class IrInjurySeriousNessType {
  static const String noInjury = "0";
  static const String minorInjury = "1";
  static const String lostTimeInjury = "2";
  static const String severeInjury = "3";
  static const String fatality = "4";
}

abstract class IrWhatHappenNextType {
  static const String backToWork = "0";
  static const String doctor = "1";
  static const String hospital = "2";
  static const String other = "3";
}

// "2" => "Customer",
// 	"1" => "Delivery Driver" ,
// 	"0" => "Sub Contractor",
// 	"3" => "Visitor",
// 	"4" => "Other"
// "1" => "Less than 3 days",
// 	"0" => "More than 3 days",
// 	"2" => "More than 7 days"
