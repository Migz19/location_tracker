import 'address.dart';

class Place {
  Address address;
  String id, title, resultType, localityType;
  Map<String, double> position;

  Place(
      {required this.address,
      required this.id,
      required this.position,
      required this.resultType,
      required this.localityType,
      required this.title});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
        address: Address.fromJson(json),
        id: json['id'],
        position: {
          'lat': json['position']['lat'],
          'lng': json['position']['lng']
        },
        resultType: json['resultType'],
        title: json['title'],
        localityType: json['localityType']);


  }

  @override
  String toString() {
    return 'Place {address: $address, id: $id, title: $title,  resultType: $resultType, localityType: $localityType, position: $position,}';
  }
}
