class MyGroupModel {
  final String groupName;
  final String roundInfo;
  final String status;
  final String yourTurnDay;
  final String yourTurnMonthYear;
  final String nextPaymentDay;
  final String nextPaymentMonthYear;
  final String progressText;
  final String completedText;

  MyGroupModel({
    required this.groupName,
    required this.roundInfo,
    required this.status,
    required this.yourTurnDay,
    required this.yourTurnMonthYear,
    required this.nextPaymentDay,
    required this.nextPaymentMonthYear,
    required this.progressText,
    required this.completedText,
  });
  factory MyGroupModel.fromJson(Map<String, dynamic> json) {
    return MyGroupModel(
      groupName: json['groupName'] ?? "",
      roundInfo: json['roundInfo'] ?? "",
      status: json['status'] ?? "",
      yourTurnDay: json['yourTurnDay'] ?? "",
      yourTurnMonthYear: json['yourTurnMonthYear'] ?? "",
      nextPaymentDay: json['nextPaymentDay'] ?? "",
      nextPaymentMonthYear: json['nextPaymentMonthYear'] ?? "",
      progressText: json['progressText'] ?? "",
      completedText: json['completedText'] ?? "",
    );
  }
}
