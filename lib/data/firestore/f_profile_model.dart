import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProfileModel {
  final Address address;
  final int id;
  final String email;
  final String username;
  final String password;
  final Name name;
  final String phone;
  final int version;

  const FirestoreProfileModel({
    required this.address,
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.phone,
    required this.version,
  });

  factory FirestoreProfileModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return FirestoreProfileModel(
      address: Address.fromMap(data['address']),
      id: data['id'],
      email: data['email'],
      username: data['username'],
      password: data['password'],
      name: Name.fromMap(data['name']),
      phone: data['phone'],
      version: data['version'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address.toMap(),
      'id': id,
      'email': email,
      'username': username,
      'password': password,
      'name': name.toMap(),
      'phone': phone,
      'version': version,
    };
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

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      geolocation: GeoLocation.fromMap(map['geolocation']),
      city: map['city'],
      street: map['street'],
      number: map['number'],
      zipcode: map['zipcode'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'geolocation': geolocation.toMap(),
      'city': city,
      'street': street,
      'number': number,
      'zipcode': zipcode,
    };
  }
}

class GeoLocation {
  final String lat;
  final String long;

  const GeoLocation({
    required this.lat,
    required this.long,
  });

  factory GeoLocation.fromMap(Map<String, dynamic> map) {
    return GeoLocation(
      lat: map['lat'],
      long: map['long'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'long': long,
    };
  }
}

class Name {
  final String firstname;
  final String lastname;

  const Name({
    required this.firstname,
    required this.lastname,
  });

  factory Name.fromMap(Map<String, dynamic> map) {
    return Name(
      firstname: map['firstname'],
      lastname: map['lastname'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
    };
  }
}
