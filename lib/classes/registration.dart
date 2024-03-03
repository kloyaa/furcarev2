class BasicInfo {
  final String firstName;
  final String lastName;
  final String birthdate;
  final String gender;

  BasicInfo({
    required this.firstName,
    required this.lastName,
    required this.birthdate,
    required this.gender,
  });

  factory BasicInfo.fromJson(Map<String, dynamic> json) {
    return BasicInfo(
      firstName: json['firstName'],
      lastName: json['lastName'],
      birthdate: json['birthdate'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'birthdate': birthdate,
      'gender': gender,
    };
  }
}

class Address {
  final String present;
  final String permanent;

  Address({
    required this.present,
    required this.permanent,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      present: json['address']['present'],
      permanent: json['address']['permanent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'present': present,
      'permanent': permanent,
    };
  }
}

class Contact {
  final String email;
  final String number;

  Contact({
    required this.email,
    required this.number,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      email: json['contact']['email'],
      number: json['contact']['number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'number': number,
    };
  }
}
