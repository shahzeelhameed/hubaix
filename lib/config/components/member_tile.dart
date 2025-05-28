import 'package:flutter/material.dart';
import 'package:hubaix/features/bottom_navigation/pages/member_page/repository/model/UcData_model.dart';

class MemberTile extends StatelessWidget {
  final UcMember member;

  const MemberTile({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            child: Image(
              image: NetworkImage(member.img_Url, scale: 9),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              member.member_name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              member.phone_no,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              member.address,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            )
          ],
        )
      ],
    );
  }
}
