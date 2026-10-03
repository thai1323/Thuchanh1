import '../models/document_model.dart';

class DocumentRepository {
  final List<DocumentModel> _documents = [];

  List<DocumentModel> getAllDocuments() {
    return List.unmodifiable(_documents);
  }

  void addDocument(DocumentModel doc) {
    _documents.add(doc);
  }

  void updateDocument(DocumentModel updatedDoc) {
    final index = _documents.indexWhere((doc) => doc.id == updatedDoc.id);
    if (index != -1) {
      _documents[index] = updatedDoc;
    }
  }

  void deleteDocument(String id) {
    _documents.removeWhere((doc) => doc.id == id);
  }

  List<DocumentModel> searchDocuments(String query, String category) {
    return _documents.where((doc) {
      final matchesQuery =
          doc.title.toLowerCase().contains(query.toLowerCase()) ||
          doc.description.toLowerCase().contains(query.toLowerCase());
      final matchesCategory = category.isEmpty || doc.category == category;
      return matchesQuery && matchesCategory;
    }).toList();
  }
}
