import 'package:flutter/material.dart';

import '../data/models/document_model.dart';
import '../data/repositories/document_repository.dart';

class DocumentController extends ChangeNotifier {
  final DocumentRepository _repository = DocumentRepository();

  String _searchQuery = '';
  String _selectedCategory = '';

  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;

  List<DocumentModel> get documents {
    if (_searchQuery.isEmpty && _selectedCategory.isEmpty) {
      return _repository.getAllDocuments();
    }
    return _repository.searchDocuments(_searchQuery, _selectedCategory);
  }

  void addDocument(DocumentModel doc) {
    _repository.addDocument(doc);
    notifyListeners();
  }

  void updateDocument(DocumentModel doc) {
    _repository.updateDocument(doc);
    notifyListeners();
  }

  void deleteDocument(String id) {
    _repository.deleteDocument(id);
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
