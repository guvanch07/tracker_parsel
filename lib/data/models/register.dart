class Data {
  Accepted? accepted;
  Rejected? rejected;
  Data({this.rejected, this.accepted});
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      accepted: Accepted.fromJson(json["accepted"]),
      rejected: Rejected.fromJson(json["rejected"]),
    );
  }
}

class Rejected {
  String number;
  Error error;

  Rejected({required this.number, required this.error});

  factory Rejected.fromJson(Map<String, dynamic> json) {
    return Rejected(
        number: json['number'], error: Error.fromJson(json['error']));
  }
}

class Error {
  int code;
  String message;

  Error({required this.code, required this.message});

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(code: json['code'], message: json['message']);
  }
}

// "origin": 1,
// "number": "SB071931150LV",
// "carrier": 12021
//
class Accepted {
  int origin;
  String number;
  int carrier;

  Accepted({required this.origin, required this.number, required this.carrier});

  factory Accepted.fromJson(Map<String, dynamic> json) {
    return Accepted(
        origin: json['origin'],
        number: json['number'],
        carrier: json['carrier']);
  }
}

// "number": "SB071931150LV",
// "error": {
// "code": -18019901,
// "message": "The tracking number 'SB071931150LV' has been registered, don't need to repeat registration."
//
// class Rejected {
//   String number;
//   Error error;
//
//   Rejected({required this.number, required this.error});
//
//   factory Rejected.fromJson(Map<String, dynamic> json) {
//     return Rejected(
//         number: json['number'], error: Error.fromJson(json['error']));
//   }
// }
//
// class Error {
//   int code;
//   String message;
//
//   Error({required this.code, required this.message});
//
//   factory Error.fromJson(Map<String, dynamic> json) {
//     return Error(code: json['code'], message: json['message']);
//   }
// }
//
// // class RegisterModel {
// //   final String number;
// //   final int carrier;
// //
// //   const RegisterModel({required this.number, required this.carrier});
// //
// //   factory RegisterModel.fromJson(Map<String, dynamic> json) {
// //     return RegisterModel(
// //       number: json['number'],
// //       carrier: json['carrier'],
// //     );
// //   }
// //
// //   Map<String, dynamic> toJson() => {
// //         'number': number,
// //         'carrier': carrier,
// //       };
// // }
