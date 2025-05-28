// lib/pages/complaint_tracking_page.dart
import 'package:flutter/material.dart';
import 'package:hubaix/features/my_complains/presentation/widgets/my_complains_list.dart';
import 'package:hubaix/features/my_complains/repository/data/complains_dummy_list.dart';

import '../../file_complaint/presentation/file_complaint_screen.dart';

class MyComplainsScreen extends StatefulWidget {
  const MyComplainsScreen({super.key});

  @override
  _MyComplainsScreenState createState() => _MyComplainsScreenState();
}

class _MyComplainsScreenState extends State<MyComplainsScreen> {
  @override
  Widget build(BuildContext context) {
    print("called");
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Complaints'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Implement filtering functionality
            },
          ),
        ],
      ),
      body: myComplaints.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No complaints yet',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ],
              ),
            )
          : MyComplainsList(myComplaints: myComplaints),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ComplaintPage(),
            ),
          );

          if (result == true) {
            setState(() {});
          }
        },
        tooltip: 'Add Complaint',
        child: const Icon(Icons.add),
      ),
    );
  }
}
