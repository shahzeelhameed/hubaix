import 'package:flutter/material.dart';
import 'package:hubaix/features/my_complains/presentation/widgets/delete_complaint_dialog.dart';
import 'package:hubaix/features/my_complains/presentation/widgets/edit_complaint_dialog.dart';
import 'package:hubaix/features/my_complains/repository/data/complains_dummy_list.dart';
import 'package:hubaix/features/my_complains/repository/model/complaint.dart';
import 'package:hubaix/utils/utils.dart';

class MyComplainsList extends StatefulWidget {
  MyComplainsList({super.key, required this.myComplaints});

  List<Complaint> myComplaints;

  @override
  State<MyComplainsList> createState() => _MyComplainsListState();
}

class _MyComplainsListState extends State<MyComplainsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: myComplaints.length,
      itemBuilder: (context, index) {
        final complaint = myComplaints[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          child: ExpansionTile(
            title: Text(
              complaint.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Color(int.parse(
                            _getStatusColor(complaint.status).substring(1, 7),
                            radix: 16) +
                        0xFF000000),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    complaint.status,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Submitted: ${complaint.dateSubmitted.toString().split(' ')[0]}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(complaint.description),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit'),
                          onPressed: () => Utils.showDialogBox(
                              context,
                              EditComplaintDialog(
                                complaint: complaint,
                                onRefresh: (isRefresh) {
                                  if (isRefresh == true) {
                                    setState(() {});
                                  }
                                },
                              )),
                        ),
                        const SizedBox(width: 8),
                        TextButton.icon(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          label: const Text('Delete',
                              style: TextStyle(color: Colors.red)),
                          onPressed: () => Utils.showDialogBox(
                              context,
                              DeleteComplaintDialog(
                                index: index,
                                onRefresh: (isRefresh) {
                                  if (isRefresh == true) {
                                    setState(() {});
                                  }
                                },
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return '#FFA500'; // Orange
      case 'in progress':
        return '#1E90FF'; // Blue
      case 'resolved':
        return '#32CD32'; // Green
      default:
        return '#808080'; // Gray
    }
  }
}
