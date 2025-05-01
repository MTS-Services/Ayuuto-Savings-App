class GroupModel {
  final String adminUserId;
  final String groupName;
  final int contributionAmount;
  final String frequency;
  final int maxMembers;
  final String description;

  GroupModel({
    required this.adminUserId,
    required this.groupName,
    required this.contributionAmount,
    required this.frequency,
    required this.maxMembers,
    required this.description,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      adminUserId: json['adminUserId'],
      groupName: json['groupName'],
      contributionAmount: json['contributionAmount'],
      frequency: json['frequency'],
      maxMembers: json['maxMembers'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adminUserId': adminUserId,
      'groupName': groupName,
      'contributionAmount': contributionAmount,
      'frequency': frequency,
      'maxMembers': maxMembers,
      'description': description,
    };
  }
}
