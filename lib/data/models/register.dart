class Data1 {
  List<Accepted>? accepted;
  List<Rejected>? rejected;
  Data1({this.rejected, this.accepted});
  factory Data1.fromJson(Map<String, dynamic> json) {
    return Data1(
      accepted: (json['accepted'] as List?)
          ?.map((item) => Accepted.fromJson(item))
          .toList(),
      rejected: (json['rejected'] as List?)
          ?.map((item) => Rejected.fromJson(item))
          .toList(),
    );
  }
}

class Rejected {
  String? number;
  Error? error;

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
  String? number;
  int? carrier;

  Accepted({required this.number, required this.carrier});

  factory Accepted.fromJson(Map<String, dynamic> json) {
    return Accepted(number: json['number'], carrier: json['carrier']);
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
