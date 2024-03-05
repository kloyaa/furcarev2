class Pet {
  final String id;
  final String user;
  final String name;
  final String specie;
  final int age;
  final String gender;
  final String identification;
  final AdditionalInfo additionalInfo;
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

class CreatePetPayload {
  final String name;
  final String specie;
  final int age;
  final String gender;
  final String identification;
  final AdditionalInfo additionalInfo;

  CreatePetPayload({
    required this.name,
    required this.specie,
    required this.age,
    required this.gender,
    required this.identification,
    required this.additionalInfo,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'specie': specie,
      'age': age,
      'gender': gender,
      'identification': identification,
      'additionalInfo': additionalInfo.toJson(),
    };
  }
}

class AdditionalInfo {
  final bool historyOfBitting;
  final String feedingInstructions;
  final String medicationInstructions;

  AdditionalInfo({
    required this.historyOfBitting,
    required this.feedingInstructions,
    required this.medicationInstructions,
  });

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) {
    return AdditionalInfo(
      historyOfBitting: json['historyOfBitting'],
      feedingInstructions: json['feedingInstructions'],
      medicationInstructions: json['medicationInstructions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'historyOfBitting': historyOfBitting,
      'feedingInstructions': feedingInstructions,
      'medicationInstructions': medicationInstructions
    };
  }
}
