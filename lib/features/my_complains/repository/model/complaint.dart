class Complaint {
  final String title;
  final String description;
  final String status;
  final DateTime dateSubmitted;
  final String? imagePath;

  Complaint({
    required this.title,
    required this.description,
    required this.status,
    required this.dateSubmitted,
    this.imagePath,
  });

  Complaint copyWith({
    String? title,
    String? description,
    String? status,
    DateTime? dateSubmitted,
    String? imagePath,
  }) {
    return Complaint(
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      dateSubmitted: dateSubmitted ?? this.dateSubmitted,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
