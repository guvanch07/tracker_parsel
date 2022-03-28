// import 'package:equatable/equatable.dart';
//
// class RegisterEntity extends Equatable {
//   final int code;
//   final DataEntity data;
//
//   RegisterEntity({
//     required this.code,
//     required this.data,
//   });
//
//   @override
//   List<Object?> get props => [
//         code,
//         data,
//       ];
// }
//
// class DataEntity {
//   final AcceptedEntity accepted;
//   final RejectedEntity rejected;
//
//   const DataEntity(this.accepted, this.rejected);
// }
//
// class AcceptedEntity {
//   final int origin;
//   final String number;
//   final int carrier;
//
//   AcceptedEntity(this.origin, this.number, this.carrier);
// }
//
// class RejectedEntity {
//   final String number;
//   final ErrorEntity error;
//   RejectedEntity(this.number, this.error);
// }
//
// class ErrorEntity {
//   final int code;
//   final String message;
//   ErrorEntity(this.code, this.message);
// }
