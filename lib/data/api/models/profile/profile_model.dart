class ProfileModel {
  final Address address;
  final int id;
  final String email;
  final String username;
  final String password;
  final Name name;
  final String phone;
  final int version;

  const ProfileModel({
    required this.address,
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.phone,
    required this.version,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      address: Address.fromJson(json['address']),
      id: json['id'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      name: Name.fromJson(json['name']),
      phone: json['phone'],
      version: json['__v'],
    );
  }
}

class Address {
  final GeoLocation geolocation;
  final String city;
  final String street;
  final int number;
  final String zipcode;

  const Address({
    required this.geolocation,
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      geolocation: GeoLocation.fromJson(json['geolocation']),
      city: json['city'],
      street: json['street'],
      number: json['number'],
      zipcode: json['zipcode'],
    );
  }
}

class GeoLocation {
  final String lat;
  final String long;

  const GeoLocation({
    required this.lat,
    required this.long,
  });

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    return GeoLocation(
      lat: json['lat'],
      long: json['long'],
    );
  }
}

class Name {
  final String firstname;
  final String lastname;

  const Name({
    required this.firstname,
    required this.lastname,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      firstname: json['firstname'],
      lastname: json['lastname'],
    );
  }
}
