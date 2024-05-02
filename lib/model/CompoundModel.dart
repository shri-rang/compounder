// class Field {
//   final String name;
//   final String type;
//   final String textColor;
//   final int textSize;
//   final String labelText;
//   final List<Value> values;
//   final String? hintText;
//   final List<int>? minAmounts;
//   final int? maxAmount;
//   final String? errorMessage;
//   final List<int>? rateDependencies;
//   final String? modeOfDisplay;

//   Field({
//     required this.name,
//     required this.type,
//     required this.textColor,
//     required this.textSize,
//     required this.labelText,
//     required this.values,
//     this.hintText,
//     this.minAmounts,
//     this.maxAmount,
//     this.errorMessage,
//     this.rateDependencies,
//     this.modeOfDisplay,
//   });

//   factory Field.fromJson(Map<String, dynamic> json) {
//     return Field(
//       name: json['name'],
//       type: json['type'],
//       textColor: json['textColor'],
//       textSize: json['textSize'],
//       labelText: json['labelText'],
//       values: List<Value>.from(json['values'].map((x) => Value.fromJson(x))),
//       hintText: json['hintText'],
//       minAmounts: json['minAmounts'] != null ? List<int>.from(json['minAmounts']) : null,
//       maxAmount: json['maxAmount'],
//       errorMessage: json['errorMessage'],
//       rateDependencies: json['rateDependencies'] != null ? List<int>.from(json['rateDependencies']) : null,
//       modeOfDisplay: json['modeOfDisplay'],
//     );
//   }
// }

// class Value {
//   final int value;
//   final String label;

//   Value({
//     required this.value,
//     required this.label,
//   });

//   factory Value.fromJson(Map<String, dynamic> json) {
//     return Value(
//       value: json['value'],
//       label: json['label'],
//     );
//   }
// }
// To parse this JSON data, do
//
//     final compoundModel = compoundModelFromJson(jsonString);

// import 'dart:convert';

// CompoundModel compoundModelFromJson(String str) =>
//     CompoundModel.fromJson(json.decode(str));

// String compoundModelToJson(CompoundModel data) => json.encode(data.toJson());

// class CompoundModel {
//   List<Field>? fields;

//   CompoundModel({
//     this.fields,
//   });

//   factory CompoundModel.fromJson(Map<String, dynamic> json) => CompoundModel(
//         fields: List<Field>.from(json["fields"].map((x) => Field.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "fields": List<dynamic>.from(fields!.map((x) => x.toJson())),
//       };
// }

// class Field {
//   String? name;
//   String? type;
//   String? textColor;
//   int? textSize;
//   String? labelText;
//   List<String>? values;

//   Field({
//     this.name,
//     this.type,
//     this.textColor,
//     this.textSize,
//     this.labelText,
//     this.values,
//   });

//   factory Field.fromJson(Map<String, dynamic> json) => Field(
//         name: json["name"],
//         type: json["type"],
//         textColor: json["textColor"],
//         textSize: json["textSize"],
//         labelText: json["labelText"],
//         values: List<String>.from(json["values"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "type": type,
//         "textColor": textColor,
//         "textSize": textSize,
//         "labelText": labelText,
//         "values": List<dynamic>.from(values!.map((x) => x)),
//       };
// }

// To parse this JSON data, do
//
//     final compoundModel = compoundModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final compoundModel = compoundModelFromJson(jsonString);

import 'dart:convert';

CompoundModel compoundModelFromJson(String str) =>
    CompoundModel.fromJson(json.decode(str));

String compoundModelToJson(CompoundModel data) => json.encode(data.toJson());

class CompoundModel {
  List<Field>? fields;

  CompoundModel({
    this.fields,
  });

  factory CompoundModel.fromJson(Map<String, dynamic> json) => CompoundModel(
        fields: List<Field>.from(json["fields"].map((x) => Field.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "fields": List<dynamic>.from(fields!.map((x) => x.toJson())),
      };
}

class Field {
  String? name;
  String? type;
  String? textColor;
  int? textSize;
  String? labelText;
  List<dynamic>? values;
  String? hintText;

  Field({
    this.name,
    this.type,
    this.textColor,
    this.textSize,
    this.labelText,
    this.values,
    this.hintText,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        name: json["name"],
        type: json["type"],
        textColor: json["textColor"],
        textSize: json["textSize"],
        labelText: json["labelText"],
        values: List<dynamic>.from(json["values"].map((x) => x)),
        hintText: json["hintText"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "textColor": textColor,
        "textSize": textSize,
        "labelText": labelText,
        "values": List<dynamic>.from(values!.map((x) => x)),
        "hintText": hintText,
      };
}
