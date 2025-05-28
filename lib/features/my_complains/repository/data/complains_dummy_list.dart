import 'package:hubaix/features/my_complains/repository/model/complaint.dart';

List<Complaint> myComplaints = [
  Complaint(
    title: 'Network Issue',
    description: 'Poor network connectivity in Block A',
    status: 'In Progress',
    dateSubmitted: DateTime.now().subtract(const Duration(days: 2)),
  ),
  Complaint(
    title: 'Maintenance Request',
    description: 'AC not working properly',
    status: 'Pending',
    dateSubmitted: DateTime.now().subtract(const Duration(days: 1)),
  ),
];
