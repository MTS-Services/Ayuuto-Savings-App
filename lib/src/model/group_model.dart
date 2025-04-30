class GroupModel {
  final String groupName;
  final String roundInfo;
  final String status;
  final String yourTurnDay;
  final String yourTurnMonthYear;
  final String nextPaymentDay;
  final String nextPaymentMonthYear;
  final String progressText;
  final String completedText;

  GroupModel({
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
}