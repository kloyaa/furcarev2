class AdminProfileModel {
  final String id;
  final String user;
  final String firstName;
  final String lastName;
  final Map<String, String> address;
  final Map<String, String> contact;
  final DateTime birthdate;
  final String gender;
  final bool isActive;
  final int v;
  final DateTime createdAt;
  final DateTime updatedAt;

  AdminProfileModel({
    required this.id,
    required this.user,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.contact,
    required this.birthdate,
    required this.gender,
    required this.isActive,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AdminProfileModel.fromJson(Map<String, dynamic> json) {
    return AdminProfileModel(
      id: json['_id'],
      user: json['user'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      address: Map<String, String>.from(json['address']),
      contact: Map<String, String>.from(json['contact']),
      birthdate: DateTime.parse(json['birthdate']),
      gender: json['gender'],
      isActive: json['isActive'],
      v: json['__v'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
