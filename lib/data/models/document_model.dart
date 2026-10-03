class DocumentModel {
  final String id;
  final String title;
  final String category; // 'Bài giảng', 'Bài tập', 'Tài liệu tham khảo'
  final String fileUrl;
  final String description;
  final DateTime createdAt;

  DocumentModel({
    required this.id,
    required this.title,
    required this.category,
    required this.fileUrl,
    required this.description,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'fileUrl': fileUrl,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory DocumentModel.fromMap(Map<String, dynamic> map) {
    return DocumentModel(
      id: map['id'],
      title: map['title'],
      category: map['category'],
      fileUrl: map['fileUrl'],
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
