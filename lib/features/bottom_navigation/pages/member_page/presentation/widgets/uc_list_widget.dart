import 'package:flutter/material.dart';
import 'package:hubaix/config/components/member_tile.dart';
import 'package:hubaix/features/bottom_navigation/pages/member_page/repository/data/uc_dummy_list.dart';
import 'package:hubaix/features/bottom_navigation/pages/member_page/repository/model/UcData_model.dart';

class UcListWidget extends StatelessWidget {
  const UcListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ucList.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          child: ExpansionTile(
            title: Text(
              ucList[index].uc_name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            children: ucList[index]
                .members
                .map(
                  (member) => MemberTile(member: member),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
