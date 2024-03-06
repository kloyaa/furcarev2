class BoardingPayload {
  final String cage;
  final String pet;
  final String schedule;
  final int daysOfStay;

  BoardingPayload({
    required this.cage,
    required this.pet,
    required this.schedule,
    required this.daysOfStay,
  });

  Map<String, dynamic> toJson() {
    return {
      'cage': cage,
      'pet': pet,
      'schedule': schedule,
      'daysOfStay': daysOfStay,
    };
  }
}
