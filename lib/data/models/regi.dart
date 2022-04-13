// import 'package:json_annotation/json_annotation.dart';
// part 'regi.g.dart';
//
// @JsonSerializable()
// class Data1 {
//   List<Accepted>? accepted;
//   List<Rejected>? rejected;
//
//   Data1({this.rejected, this.accepted});
//
//   factory Data1.fromJson(Map<String, dynamic> json) => _$Data1FromJson(json);
//
//   Map<String, dynamic> toJson() => _$Data1ToJson(this);
// }
//
// @JsonSerializable()
// class Rejected {
//   String? number;
//   Error? error;
//
//   Rejected({this.number, this.error});
//   factory Rejected.fromJson(Map<String, dynamic> json) =>
//       _$RejectedFromJson(json);
//
//   Map<String, dynamic> toJson() => _$RejectedToJson(this);
// }
//
// @JsonSerializable()
// class Error {
//   int code;
//   String message;
//
//   Error({required this.code, required this.message});
//   factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);
//   Map<String, dynamic> toJson() => _$ErrorToJson(this);
// }
//
// @JsonSerializable()
// class Accepted {
//   String? number;
//   int? carrier;
//
//   Accepted({required this.number, required this.carrier});
//   factory Accepted.fromJson(Map<String, dynamic> json) =>
//       _$AcceptedFromJson(json);
//   Map<String, dynamic> toJson() => _$AcceptedToJson(this);
// }
