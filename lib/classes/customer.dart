import 'package:furcarev2/classes/client.dart';
import 'package:furcarev2/classes/pet.dart';

class Customer {
  final String id;
  final String username;
  final String email;
  final String createdAt;
  final String updatedAt;
  final Profile profile;
  final Owner owner;
  final List<Pet> pets;

  Customer({
    required this.id,
    required this.username,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.profile,
    required this.owner,
    required this.pets,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      profile: Profile.fromJson(json['profile']),
      owner: Owner.fromJson(json['owner']),
      pets: (json['pets'] as List<dynamic>)
          .map((petJson) => Pet.fromJson(petJson))
          .toList(),
    );
  }
}

class Owner {
  final String id;
  final String name;
  final String address;
  final String mobileNo;
  final String email;
  final String emergencyContactNo;
  final String work;
  final String createdAt;
  final String updatedAt;

  Owner({
    required this.id,
    required this.name,
    required this.address,
    required this.mobileNo,
    required this.email,
    required this.emergencyContactNo,
    required this.work,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['_id'],
      name: json['name'],
      address: json['address'],
      mobileNo: json['mobileNo'],
      email: json['email'],
      emergencyContactNo: json['emergencyContactNo'],
      work: json['work'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
