class Location {
  String street = "";
  int postal_code = 0;
  double latitude = 0;
  double longitude = 0;
  String house_number = "";
  String city = "";
  String country = "";


  Location(this.street, this.postal_code, this.house_number, this.city, this.country {this.latitude = 0, this.longitude = 0});

  // deserialize
  Location.fromJson(Map<String, Object> json) {
    this.street = json['address'] as String;
    this.postal_code = json['postal_code'] as int;
    this.latitude = json['latitude'] as double;
    this.longitude = json['longitude'] as double;
    this.house_number = json['house_number'] as String;
    this.city = json['city'] as String;
    this.country = json['country'] as String;

  }

  // serialization
  Map<String, Object> toJson() {
    return {
      'address': this.street,
      'postal_code': this.postal_code,
      'latitude': this.latitude,
      'longitude': this.latitude,
      'house_number': this.house_number,
      'city': this.city,
      'country': this.country,
    };
  }
}
