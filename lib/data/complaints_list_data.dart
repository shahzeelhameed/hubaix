import 'package:hubaix/features/my_complains/repository/model/complaint.dart';

final List<Complaint> complaints = [
  Complaint(
    title: 'Network Issue',
    description: 'Poor network connectivity in Block A',
    status: 'In Progress',
    dateSubmitted: DateTime.now().subtract(const Duration(days: 2)),
  ),
  Complaint(
    title: 'Network Issue',
    description: 'Poor network connectivity in Block A',
    status: 'In Progress',
    dateSubmitted: DateTime.now().subtract(const Duration(days: 2)),
  ),
];
