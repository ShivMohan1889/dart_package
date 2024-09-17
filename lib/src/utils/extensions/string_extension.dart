extension PathExtension on String {
  ///Provides the file name with extension
  String get fileName {
    var n = split("/").last;
    if (n.contains(".")) {
      return n;
    } else {
      return "";
    }
  }

  String get nameWithoutExtension {
    List<String> parts = this.split('.');
    return parts.first;
  }
}

extension ParseNumbers on String {
  int parseInt() {
    if (isNotEmpty) {
      return int.parse(this);
    } else {
      return 0;
    }
  }

  double parseDouble() {
    if (isNotEmpty) {
      return double.parse(this);
    } else {
      return 0.0;
    }
  }
}
