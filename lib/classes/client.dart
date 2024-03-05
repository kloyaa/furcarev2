import 'package:furcarev2/classes/registration.dart';

class Profile {
  final String firstName;
  final String lastName;
  final String birthdate;
  final String gender;
  final Address address;
  final Contact contact;
  final bool isActive;

  Profile({
    required this.firstName,
    required this.lastName,
    required this.birthdate,
    required this.gender,
    required this.address,
    required this.contact,
    required this.isActive,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      firstName: json['firstName'],
      lastName: json['lastName'],
      birthdate: json['birthdate'],
      gender: json['gender'],
      isActive: json['isActive'],
      address: Address.fromJson(json['address']),
      contact: Contact.fromJson(json['contact']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'birthdate': birthdate,
      'gender': gender,
      'isActive': isActive,
      'address': address.toJson(),
      'contact': contact.toJson(),
    };
  }
}
