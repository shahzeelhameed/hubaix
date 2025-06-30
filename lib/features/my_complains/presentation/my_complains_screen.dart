// lib/pages/complaint_tracking_page.dart
import 'package:flutter/material.dart';
import 'package:hubaix/features/file_complaint/presentation/file_complaint_screen.dart';
import 'package:hubaix/features/my_complains/repository/model/complaint.dart';

import 'package:hubaix/features/my_complains/presentation/widgets/my_complains_list.dart';
import 'package:hubaix/features/my_complains/service/my_complaint_service.dart';

class MyComplainsScreen extends StatefulWidget {
  const MyComplainsScreen({super.key});

  @override
  _MyComplainsScreenState createState() => _MyComplainsScreenState();
}

class _MyComplainsScreenState extends State<MyComplainsScreen> {
  late Future<List<Complaint>> _complaintFuture;

  @override
  void initState() {
    super.initState();
    _complaintFuture = ComplaintFetchService.getUserComplaints();
  }

  void _refresh() {
    setState(() {
      _complaintFuture = ComplaintFetchService.getUserComplaints();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Complaints'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Future filter functionality
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Complaint>>(
        future: _complaintFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No complaints found.'));
          }

          return MyComplainsList(
            myComplaints: snapshot.data!,
            onEdit: (id, description) {
              print(
                  'Edit complaint with ID: $id, new description: $description');
            },
            onDelete: (id) async {
              final deleted = await ComplaintFetchService.deleteComplaint(id);
              if (deleted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Complaint deleted')),
                );
                _refresh();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Delete failed')),
                );
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ComplaintPage(),
            ),
          );
          if (result == true) _refresh();
        },
        tooltip: 'Add Complaint',
        child: const Icon(Icons.add),
      ),
    );
  }
}
