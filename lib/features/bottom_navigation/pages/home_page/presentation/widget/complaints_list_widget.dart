import 'package:flutter/material.dart';
import 'package:hubaix/data/complaints_list_data.dart';

class ComplaintsListWidget extends StatelessWidget {
  const ComplaintsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: dummyComplaints.length,
      itemBuilder: (context, index) {
        final complaint = dummyComplaints[index];
        return SizedBox(
          width: 400,
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(complaint.description),
              subtitle: Text(complaint.description),
              trailing: Chip(
                label: Text(
                  complaint.status,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.blue,
              ),
            ),
          ),
        );
      },
    );
  }
}
