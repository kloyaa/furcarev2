class Pet {
  final String id;
  final String user;
  final String name;
  final String specie;
  final int age;
  final String gender;
  final String identification;
  final Map<String, dynamic> additionalInfo;
  final String createdAt;
  final String updatedAt;
  final int v;

  Pet({
    required this.id,
    required this.user,
    required this.name,
    required this.specie,
    required this.age,
    required this.gender,
    required this.identification,
    required this.additionalInfo,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['_id'],
      user: json['user'],
      name: json['name'],
      specie: json['specie'],
      age: json['age'],
      gender: json['gender'],
      identification: json['identification'],
      additionalInfo: json['additionalInfo'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}
