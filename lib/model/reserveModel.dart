class ReserveModel {
  final String lotNumber;
  final String sectionLetters;
  final String blockNumber;
  final String deceasedName;
  final String birthDate;
  final String deathDate;
  final String message;
  final String email;
  final double payment;

  ReserveModel({
    required this.lotNumber,
    required this.sectionLetters,
    required this.blockNumber,
    required this.deceasedName,
    required this.birthDate,
    required this.deathDate,
    required this.message,
    required this.email,
    required this.payment,
  });

  Map<String, dynamic> toJson() => {
        'lot number': lotNumber,
        'section letters': sectionLetters,
        'block number': blockNumber,
        'deceased name': deceasedName,
        'birth date': birthDate,
        'death date': deathDate,
        'message': message,
        'email': email,
        "payment": payment
      };

  static ReserveModel fromJson(Map<String, dynamic> json) => ReserveModel(
      lotNumber: json['lot number'],
      sectionLetters: json['section letters'],
      blockNumber: json['block number'],
      deceasedName: json['deceased name'],
      birthDate: json['birth date'],
      deathDate: json['death date'],
      message: json['message'],
      email: json['email'],
      payment: json['payment']);
}
