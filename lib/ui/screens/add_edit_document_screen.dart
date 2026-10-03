import 'package:flutter/material.dart';

import '../../data/models/document_model.dart';

class AddEditDocumentScreen extends StatefulWidget {
  final DocumentModel? document;

  const AddEditDocumentScreen({super.key, this.document});

  @override
  State<AddEditDocumentScreen> createState() => _AddEditDocumentScreenState();
}

class _AddEditDocumentScreenState extends State<AddEditDocumentScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _category;
  late String _fileUrl;
  late String _description;

  final List<String> _categories = [
    'Bài giảng',
    'Bài tập',
    'Tài liệu tham khảo',
  ];

  @override
  void initState() {
    super.initState();
    _title = widget.document?.title ?? '';
    _category = widget.document?.category ?? _categories[0];
    _fileUrl = widget.document?.fileUrl ?? '';
    _description = widget.document?.description ?? '';
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final result = DocumentModel(
        id:
            widget.document?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        title: _title,
        category: _category,
        fileUrl: _fileUrl,
        description: _description,
        createdAt: widget.document?.createdAt ?? DateTime.now(),
      );
      Navigator.of(context).pop(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.document != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Sửa tài liệu' : 'Thêm tài liệu mới'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(
                  labelText: 'Tiêu đề tài liệu',
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Vui lòng nhập tiêu đề' : null,
                onSaved: (val) => _title = val!,
              ),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: const InputDecoration(labelText: 'Loại tài liệu'),
                items: _categories.map((cat) {
                  return DropdownMenuItem(value: cat, child: Text(cat));
                }).toList(),
                onChanged: (val) => setState(() => _category = val!),
              ),
              TextFormField(
                initialValue: _fileUrl,
                decoration: const InputDecoration(
                  labelText: 'Đường dẫn File / URL',
                ),
                onSaved: (val) => _fileUrl = val ?? '',
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Mô tả chi tiết'),
                maxLines: 3,
                onSaved: (val) => _description = val ?? '',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text(isEdit ? 'Cập nhật' : 'Thêm mới'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
