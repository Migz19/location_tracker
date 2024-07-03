class Address {
  final String label;
  final String countryCode;
  final String district;
  final String city;
  final String street;
  final String countryName;
  final String country;

  Address({
    required this.label,
    required this.countryCode,
    required this.district,
    required this.city,
    required this.street,
    required this.countryName,
    required this.country,
  });
  factory Address.fromJson(Map<String, dynamic> json) {

    return Address(
      label: json['address']['label']??'',
      countryCode: json['address']['countryCode'] ??'',
      district: json['address']['district'] ??'',
      city: json['address']['city'] ??'',
      street: json['address']['street'] ??'',
      countryName: json['address']['countryName'] ??'',
      country: json['address']['county'] ??'',
    );
  }

  @override
  String toString() {
    return 'Address{label: $label, countryCode: $countryCode, district: $district, city: $city, street: $street, countryName: $countryName, country: $country}';
  }
}
