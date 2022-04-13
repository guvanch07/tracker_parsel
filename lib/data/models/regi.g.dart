// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'regi.dart';
//
// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************
//
// Data1 _$Data1FromJson(Map<String, dynamic> json) => Data1(
//       rejected: (json['rejected'] as List<dynamic>?)
//           ?.map((e) => Rejected.fromJson(e as Map<String, dynamic>))
//           .toList(),
//       accepted: (json['accepted'] as List<dynamic>?)
//           ?.map((e) => Accepted.fromJson(e as Map<String, dynamic>))
//           .toList(),
//     );
//
// Map<String, dynamic> _$Data1ToJson(Data1 instance) => <String, dynamic>{
//       'accepted': instance.accepted,
//       'rejected': instance.rejected,
//     };
//
// Rejected _$RejectedFromJson(Map<String, dynamic> json) => Rejected(
//       number: json['number'] as String?,
//       error: json['error'] == null
//           ? null
//           : Error.fromJson(json['error'] as Map<String, dynamic>),
//     );
//
// Map<String, dynamic> _$RejectedToJson(Rejected instance) => <String, dynamic>{
//       'number': instance.number,
//       'error': instance.error,
//     };
//
// Error _$ErrorFromJson(Map<String, dynamic> json) => Error(
//       code: json['code'] as int,
//       message: json['message'] as String,
//     );
//
// Map<String, dynamic> _$ErrorToJson(Error instance) => <String, dynamic>{
//       'code': instance.code,
//       'message': instance.message,
//     };
//
// Accepted _$AcceptedFromJson(Map<String, dynamic> json) => Accepted(
//       number: json['number'] as String?,
//       carrier: json['carrier'] as int?,
//     );
//
// Map<String, dynamic> _$AcceptedToJson(Accepted instance) => <String, dynamic>{
//       'number': instance.number,
//       'carrier': instance.carrier,
//     };
