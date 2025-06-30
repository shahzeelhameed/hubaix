import 'package:hubaix/features/my_complains/repository/model/complaint.dart';

final List<Complaint> dummyComplaints = [
  Complaint(
    id: 1,
    description: 'Network Issue in Block A',
    status: 'In Progress',
    cnic: '12345-6789012-3',
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    createdBy: 'User1',
    userId: 101,
    priority: 'High',
  ),
];
