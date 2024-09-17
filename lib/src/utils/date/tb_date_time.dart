import 'dart:io';

import 'package:intl/intl.dart';

import '../enums/enum/locale_type.dart';


class TbDateTime {
  static DateFormat inputFormat = DateFormat("dd/MM/yy");

  static DateFormat inputFormatForEnUs = DateFormat("MM/dd/yy");

  static DateFormat inputFormatForWeb = DateFormat("dd/MM/yyyy");

  static DateFormat inputTimeFormat = DateFormat("hh:mm a");

  static DateFormat inputDateFormat = DateFormat("yyyy-MM-dd");

  static DateFormat inputTimeInSecondFormat = DateFormat("hh:mm:ss");

  static DateFormat dateFormatForAssessmentLogs =
      DateFormat('yyyy-MM-dd hh:mm:ss');

  static String timeZone() {
    return DateTime.now().timeZoneName;
  }

  /* ************************************** */
  // CURRENT DATE STRING
  /// Constructs a new Date String for [todays Date]
  /// * Fromat [dd/MM/yyyy]
  /* ************************************** */
  static String currentDateString() {
    DateTime dateNow = DateTime.now();

    String dateString = inputFormat.format(dateNow);
    return dateString;
  }

  /* ************************************** */
  // CURRENT TIME
  /// return the current time in string
  /* ************************************** */
  static String currentTime() {
    String dateString = DateFormat("hh:mm a").format(DateTime.now());

    return dateString;
  }

/* ************************************** */
  /* ************************************** */
  // TIME STAMP
  /// return the current time stamp
  /* ************************************** */
  static int timeStamp() {
    return DateTime.now().millisecondsSinceEpoch.toInt() ~/ 1000;
  }

  /* ************************************** */
  // CONVERT STRING TO DATE TIME
  /// Given user input, attempt to parse the [dateString] into the anticipated
  /// format
  ///
  /* ************************************** */
  static DateTime convertStringToDate(String dateString) {
    DateTime date = inputFormat.parse(dateString);
    return date;
  }

  /* ************************************** */
  // CONVERT Date TO String
  /// Given user input, attempt to parse the [date] into String
  ///
  /* ************************************** */
  static String convertDateToString(DateTime date) {
    String dateString = inputFormat.format(date);
    return dateString;
  }

  /* ************************************** */
  // CONVERT TIME TO STRING
  /// convert time into string for given [dateString]
  /* ************************************** */
  static String convertTimeToString(DateTime time) {
    String raTime = inputTimeFormat.format(time);
    return raTime;
  }

  /* ************************************** */
  // CONVERT STRING TO TIME
  /// convert string into time for given [time]
  /* ************************************** */

  static DateTime convertStringToTime(String time) {
    DateTime raTime = inputTimeFormat.parse(time);
    return raTime;
  }

  /* ************************************** */
  // TIME STAMP
  // CONVERT STRING TO DATE TIME FOR ASSESSMENT LOGS
  /// Given user input, attempt to parse the [dateString] into the anticipated
  /// format
  ///
  /* ************************************** */
  static DateTime convertStringToDateForLogs(String dateString) {
    DateTime date = dateFormatForAssessmentLogs.parse(dateString);
    return date;
  }

  /* ************************************** */
  // CONVERT DATE TO STRING FOR ASSESSMENT LOGS
  /// Given user input, attempt to parse the [date] into String
  ///
  /* ************************************** */
  static String convertDateToStringForLogs(DateTime date) {
    String dateString = dateFormatForAssessmentLogs.format(date);
    return dateString;
  }

  static String convertWeatherDateFormat(String date) {
    if (date.isNotEmpty) {
      String originalDateString = date;
      DateTime originalDate = DateTime.parse(originalDateString);
      String convertedDate = inputFormat.format(originalDate);
      return convertedDate;
    } else {
      return date;
    }
  }

/* ************************************** */
  // CONVERT GIVEN DATE INTO OTHER DATE FORMAT
  /// this method is responsible for converting the date into other date format
  /* ************************************** */
  static String convertDateForUploadingIncident(String date) {
    if (date.isNotEmpty) {
      DateTime formatDate = inputFormat.parse(date);

      String formatDateString = inputDateFormat.format(formatDate);
      return formatDateString;
    } else {
      return date;
    }
  }

