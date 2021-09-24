class Location {
  static Location mockAddress = Location("Street", 111, "23a", "Muenster", "Germany", latitude: 1.32, longitude: 22.232);

  String street;
  int postalCode;
  double latitude;
  double longitude;
  String houseNumber;
  String city;
  String country;

  Location(
      this.street, this.postalCode, this.houseNumber, this.city, this.country,
      {this.latitude = 0, this.longitude = 0});

  // deserialize
  Location.fromJson(Map<String, Object> json) {
    this.street = json['address'] as String;
    this.postalCode = json['postal_code'] as int;
    this.latitude = json['latitude'] as double;
    this.longitude = json['longitude'] as double;
    this.houseNumber = json['house_number'] as String;
    this.city = json['city'] as String;
    this.country = json['country'] as String;
  }

  // serialization
  Map<String, Object> toJson() {
    return {
      'address': this.street,
      'postal_code': this.postalCode,
      'latitude': this.latitude,
      'longitude': this.latitude,
      'house_number': this.houseNumber,
      'city': this.city,
      'country': this.country,
    };
  }
}
