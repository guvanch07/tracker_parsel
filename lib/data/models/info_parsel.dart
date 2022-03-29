import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Data2 {
  List<Acceptedd> accepted;

  // Rejected rejected;
  Data2({required this.accepted});

  factory Data2.fromJson(Map<String, dynamic> json) {
    return Data2(
        accepted: (json['accepted'] as List<Acceptedd>)
            .map((dynamic item) =>
                Acceptedd.fromJson(item as Map<String, dynamic>))
            .toList()
        // rejected: Rejected.fromJson(json["rejected"]),
        );
  }
}

class Acceptedd {
  String number;
  Track track;

  Acceptedd({required this.track, required this.number});

  factory Acceptedd.fromJson(Map<String, dynamic> json) {
    return Acceptedd(
        number: json['number'], track: Track.fromJson(json['track']));
  }
}

class Track {
  List<FirstCarrierEvent> firstCarrierEvent; //z1
  //SecondCarrierEvent secondCarrierEvent; //z2

  Track(
      {
      // required this.secondCarrierEvent,
      required this.firstCarrierEvent});

  factory Track.fromJson(Map<String, dynamic> json) {
    final firstCarrierEventData = json['z1'];
    final firstCarrierEvent = firstCarrierEventData != null
        ? firstCarrierEventData
            .map((firstCarrierEventData) =>
                FirstCarrierEvent.fromJson(firstCarrierEventData))
            .toList()
        : <FirstCarrierEvent>[];
    return Track(
      firstCarrierEvent: firstCarrierEvent, //z1
      // secondCarrierEvent:
      // SecondCarrierEvent.fromJson(json['z2'])
    ); //z2
  }
}

// "a": "2022-03-15 12:18",
// "c": "",
// "d": "",
// "z": "Parcel has arrived at transit location"
class FirstCarrierEvent {
  DateTime eventTime; //a
  String eventLocation; //c
  String eventLocationExtension; //d
  String eventContent; //z
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
}
