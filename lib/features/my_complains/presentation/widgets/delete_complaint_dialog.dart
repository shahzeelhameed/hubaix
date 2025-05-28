import 'package:flutter/material.dart';
import 'package:hubaix/features/my_complains/repository/data/complains_dummy_list.dart';

class DeleteComplaintDialog extends StatefulWidget {
  const DeleteComplaintDialog({
    super.key,
    required this.index,
    required this.onRefresh,
  });

  final int index;
  final Function(bool isRefresh) onRefresh;

  @override
  State<DeleteComplaintDialog> createState() => _DeleteComplaintDialogState();
}

class _DeleteComplaintDialogState extends State<DeleteComplaintDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Delete'),
      content: const Text('Are you sure you want to delete this complaint?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            myComplaints.removeAt(widget.index);

            widget.onRefresh(true);

            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Complaint deleted successfully')),
            );
          },
          child: const Text('Delete', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
