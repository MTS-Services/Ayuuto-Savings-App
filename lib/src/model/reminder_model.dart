class Member {
  final String name;
  final String email;
  final String paymentStatus;

  Member({
    required this.name,
    required this.email,
    required this.paymentStatus,
  });
  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      name: json['name'] as String,
      email: json['email'] as String,
      paymentStatus: json['paymentStatus'] as String,
    );
  }
}
