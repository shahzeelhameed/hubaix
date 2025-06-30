class Complaint {
  final int id;
  final String createdBy;
  final int userId;
  final String description;
  final String cnic;
  final String status;
  final String priority;
  final DateTime createdAt;

  Complaint({
    required this.id,
    required this.createdBy,
    required this.userId,
    required this.description,
    required this.cnic,
    required this.status,
    required this.priority,
    required this.createdAt,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      id: json['complaint_id'],
      createdBy: json['created_by'],
      userId: json['user_id'],
      description: json['complaint_description'],
      cnic: json['cnic_number'],
      status: json['status'],
      priority: json['priority'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
