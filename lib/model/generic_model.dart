import 'dart:convert';

class GenericModel {
  int? id;
  String? date;
  double? value;
  int? type;

  GenericModel({
    this.id,
    required this.date,
    required this.value,
    required this.type
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'date': date,
      'value': value,
      'type': type
    };
    if (id != null) data['id'] = id;
    return data;
  }

  factory GenericModel.fromMap(Map<String, dynamic> map) {
    return GenericModel(
      id: map['id'],
      date: map['date'],
      value: map['value'],
      type: map['type']
    );
  }

  String toJson() => json.encode(toMap());

  factory GenericModel.fromJson(String source) =>
      GenericModel.fromMap(json.decode(source));
}