  /* ************************************* / 
   // RETURN DATE CONVERT FROM WEB TO MOBILE INCIDENT 
   
   /// this method we method return date string in mobile date format [dd/MM/yy] by convert it from 
   /// web date format
  / ************************************* */
  static String convertDateOnDownloadingIncident({required String date}) {
    if (date.isNotEmpty) {
      DateTime mobileFormatedDate = inputDateFormat.parse(date);
      String mobileFormatDateString = inputFormat.format(mobileFormatedDate);
      return mobileFormatDateString;
    } else {
      return date;
    }
  }

  /* ************************************* / 
   // RETURN TIME CONVERT FROM WEB TO MOBILE INCIDENT
   ///

  / ************************************* */
  static String convertReportingTimeOnDownloadingIncident(
      {required String time}) {
    DateTime convertedTime = inputTimeInSecondFormat.parse(time);
    String irReportingTime = inputTimeFormat.format(convertedTime);
    return irReportingTime;
  }

/* ************************************** */
  // CONVERT GIVEN DATE INTO OTHER DATE FORMAT
  /// this method is responsible for converting the date into other date format
  /* ************************************** */
  static String convertData(String date) {
    if (date.isNotEmpty) {
      DateTime formatDate = inputFormat.parse(date);

      String formatDateString = inputDateFormat.format(formatDate);
      return formatDateString;
    } else {
      return date;
    }
  }
  /* ************************************** */
  //  CONVERT TIME IN SECONDS
  /// this method is responsible for change the time format for
  /// the given[time]
  /* ************************************** */

  static String convertTimeInSeconds(String time) {
    DateTime formatTime = inputTimeFormat.parse(time);

    String formatTimeString = inputTimeInSecondFormat.format(formatTime);

    return formatTimeString;
  }

  /* ************************************** */
  //  CONVERT GIVEN DATE STRING TO API COMPATIBLE FORMAT
  /// in app we use format -  dd/mm/yy
  /// bharat need format - dd/mm/yyyy
  /* ************************************** */
  static String dateForWebApis(String date) {
    if (date.isNotEmpty) {
      String originalDateString = date;
      DateTime originalDate = inputFormat.parse(originalDateString);
      String convertedDate = inputFormatForWeb.format(originalDate);
      return convertedDate;
    } else {
      return date;
    }
  }

  /* ************************************** */
  //  CONVERT GIVEN DATE STRING FROM API FORMAT TO APP FROMAT
  /// in app we use format -  dd/mm/yy
  /// bharat need format - dd/mm/yyyy
  /* ************************************** */
  static String dateFromWebApis(String date) {
    if (date.isNotEmpty) {
      String originalDateString = date;
      DateTime originalDate = inputFormatForWeb.parse(originalDateString);
      String convertedDate = inputFormat.format(originalDate);
      return convertedDate;
    } else {
      return date;
    }
  }

  static String timestampToDate(int timestampMilliseconds) {
    // Convert the timestamp to a DateTime object
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
      timestampMilliseconds,
    );

    // Format the DateTime as a string using the provided format
    String formattedDate = DateFormat('dd/MM/yy hh:mm:ss').format(dateTime);
    return formattedDate;
  }

  /* ************************************* / 
  // CONVERT DATE INTO EN IN FORMAT 
 /// this method convert date into dd/mm/yy format when locale name is en_US
 / ************************************* */

  static String convertDateIntoEnInFormat(String date) {
    if (date.isNotEmpty) {
      if (Platform.localeName == RaLocaleType.enUS) {
        DateTime dateTime = inputFormatForEnUs.parse(date);

        String enINDate = inputFormat.format(dateTime);

        return enINDate;
      } else {
        return date;
      }
    } else {
      return "";
    }
  }

  /* ************************************* / 
  // DATE STRING FOR LOCALE 
  
  ///this method is responsible returns string on based of locale
 / ************************************* */
  static String dateStringForLocale(String date) {
    if (date.isEmpty) {
      return date;
    } else {
      if (Platform.localeName == RaLocaleType.enUS) {
        DateTime dateTime = inputFormat.parse(date);

        String enINDate = inputFormatForEnUs.format(dateTime);

        return enINDate;
      } else {
        return date;
      }
    }
  }

  /* ************************************* / 
   //  RETURN DATE STRING FOR LOCALE 
   
   /// this method is used in custom date picker for showing date 
   /// in enUS format
  / ************************************* */
  static String returnDateStringForLocale(DateTime datetime) {
    if (Platform.localeName == RaLocaleType.enUS) {
      String enINDate = inputFormatForEnUs.format(datetime);
      return enINDate;
    } else {
      String inputDateFormat = inputFormat.format(datetime);

      return inputDateFormat;
    }
  }
}
