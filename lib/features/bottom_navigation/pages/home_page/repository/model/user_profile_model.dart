class UserProfile {
  final int userId;
  final String username;
  final String email;
  final String cnicNumber;
  String phoneNumber;
  final String role;
  final String photoUrl;

  UserProfile({
    required this.userId,
    required this.username,
    required this.email,
    required this.cnicNumber,
    required this.phoneNumber,
    required this.role,
    required this.photoUrl,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['user_id'] ?? 0,
      username: json['username'] ?? 'Unknown',
      email: json['email'] ?? '',
      cnicNumber: json['cnic_number'] ?? '',
      phoneNumber: json['phone'] ?? '',
      role: json['role'] ?? 'user',
      photoUrl: json['photo_url'] ?? 'default_photo.png',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'email': email,
      'cnic_number': cnicNumber,
      'phone': phoneNumber,
      'role': role,
      'photo_url': photoUrl,
    };
  }
}
