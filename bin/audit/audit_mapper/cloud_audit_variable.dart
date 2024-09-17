class CloudAuditVariables {
  String? name;
  String? value;

  CloudAuditVariables({this.name, this.value});

  CloudAuditVariables.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}
