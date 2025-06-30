import 'package:flutter/material.dart';
import 'package:hubaix/data/complaints_list_data.dart';
import 'package:hubaix/features/my_complains/repository/model/complaint.dart';
import 'package:hubaix/features/my_complains/service/my_complaint_service.dart';

class ComplaintsListWidget extends StatelessWidget {
  const ComplaintsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Complaint>>(
      future: ComplaintFetchService.getUserComplaints(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No complaints found.'));
        } else {
          final complaints = snapshot.data!;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: complaints.length,
            itemBuilder: (context, index) {
              final complaint = complaints[index];
              return SizedBox(
                width: 400,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        const Icon(Icons.report,
                            color: Colors.redAccent, size: 32),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Complaint ID: ${complaint.id}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                complaint.description,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Chip(
                          label: Text(
                            complaint.status,
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor:
                              complaint.status.toLowerCase() == 'resolved'
                                  ? Colors.green
                                  : Colors.orange,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
