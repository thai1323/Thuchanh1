import 'package:flutter/material.dart';

import '../../data/models/document_model.dart';

class DocumentCard extends StatelessWidget {
  final DocumentModel document;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const DocumentCard({
    super.key,
    required this.document,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            document.category.isNotEmpty ? document.category[0] : 'T',
          ),
        ),
        title: Text(
          document.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${document.category} • ${document.description}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
