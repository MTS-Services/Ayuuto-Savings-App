class GroupModel {
  final String groupId;
  final String groupName;
  final int totalMembers;
  final double contributionAmount;
  final String roundInfo;
  final String? nextCycleDate;
  final String lastWinnerName;
  final String status;
  final String acceptCode;

  GroupModel({
    required this.groupId,
    required this.groupName,
    required this.totalMembers,
    required this.contributionAmount,
    required this.roundInfo,
    required this.nextCycleDate,
    required this.lastWinnerName,
    required this.status,
    required this.acceptCode,
  });

  factory GroupModel.fromMap(Map<String, dynamic> map, String docId) {
    return GroupModel(
      groupId: docId,
      groupName: map['groupName'] ?? '',
      totalMembers: map['totalMembers'] ?? 0,
      contributionAmount: (map['contributionAmount'] ?? 0).toDouble(),
      roundInfo: map['roundInfo'] ?? '',
      nextCycleDate: map['nextCycleDate'],
      lastWinnerName: map['lastWinnerName'] ?? '',
      status: map['status'] ?? '',
      acceptCode: map['acceptCode'] ?? ''
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'groupName': groupName,
      'totalMembers': totalMembers,
      'contributionAmount': contributionAmount,
      'roundInfo': roundInfo,
      'nextCycleDate': nextCycleDate,
      'lastWinnerName': lastWinnerName,
      'status': status,
      'acceptCode': acceptCode,
    };
  }
}
