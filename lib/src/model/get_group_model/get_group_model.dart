class GetGroupModel {
  final String groupId;
  final String groupName;
  final String status;
  final int totalMembers;
  final String roundInfo;
  final int contributionAmount;
  final String description;
  final List<dynamic> members;
  final String lastWinnerName;
  final String? nextCycleDate;

  GetGroupModel({
    required this.groupId,
    required this.groupName,
    required this.status,
    required this.totalMembers,
    required this.roundInfo,
    required this.contributionAmount,
    required this.description,
    required this.members,
    required this.lastWinnerName,
    this.nextCycleDate,
  });

  factory GetGroupModel.fromJson(Map<String, dynamic> json) {
    return GetGroupModel(
      groupId: json['groupId'],
      groupName: json['groupName'],
      status: json['status'],
      totalMembers: json['totalMembers'],
      roundInfo: json['roundInfo'],
      contributionAmount: json['contributionAmount'],
      description: json['description'],
      members: json['members'] ?? [],
      lastWinnerName: json['LastwinnerName'],
      nextCycleDate: json['nextCycleDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'groupId': groupId,
      'groupName': groupName,
      'status': status,
      'totalMembers': totalMembers,
      'roundInfo': roundInfo,
      'contributionAmount': contributionAmount,
      'description': description,
      'members': members,
      'LastwinnerName': lastWinnerName,
      'nextCycleDate': nextCycleDate,
    };
  }
}
