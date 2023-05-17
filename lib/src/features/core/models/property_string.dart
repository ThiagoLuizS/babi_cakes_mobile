class PropertyString {
  late String type;
  late String status;

  PropertyString({required this.type, required this.status});

  PropertyString.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['status'] = status;
    return data;
  }
}