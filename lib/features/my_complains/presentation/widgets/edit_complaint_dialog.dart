import 'package:flutter/material.dart';
import 'package:hubaix/features/my_complains/repository/data/complains_dummy_list.dart';
import 'package:hubaix/features/my_complains/repository/model/complaint.dart';

class EditComplaintDialog extends StatefulWidget {
  final Complaint complaint;

  final Function(bool isRefresh) onRefresh;

  const EditComplaintDialog({
    super.key,
    required this.complaint,
    required this.onRefresh,
  });

  @override
  State<EditComplaintDialog> createState() => _EditComplaintDialogState();
}

class _EditComplaintDialogState extends State<EditComplaintDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: widget.complaint.description);
    _descriptionController =
        TextEditingController(text: widget.complaint.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Complaint'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Save'),
        ),
      ],
    );
  }
}
