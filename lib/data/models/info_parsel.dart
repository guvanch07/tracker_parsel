class Data2 {
  List<Accepted?>? accepted;

  List<Rejected?>? rejected;

  Data2({this.accepted, this.rejected});

  factory Data2.fromJson(Map<String, dynamic> json) {
    return Data2(
      accepted: (json['accepted'] as List?)
          ?.map((item) => Accepted.fromJson(item))
          .toList(),
      rejected: (json['rejected'] as List?)
          ?.map((item) => Rejected.fromJson(item))
          .toList(),
    );
  }
}

class Accepted {
  String? number;
  Track? track;

  Accepted({required this.track, required this.number});

  factory Accepted.fromJson(Map<String, dynamic> json) {
    return Accepted(
      number: json['number'],
      track: Track.fromJson(
        json['track'],
      ),
    );
  }
}

class Rejected {
  String? number;

  Rejected({required this.number});

  factory Rejected.fromJson(Map<String, dynamic> json) {
    return Rejected(
      number: json['number'],
    );
  }
}

class Track {
  List<FirstCarrierEvent?>? firstCarrierEvent; //z1
  List<SecondCarrierEvent?>? secondCarrierEvent; //z2

  Track(
      {
      // required this.secondCarrierEvent,
      required this.firstCarrierEvent,
      required this.secondCarrierEvent});

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
        firstCarrierEvent: (json['z1'] as List?)
            ?.map((item) => FirstCarrierEvent.fromJson(item))
            .toList(), //z1
        secondCarrierEvent: (json['z2'] as List?)
            ?.map((item) => SecondCarrierEvent.fromJson(item))
            .toList()); //z2
  }
}

// "a": "2022-03-15 12:18",
// "c": "",
// "d": "",
// "z": "Parcel has arrived at transit location"
class FirstCarrierEvent {
  String? eventTime; //a
  String? eventLocation; //c
  String? eventLocationExtension; //d
  String? eventContent; //z
  FirstCarrierEvent(
      {required this.eventTime,
      required this.eventLocation,
      required this.eventLocationExtension,
      required this.eventContent});

  factory FirstCarrierEvent.fromJson(Map<String, dynamic> json) {
    return FirstCarrierEvent(
        eventTime: json['a'],
        eventLocation: json['c'],
        eventLocationExtension: json['d'],
        eventContent: json['z']);
  }
  Map<String, dynamic> toJson() {
    return {
      'a': eventTime,
      'c': eventLocation,
      'd': eventLocationExtension,
      'z': eventContent,
    };
  }
}

class SecondCarrierEvent {
  String? eventTime; //a
  String? eventLocation; //c
  String? eventLocationExtension; //d
  String? eventContent; //z
  SecondCarrierEvent(
      {required this.eventTime,
      required this.eventLocation,
      required this.eventLocationExtension,
      required this.eventContent});

  factory SecondCarrierEvent.fromJson(Map<String, dynamic> json) {
    return SecondCarrierEvent(
        eventTime: json['a'],
        eventLocation: json['c'],
        eventLocationExtension: json['d'],
        eventContent: json['z']);
  }
}
