import 'package:flutter/material.dart';

import '../../logic/document_controller.dart';
import '../../data/models/document_model.dart';
import '../widgets/document_card.dart';
import 'add_edit_document_screen.dart';

class DocumentListScreen extends StatefulWidget {
  final DocumentController controller;

  const DocumentListScreen({super.key, required this.controller});

  @override
  State<DocumentListScreen> createState() => _DocumentListScreenState();
}

class _DocumentListScreenState extends State<DocumentListScreen> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerUpdate);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerUpdate);
    super.dispose();
  }

  void _onControllerUpdate() {
    setState(() {});
  }

  void _openAddScreen() async {
    final newDoc = await Navigator.of(context).push<DocumentModel>(
      MaterialPageRoute(builder: (_) => const AddEditDocumentScreen()),
    );
    if (newDoc != null) {
      widget.controller.addDocument(newDoc);
    }
  }

  void _openEditScreen(DocumentModel doc) async {
    final updatedDoc = await Navigator.of(context).push<DocumentModel>(
      MaterialPageRoute(builder: (_) => AddEditDocumentScreen(document: doc)),
    );
    if (updatedDoc != null) {
      widget.controller.updateDocument(updatedDoc);
    }
  }

  @override
  Widget build(BuildContext context) {
    final docs = widget.controller.documents;

    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý Tài liệu Học tập')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Tìm kiếm tài liệu...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (val) => widget.controller.setSearchQuery(val),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['', 'Bài giảng', 'Bài tập', 'Tài liệu tham khảo'].map((
                cat,
              ) {
                final isSelected = widget.controller.selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(cat.isEmpty ? 'Tất cả' : cat),
                    selected: isSelected,
                    onSelected: (_) =>
                        widget.controller.setSelectedCategory(cat),
                  ),
                );
              }).toList(),
            ),
          ),
          const Divider(),
          Expanded(
            child: docs.isEmpty
                ? const Center(child: Text('Chưa có tài liệu nào.'))
                : ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      return DocumentCard(
                        document: doc,
                        onEdit: () => _openEditScreen(doc),
                        onDelete: () =>
                            widget.controller.deleteDocument(doc.id),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddScreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}
