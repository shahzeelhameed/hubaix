class Uc {
  Uc({required this.uc_name, required this.members});
  String uc_name;
  List<UcMember> members;
}

class UcMember {
  UcMember(
      {required this.member_name,
      required this.address,
      required this.phone_no,
      required this.img_Url});

  String member_name;
  String address;
  String phone_no;
  String img_Url;
}
