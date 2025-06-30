import 'package:flutter/material.dart';
import 'package:hubaix/features/my_complains/repository/model/complaint.dart';

class MyComplainsList extends StatelessWidget {
  final List<Complaint> myComplaints;
  final Function(int id) onDelete;
  final Function(int id, String description) onEdit;

  const MyComplainsList({
    super.key,
    required this.myComplaints,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: myComplaints.length,
      itemBuilder: (context, index) {
        final complaint = myComplaints[index];
        final TextEditingController controller =
            TextEditingController(text: complaint.description);

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ExpansionTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    complaint.description.length > 40
                        ? '${complaint.description.substring(0, 40)}...'
                        : complaint.description,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(
                      int.parse(
                            _getStatusColor(complaint.status).substring(1, 7),
                            radix: 16,
                          ) +
                          0xFF000000,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    complaint.status,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                'Submitted: ${complaint.createdAt.toString().split(' ')[0]}',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ),
            childrenPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(complaint.description),
                  const SizedBox(height: 12),
                  Text('Priority: ${complaint.priority.toUpperCase()}'),
                  const SizedBox(height: 4),
                  Text('Created By: ${complaint.createdBy}'),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () async {
                          final saveConfirm = await showDialog<bool>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Edit Complaint'),
                                content: TextField(
                                  controller: controller,
                                  maxLines: 3,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter new description',
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                    child: const Text('Save'),
                                  ),
                                ],
                              );
                            },
                          );

                          if (saveConfirm == true) {
                            onEdit(complaint.id, controller.text.trim());
                          }
                        },
                        icon: const Icon(Icons.edit, size: 18),
                        label: const Text("Edit"),
                      ),
                      const SizedBox(width: 8),
                      TextButton.icon(
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Confirm Delete'),
                              content: const Text('Are you sure to delete?'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            onDelete(complaint.id);
                          }
                        },
                        icon: const Icon(Icons.delete,
                            size: 18, color: Colors.red),
                        label: const Text("Delete",
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  )
                ],
              )
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
