import 'package:flutter/material.dart';
import 'package:hubaix/config/components/member_tile.dart';
import 'package:hubaix/features/bottom_navigation/pages/member_page/presentation/widgets/uc_list_widget.dart';
import 'package:hubaix/features/bottom_navigation/pages/member_page/repository/model/UcData_model.dart';

class MemberPage extends StatelessWidget {
  const MemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Members",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: const SafeArea(child: UcListWidget()),
    );
  }
}
